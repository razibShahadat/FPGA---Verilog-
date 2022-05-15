module sevSeg_button_counter(
    input clock_50Mhz,               // 50 Mhz clock source on Altera FPGA
	 input button,
	 input reset,
    output reg [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output reg [6:0] LED_SEG         // cathode patterns of the 7-segment LED display
    );
    	
    reg [15:0] displayed_number;     // counting number to be displayed
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter;      // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate  
	                                  // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    wire [1:0] LED_activating_counter;   // count     0    ->  1  ->  2  ->  3 // activates    LED1    LED2   LED3   LED4    // and repeat
	
	 reg [24:0]button_pressed, button_not_pressed;
	 reg button_state = 1'b1;
   

	always @(posedge clock_50Mhz or negedge reset)
    begin 
	 
	 if (!reset)
	     begin
		      displayed_number    <= 15'b0;
				button_pressed      <= 25'b0;
				button_not_pressed  <= 25'b0;
		  end
	
	else
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
			displayed_number = displayed_number + 1'b1;
			button_pressed <= 25'b0;
			button_state = 1'b1;
		 end
	///////////////////////////////////////////////////	 
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
end
	 
	 always @(posedge clock_50Mhz)
    begin 
        refresh_counter <= refresh_counter + 1;
    end    

	assign LED_activating_counter = refresh_counter[19:18];   // anode activating signals for 4 LEDs, digit period of 2.6ms  
   
	always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111;                       // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = displayed_number/1000;                // the first digit of the 16-bit number
              end
        2'b01: begin
            Anode_Activate = 4'b1011;                       // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (displayed_number % 1000)/100;        // the second digit of the 16-bit number
              end
        2'b10: begin
            Anode_Activate = 4'b1101;                       // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = ((displayed_number % 1000)%100)/10;   // the third digit of the 16-bit number
                end
        2'b11: begin
            Anode_Activate = 4'b1110;                       // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = ((displayed_number % 1000)%100)%10;   // the fourth digit of the 16-bit number    
               end
        endcase
    end   
	
    always @(*)  
	 
	 begin
        case(LED_BCD)
        4'b0000: LED_SEG = 7'b1000000; // "0"     
        4'b0001: LED_SEG = 7'b1111001; // "1" 
        4'b0010: LED_SEG = 7'b0100100; // "2" 
        4'b0011: LED_SEG = 7'b0110000; // "3" 
        4'b0100: LED_SEG = 7'b0011001; // "4" 
        4'b0101: LED_SEG = 7'b0010010; // "5" 
        4'b0110: LED_SEG = 7'b0000010; // "6" 
        4'b0111: LED_SEG = 7'b1111000; // "7" 
        4'b1000: LED_SEG = 7'b0000000; // "8"     
        4'b1001: LED_SEG = 7'b0010000; // "9" 
        default: LED_SEG = 7'b1000000; // "0"
        endcase
    end
 endmodule
 