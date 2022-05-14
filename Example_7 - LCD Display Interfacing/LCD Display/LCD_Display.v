module LCD_Display(clk, lcd_e, lcd_rw, lcd_rs, data);

input clk;
output reg lcd_e, lcd_rw, lcd_rs;
output reg [7:0] data;
integer i = 0;
integer j = 1;

reg [7:0] Datas [1:37];

		
always @(posedge clk) begin
Datas[1]   =  8'h38;   	//-- control instruction : configure - 2 lines, 5x7 matrix --
Datas[2]   =  8'h0C;   	//-- control instruction : Display on, cursor off --
Datas[3]   =  8'h06;   	//-- control instruction : Increment cursor : shift cursor to right --
Datas[4]   =  8'h01;   	//-- control instruction : clear display screen --
Datas[5]   =  8'h80;   	//-- control instruction : force cursor to begin at first line --

Datas[6]   =  "H";  
Datas[7]   =  "e";  
Datas[8]   =  "l";  
Datas[9]   =  "l";  
Datas[10]  =  "o";  
Datas[11]  =  " "; 

Datas[12]  =  "W";  
Datas[13]  =  "o";  
Datas[14]  =  "r";  
Datas[15]  =  "l";  
Datas[16]  =  "d";

Datas[17]  =  " "; 
Datas[18]  =  " "; 
Datas[19]  =  " "; 
Datas[20]  =  " "; 

Datas[21] = 8'hC0;
Datas[22] = "F";
Datas[23] = "P";
Datas[24] = "G";
Datas[25] = "A";
Datas[26]  =  " ";
 
Datas[27]  =  "f"; 
Datas[28]  =  "o"; 
Datas[29]  =  "r"; 
Datas[30]  =  " "; 

Datas[31]  =  "F"; 
Datas[32]  =  "U"; 
Datas[33]  =  "N"; 

Datas[34]  =  " "; 
Datas[35]  =  " "; 
Datas[36]  =  " "; 

end		
		
always @(posedge clk) begin

//-- Delay for writing data

  lcd_rw = 0;
  
  if (i <= 1000000) begin
  i = i + 1; lcd_e = 1;
  data = Datas[j];
  end
  
  else if (i > 1000000 & i < 2000000) begin
  i = i + 1; lcd_e = 0;
  end
  
  else if (i == 2000000) begin
  j = j + 1; i = 0;
  end
  else i = 0;
  
 //-- LCD_RS signal should be set to 0 for writing commands and to 1 for writing data
/*
  if (j <= 5 ) lcd_rs = 0;  
  else if (j > 5 & j< 22) lcd_rs = 1;   
  else if (j == 22) lcd_rs = 0;
  else if (j > 22) begin 
  lcd_rs = 1; j = 5;
  */
  
  if (j <= 5) lcd_rs = 0; 
  else if (j > 5 & j< 21) lcd_rs = 1;   
  else if (j == 21) lcd_rs = 0;
  else if (j > 21 & j < 37) lcd_rs = 1;
  else if (j == 37) 
  begin lcd_rs = 1; j = 5;
  end
 
 end
 
endmodule


/*
Datas[6]   =  8'h46;   	//-- F --
Datas[7]   =  8'h50;   	//-- P --
Datas[8]   =  8'h47;   	//-- G --
Datas[9]   =  8'h41;   	//-- A --
Datas[10]  =  8'h73;   	//-- s --
Datas[11]  =  8'h20;   	//--   --

Datas[12]  =  8'h61;   	//-- a --
Datas[13]  =  8'h72;   	//-- r --
Datas[14]  =  8'h65;   	//-- e --

Datas[15]  =  8'h20;   	//--   --
Datas[16]  =  8'h66;   	//-- f --
Datas[17]  =  8'h75;   	//-- u --
Datas[18]  =  8'h6E;   	//-- n --

Datas[19]  =  8'h21;   	//-- ! --
Datas[20]  =  8'h21;   	//-- ! --
Datas[21]  =  8'h21;   	//-- ! --
*/