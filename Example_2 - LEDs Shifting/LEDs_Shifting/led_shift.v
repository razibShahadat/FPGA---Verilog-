module led_shift(
            input clk,
				output reg [3:0]LEDs
				);
				
	reg [31:0] counter;
   reg [3:0]one_sec_count;	
	reg [3:0] value;
		
	always @(posedge clk)
		begin
		    		 
		    if (counter >= 25000000)
			   begin		        
				  one_sec_count = one_sec_count + 1'b1;
				  counter <= 0;				  
				  if (one_sec_count > 7)
				      one_sec_count = 0;
			   end
          else 
            begin
              counter <= counter + 1;	
				end  
		end
		
	always @(*)
	   begin 
		  case(one_sec_count)
		    0: LEDs = 4'b1110;
			 1: LEDs = 4'b1100;
			 2: LEDs = 4'b1000;
			 3: LEDs = 4'b0000;
			 4: LEDs = 4'b1000;
			 5: LEDs = 4'b1100;
			 6: LEDs = 4'b1110;
			 7: LEDs = 4'b1111;
			 default LEDs = 4'b1111;
			endcase
		end	
endmodule 