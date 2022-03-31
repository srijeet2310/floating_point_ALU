`include "barrel_shifter_16bit.v"

module adjustMantissa (in, exp, out, outExp, exception);
	input [15:0] in;
	input [5:0] exp;
	output reg [15:0] out;
	output reg [5:0] outExp;
	output reg [1:0] exception;
	
	reg [15:0] temp;
	reg [5:0] tempExp;
	wire [15:0] temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14;
	
	barrelLR S2 (in, 4'd1, temp2, 1'b1, 1'b0);
	barrelLR S3 (in, 4'd1, temp3, 1'b0, 1'b0);
	barrelLR S4 (in, 4'd2, temp4, 1'b0, 1'b0);
	barrelLR S5 (in, 4'd3, temp5, 1'b0, 1'b0);
	barrelLR S6 (in, 4'd4, temp6, 1'b0, 1'b0);
	barrelLR S7 (in, 4'd5, temp7, 1'b0, 1'b0);
	barrelLR S8 (in, 4'd6, temp8, 1'b0, 1'b0);
	barrelLR S9 (in, 4'd7, temp9, 1'b0, 1'b0);
	barrelLR S10 (in, 4'd8, temp10, 1'b0, 1'b0);
	barrelLR S11 (in, 4'd9, temp11, 1'b0, 1'b0);
	barrelLR S12 (in, 4'd10, temp12, 1'b0, 1'b0);
	barrelLR S13 (in, 4'd11, temp13, 1'b0, 1'b0);
	barrelLR S14 (in, 4'd12, temp14, 1'b0, 1'b0);
	
	always @ (*) begin 
		if (in[13] == 1'b1) begin
			temp = temp2;
			tempExp = exp + 1'b1;
			if(tempExp > 6'd30) begin
				outExp = 6'd31;
				out = 16'd0;
				exception = 2'b01;
			end
			else begin
				outExp = tempExp;
				out = temp;
				exception = 2'b00;
			end
		end
	
		else begin
			if (in[12] == 1'b1) begin
				temp = in;
				tempExp = 6'd0;
			end
			else if (in[11] == 1'b1) begin
				temp = temp3;
				tempExp = 6'd1;
			end
			else if (in[10] == 1'b1) begin
				temp = temp4;
				tempExp = 6'd2;
			end
			else if (in[9] == 1'b1) begin
				temp = temp5;
				tempExp = 6'd3;
			end
			else if (in[8] == 1'b1) begin
				temp = temp6;
				tempExp = 6'd4;
			end
			else if (in[7] == 1'b1) begin
				temp = temp7;
				tempExp = 6'd5;
			end
			else if (in[6] == 1'b1) begin
				temp = temp8;
				tempExp = 6'd6;
			end
			else if (in[5] == 1'b1) begin
				temp = temp9;
				tempExp = 6'd7;
			end
			else if (in[4] == 1'b1) begin
				temp = temp10;
				tempExp = 6'd8;
			end
			else if (in[3] == 1'b1) begin
				temp = temp11;
				tempExp = 6'd9;
			end
			else if (in[2] == 1'b1) begin
				temp = temp12;
				tempExp = 6'd10;
			end
			else if (in[1] == 1'b1) begin
				temp = temp13;
				tempExp = 6'd11;
			end
			else begin
				temp = temp14;
				tempExp = 6'd12;
			end
		
			if(exp > tempExp) begin
				out = temp;
				outExp = exp - tempExp;
				exception = 2'b00;
			end
			else begin
				out = 16'd0;
				outExp = 6'd0;
				exception = 2'b00;
			end
		end
	end
endmodule
