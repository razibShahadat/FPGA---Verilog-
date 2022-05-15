module led_button_count(
              input clk, 
				  input button,
				  output [3:0]led
				 );
				 
	reg [3:0]count;
	reg [24:0]button_pressed, button_not_pressed;
	reg button_state = 1'b1;
	
	
	
	always @(posedge clk)
	  begin
	    if (!button & !button_state)
		     begin
			     button_pressed <=  button_pressed + 1'b1;
			  end
		else
	    begin	
		  button_pressed <= 25'b0;
		 end
		
		if(button_pressed == 25'd1000000)		
		 begin
			count = count + 1'b1;
			button_pressed <= 25'b0;
			button_state = 1'b1;
			if (count >= 10)
			count = 0;
		 end
	////////////////////////////////	 
		 if(button & button_state)
			begin
			button_not_pressed <= button_not_pressed + 1'b1;		
			end

		else
			begin
			button_not_pressed <= 25'b0;
			end

		if(button_not_pressed == 25'd1000000)
			begin
			button_not_pressed <= 25'b0;
			button_state = 1'b0;
			end
		end		
		
		assign led[3:0] = count[3:0];

endmodule