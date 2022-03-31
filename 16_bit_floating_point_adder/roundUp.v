`include "adjustMantissa.v"

module roundUp (inMan, inExp, outMan, outExp, exception);
	input [15:0] inMan;
	input [5:0] inExp;
	output reg [15:0] outMan;
	output reg [5:0] outExp;
	output reg [1:0] exception;
	
	wire [15:0] tempMan;
	wire [5:0] tempExp;
	
	wire [15:0] outMan1;
	wire [5:0] outExp1;
	wire [1:0] exception1;
	
	assign tempMan = inMan + 3'b100;
	adjustMantissa am2 (tempMan, inExp, outMan1, outExp1, exception1);
	
	always @ (*) begin 
	
		if(inMan[1] == 1'b1) begin 
			outMan = outMan1;
			outExp = outExp1;
			exception = exception1;
		end
		else begin
			outMan = inMan;
			outExp = inExp;
			exception = 2'b00;
		end
	end
endmodule