module blink (
 
input clk,
output  LED    
);
 
    reg [32:0] counter;
    reg state;
    assign LED = state;
    
	 always @ (posedge clk)
     begin
        counter <= counter + 1;
        state <= counter[26]; // Changes when MSB changes
    end
 
endmodule



