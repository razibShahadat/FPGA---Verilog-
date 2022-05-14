module ledSw(
         input [3:0]SW,
			output[3:0]LED
			);
			
	assign LED = SW;

endmodule


/*
module ledSw(
         input [3:0]SW,
			output[3:0]LED
			);
 
 reg state;			
 assign LED[0] = state;
 
  always @ (*)
      begin
		if (SW[0] == 0)
		  state = 0;
		else 
		    state = 1;
	   end 
endmodule
*/