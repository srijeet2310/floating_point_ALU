`include "roundUp.v"
`include "setOutput.v"

module f_adder(A, B, exception, op);
	input [15:0] A, B;
	input [1:0] exception;
	output reg [15:0] op;

	wire signA,signB;
	wire [5:0] expA,expB;
	wire [15:0] manA,manB;

	assign signA = A[15];
	assign signB = B[15];
	
	//6 bit exponent
	//[5] : overflow bits
	//[[4:0] : exponent bits
	
	assign expA[4:0] = A[14:10];
	assign expB[4:0] = B[14:10];
	assign expA[5] = 1'b0;
	assign expB[5] = 1'b0;
	
	//16 bit mantissa has the following format
	//[15:13] : overflow bits
	//[12] : 1 bit
	//[11:2] : mantissa bits
	//[1:0] : guard and round bits
	
	assign manA[11:2] = A[9:0];
	assign manB[11:2] = B[9:0];
	
	assign manA[1:0] = 2'b00;
	assign manB[1:0] = 2'b00;
	
	assign manA[12] = 1'b1;
	assign manB[12] = 1'b1;
	assign manA[15:13] = 3'b000;
	assign manB[15:13] = 3'b000;
	
	wire [5:0] tempExp, finalExp, fexp;
	wire [15:0] shiftedManA, shiftedManB, tempMan, tempManTemp, fman;
	wire [1:0] tempException;
	wire netSign;
	
	wire [5:0] shift;
	wire [3:0] fshift;

	always @ (*) begin
	
		if((expA == 6'd31) && (manA != 16'd0)) begin //A is NAN
			exception  = 2'b11;
			op = A;
		end
		
		else if ((expB == 6'd31) && (manB != 16'd0)) begin //B is NAN
			exception = 2'b11;
			op = B;
		end
	
		else if(expA == 6'd0) begin //A is 0
			exception = 2'b00;
			op = B;
		end
		
		else if(expB == 6'd0) begin //B is 0
			exception = 2'b00;
			op = A;
		end
		
		else if ((expA == 6'd31) && (manA == 16'd0) && (expB == 6'd31) && (manB == 16'd0) && (signA ^ signB == 1'b1)) begin //both are infi of opp sign
			exception = 2'b11;
			op[15:1] = A[15:1];
			op[0] = 1'b1;
		end
		
		else if((expA == 6'd31) && (manA == 16'd0)) begin//A is infi
			op = A;
			exception = 2'b01;
		end
		
		else if((expB == 6'd31) && (manB == 16'd0)) begin // B is infi
			op = B;
			exception = 2'b01;
		end 
		
		else begin
			if((expA > expB) || ((expA == expB) && (manA > manB))) begin
				//shift manB
				tempExp[4:0] = expA;
				tempExp[5] = 1'b0;
				shiftedManA = manA;
				shift = expA - expB;
				if(shift > 6'b001100) begin
					op = A;
				end
				else begin
					fshift = shift[3:0];
					barrelLR s1 (manB, fshift, shiftedManB, 1'b1, 1'b0);
					if(signA ^ signB == 1'b0) begin
						// do addition
						tempManTemp = shiftedManA + shiftedManB;
					end 
					else begin
						//do subtraction A is bigger
						tempManTemp = shiftedManA - shiftedManB;
					end
				
					adjustMantissa am1 (tempManTemp, tempExp, tempMan, finalExp, tempException);
					roundUp ru1 (tempMan, finalExp, fman, fexp, exception);
					setOutput so1 (fman, fexp, signA, op);
				end	
			end
				
			else if((expB > expA) || ((expA == expB) && (manA == manB))) begin
				//shift manB
				tempExp[4:0] = expB;
				tempExp[5] = 1'b0;
				shiftedManB = manB;
				shift = expB - expA;
				if(shift > 6'b001100) begin
					op = B;
				end
				else begin
					fshift = shift[3:0];
					barrelLR s1 (manA, fshift, shiftedManA, 1'b1, 1'b0);
					if(signA ^ signB == 1'b0) begin
						// do addition
						tempManTemp = shiftedManA + shiftedManB;
					end 
					else begin
						//do subtraction A is bigger
						tempManTemp = shiftedManB - shiftedManA;
					end
				
					adjustMantissa am1 (tempManTemp, tempExp, tempMan, finalExp, tempException);
					roundUp ru1 (tempMan, finalExp, fman, fexp, exception);
					setOutput so2 (fman, fexp, signB, op);
				end	
			end
			
			else begin
				fman = 16'd0;
				fexp = 6'd0;
				so3 (fman, fexp, signA, op);
			end
		end		
	end 
endmodule