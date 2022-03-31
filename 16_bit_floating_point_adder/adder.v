`include "adjustOutput.v"

module f_adder(A, B, exception, op);
	input [15:0] A, B;
	output reg [1:0] exception;
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
	
	reg [5:0] tempExp, shift;
	wire [3:0] fshift;
	reg [15:0] greatMan, lessMan, tempMan;
	wire [15:0] man1, man2, addMan, subMan, fop;
	wire [1:0] fexception;
	reg netSign;
	reg flag;   //0 means output ready, 1 means output not ready (exception included)
	
	
	always @ (*) begin
	
		if((expA == 6'd31) && (manA != 16'd0)) begin //A is NAN
			exception  = 2'b11;
			op = A;
			flag = 1'b0;
		end
		
		else if ((expB == 6'd31) && (manB != 16'd0)) begin //B is NAN
			exception = 2'b11;
			op = B;
			flag = 1'b0;
		end
	
		else if(expA == 6'd0) begin //A is 0
			exception = 2'b00;
			op = B;
			flag = 1'b0;
		end
		
		else if(expB == 6'd0) begin //B is 0
			exception = 2'b00;
			op = A;
			flag = 1'b0;
		end
		
		else if ((expA == 6'd31) && (manA == 16'd0) && (expB == 6'd31) && (manB == 16'd0) && (signA ^ signB == 1'b1)) begin //both are infi of opp sign
			exception = 2'b11;
			op[15:1] = A[15:1];
			op[0] = 1'b1;
			flag = 1'b0;
		end
		
		else if((expA == 6'd31) && (manA == 16'd0)) begin//A is infi
			op = A;
			exception = 2'b01;
			flag = 1'b0;
		end
		
		else if((expB == 6'd31) && (manB == 16'd0)) begin // B is infi
			op = B;
			exception = 2'b01;
			flag = 1'b0;
		end 
		
		else begin
			if((expA > expB) || ((expA == expB) && (manA > manB))) begin
				tempExp[4:0] = expA;
				tempExp[5] = 1'b0;
				greatMan = manA;
				lessMan = manB;
				shift = expA - expB;
				if(shift > 6'b001100) begin
					op = A;
					exception = 2'b00;
					flag = 1'b0;
				end
				else begin
					flag = 1'b1;
					netSign = signA;
				end	
			end
				
			else if((expB > expA) || ((expA == expB) && (manB > manA))) begin
				tempExp[4:0] = expB;
				tempExp[5] = 1'b0;
				greatMan = manB;
				lessMan = manA;
				shift = expB - expA;
				if(shift > 6'b001100) begin
					op = B;
					exception = 2'b00;
					flag = 1'b0;
				end
				else begin
					flag = 1'b1;
					netSign = signB;
				end	
			end
			
			else if (signA == signB) begin
				tempExp[4:0] = expA;
				tempExp[5] = 1'b0;
				greatMan = manA;
				lessMan = manB;
				shift = expA - expB;
				flag = 1'b1;
				netSign = signA;
			end
			
			else begin
				op = 16'd0;
				exception = 2'b00;
				flag = 1'b0;
			end
		end		
	end 
	
	assign fshift = shift[3:0];
	assign man1 = greatMan;
	barrelLR s1 (lessMan, fshift, man2, 1'b1, 1'b0);
	assign addMan = man1 + man2;
	assign subMan = man1 - man2;
	
	always @ (*) begin
		if(flag == 1'b1) begin
			if(signA ^ signB == 1'b0) begin
				//do addition
				tempMan = addMan;
			end
			else begin
				//do subtraction
				tempMan = subMan;
			end
		end
	end
	
	// I have now ::
	// [16:0] tempMan
	// 1 netSign
	// [5:0] tempExp
	// no exception filled till now
	
	adjustOutput a1 (tempMan, tempExp, netSign, fop, fexception);
	
	always @ (*) begin 
		if (flag == 1'b1) begin
			op = fop;
			exception = fexception;
		end
	end

endmodule

module hp_adder (hp_inA, hp_inB, hp_sum, Exceptions);
	input [15:0] hp_inA, hp_inB;
	output [15:0] hp_sum;
	output [1:0] Exceptions;
	
	f_adder f (hp_inA, hp_inB, Exceptions, hp_sum);
endmodule
