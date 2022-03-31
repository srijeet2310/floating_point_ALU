// Name: Srijeet Guha ID: 2019A3PS0280P ----

module MUX2(S,I1,I2,op);
	input S;
	input I1,I2;
	output op;
	assign op=I2&!S | I1&S ;
	// assign op=( I1 & (S0 & S1) | I2 & (S0 & !S1) | I3 & (!S0 & S1) | I4 & (!S0 & !S1) ;
endmodule

module MUX4(S0,S1,I1,I2,I3,I4,op);
	input S0,S1;
	input I1,I2,I3,I4;
	output op;
	assign op=I4&S0&S1 | I3&S0&!S1 | I2&!S0&S1 | I1&!S0&!S1 ;
	// assign op=( I1 & (S0 & S1) | I2 & (S0 & !S1) | I3 & (!S0 & S1) | I4 & (!S0 & !S1) ;
endmodule

module MUX16(S,I,op);
	input[3:0] S;
	input[15:0] I;
	output op;
	wire[3:0] w;
	MUX4 M0(S[1],S[0],I[0],I[1],I[2],I[3],w[0]);
	MUX4 M1(S[1],S[0],I[4],I[5],I[6],I[7],w[1]);
	MUX4 M2(S[1],S[0],I[8],I[9],I[10],I[11],w[2]);
	MUX4 M3(S[1],S[0],I[12],I[13],I[14],I[15],w[3]);

	MUX4 M4(S[3],S[2],w[0],w[1],w[2],w[3],op);
	
endmodule

module MUX16_2x1(S,I1,I2,op);
	input S;
	input [15:0]I1,I2;
	output [15:0]op;
	MUX2 a0(S,I1[15],I2[15],op[15]);
	MUX2 a1(S,I1[14],I2[14],op[14]);
	MUX2 a2(S,I1[13],I2[13],op[13]);
	MUX2 a3(S,I1[12],I2[12],op[12]);
	MUX2 a4(S,I1[11],I2[11],op[11]);
	MUX2 a5(S,I1[10],I2[10],op[10]);
	MUX2 a6(S,I1[9],I2[9],op[9]);
	MUX2 a7(S,I1[8],I2[8],op[8]);
	MUX2 a8(S,I1[7],I2[7],op[7]);
	MUX2 a9(S,I1[6],I2[6],op[6]);
	MUX2 a10(S,I1[5],I2[5],op[5]);
	MUX2 a11(S,I1[4],I2[4],op[4]);
	MUX2 a12(S,I1[3],I2[3],op[3]);
	MUX2 a13(S,I1[2],I2[2],op[2]);
	MUX2 a14(S,I1[1],I2[1],op[1]);
	MUX2 a15(S,I1[0],I2[0],op[0]);
endmodule

module MUX16_2x1_s(S,I1,op);
	input S;
	input [15:0]I1;
	output [15:0]op;
	MUX2 a0(S,I1[15],I1[0],op[15]);
	MUX2 a1(S,I1[14],I1[1],op[14]);
	MUX2 a2(S,I1[13],I1[2],op[13]);
	MUX2 a3(S,I1[12],I1[3],op[12]);
	MUX2 a4(S,I1[11],I1[4],op[11]);
	MUX2 a5(S,I1[10],I1[5],op[10]);
	MUX2 a6(S,I1[9],I1[6],op[9]);
	MUX2 a7(S,I1[8],I1[7],op[8]);
	MUX2 a8(S,I1[7],I1[8],op[7]);
	MUX2 a9(S,I1[6],I1[9],op[6]);
	MUX2 a10(S,I1[5],I1[10],op[5]);
	MUX2 a11(S,I1[4],I1[11],op[4]);
	MUX2 a12(S,I1[3],I1[12],op[3]);
	MUX2 a13(S,I1[2],I1[13],op[2]);
	MUX2 a14(S,I1[1],I1[14],op[1]);
	MUX2 a15(S,I1[0],I1[15],op[0]);
endmodule

//value is to be hard coded to 0
//direction if 1 is right shift and if 0 is left shift

module barrelLR(A,shift,op,direction,val);
	input [15:0]A;
	input direction;
	input [3:0]shift;
	output [15:0]op;
	input val;
	
	wire [15:0]w1,w2;
	MUX16_2x1_s M1(direction,A[15:0],w1);
	barrel b(w1,shift,w2,val);
	MUX16_2x1_s M2(direction,w2[15:0],op);

endmodule

module barrel(A,shift,op,val);
	input [0:15] A;
	input [3:0] shift;
	input val;
	output [0:15] op;

	wire [15:0] w,x,y;
	MUX2 a0_0(shift[0],val,A[0],w[0]);
	MUX2 a0_1(shift[0],A[0],A[1],w[1]);
	MUX2 a0_2(shift[0],A[1],A[2],w[2]);
	MUX2 a0_3(shift[0],A[2],A[3],w[3]);
	MUX2 a0_4(shift[0],A[3],A[4],w[4]);
	MUX2 a0_5(shift[0],A[4],A[5],w[5]);
	MUX2 a0_6(shift[0],A[5],A[6],w[6]);
	MUX2 a0_7(shift[0],A[6],A[7],w[7]);
	MUX2 a0_8(shift[0],A[7],A[8],w[8]);
	MUX2 a0_9(shift[0],A[8],A[9],w[9]);
	MUX2 a0_10(shift[0],A[9],A[10],w[10]);
	MUX2 a0_11(shift[0],A[10],A[11],w[11]);
	MUX2 a0_12(shift[0],A[11],A[12],w[12]);
	MUX2 a0_13(shift[0],A[12],A[13],w[13]);
	MUX2 a0_14(shift[0],A[13],A[14],w[14]);
	MUX2 a0_15(shift[0],A[14],A[15],w[15]);

	MUX2 a1_0(shift[1],val,w[0],x[0]);
	MUX2 a1_1(shift[1],val,w[1],x[1]);
	MUX2 a1_2(shift[1],w[0],w[2],x[2]);
	MUX2 a1_3(shift[1],w[1],w[3],x[3]);
	MUX2 a1_4(shift[1],w[2],w[4],x[4]);
	MUX2 a1_5(shift[1],w[3],w[5],x[5]);
	MUX2 a1_6(shift[1],w[4],w[6],x[6]);
	MUX2 a1_7(shift[1],w[5],w[7],x[7]);
	MUX2 a1_8(shift[1],w[6],w[8],x[8]);
	MUX2 a1_9(shift[1],w[7],w[9],x[9]);
	MUX2 a1_10(shift[1],w[8],w[10],x[10]);
	MUX2 a1_11(shift[1],w[9],w[11],x[11]);
	MUX2 a1_12(shift[1],w[10],w[12],x[12]);
	MUX2 a1_13(shift[1],w[11],w[13],x[13]);
	MUX2 a1_14(shift[1],w[12],w[14],x[14]);
	MUX2 a1_15(shift[1],w[13],w[15],x[15]);

	MUX2 a2_0(shift[2],val,x[0],y[0]);
	MUX2 a2_1(shift[2],val,x[1],y[1]);
	MUX2 a2_2(shift[2],val,x[2],y[2]);
	MUX2 a2_3(shift[2],val,x[3],y[3]);
	MUX2 a2_4(shift[2],x[0],x[4],y[4]);
	MUX2 a2_5(shift[2],x[1],x[5],y[5]);
	MUX2 a2_6(shift[2],x[2],x[6],y[6]);
	MUX2 a2_7(shift[2],x[3],x[7],y[7]);
	MUX2 a2_8(shift[2],x[4],x[8],y[8]);
	MUX2 a2_9(shift[2],x[5],x[9],y[9]);
	MUX2 a2_10(shift[2],x[6],x[10],y[10]);
	MUX2 a2_11(shift[2],x[7],x[11],y[11]);
	MUX2 a2_12(shift[2],x[8],x[12],y[12]);
	MUX2 a2_13(shift[2],x[9],x[13],y[13]);
	MUX2 a2_14(shift[2],x[10],x[14],y[14]);
	MUX2 a2_15(shift[2],x[11],x[15],y[15]);

	MUX2 a3_0(shift[3],val,y[0],op[0]);
	MUX2 a3_1(shift[3],val,y[1],op[1]);
	MUX2 a3_2(shift[3],val,y[2],op[2]);
	MUX2 a3_3(shift[3],val,y[3],op[3]);
	MUX2 a3_4(shift[3],val,y[4],op[4]);
	MUX2 a3_5(shift[3],val,y[5],op[5]);
	MUX2 a3_6(shift[3],val,y[6],op[6]);
	MUX2 a3_7(shift[3],val,y[7],op[7]);
	MUX2 a3_8(shift[3],y[0],y[8],op[8]);
	MUX2 a3_9(shift[3],y[1],y[9],op[9]);
	MUX2 a3_10(shift[3],y[2],y[10],op[10]);
	MUX2 a3_11(shift[3],y[3],y[11],op[11]);
	MUX2 a3_12(shift[3],y[4],y[12],op[12]);
	MUX2 a3_13(shift[3],y[5],y[13],op[13]);
	MUX2 a3_14(shift[3],y[6],y[14],op[14]);
	MUX2 a3_15(shift[3],y[7],y[15],op[15]);

endmodule

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

module setOutput (inMan, inExp, inSign, op);
	input [15:0] inMan;
	input [5:0] inExp;
	input inSign;
	output reg [15:0] op;
	always @ (*) begin 
		if((inMan == 16'd0) && (inExp == 6'd0)) begin
			op[15] = 1'b0;
			op[14:10] = 5'd0;
			op[9:0] = 10'd0;
		end
		else begin
			op[15] = inSign;
			op[14:10] = inExp[4:0];
			op[9:0] = inMan[11:2];
		end
	end
endmodule


module adjustOutput (man, exp, sign, op, exception);
	input [15:0] man;
	input [5:0] exp;
	input sign;
	
	output [15:0] op;
	output [1:0] exception;
	
	wire [15:0] tempMan1, tempMan2;
	wire [5:0] tempExp1, tempExp2;
	wire [1:0] tempException;
	
	adjustMantissa am (man, exp, tempMan1, tempExp1, tempException);
	roundUp ru (tempMan1, tempExp1, tempMan2, tempExp2, exception);
	setOutput so (tempMan2, tempExp2, sign, op);
	
endmodule

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

module tb_hp_adder ();
	reg [15:0] A, B;
	wire [15:0] op;
	wire [1:0] excep;
	
	tb_hp_adder uut(A, B, op, excep);
	initial
		begin
			$dumpfile("test.vcd");
			$dumpvars;
			
			A = 16'h7BFF; 
            B = 16'h7BFF; 
			
			 #10 
			A = 16'h5246;
            B = 16'h53B4; 

            #10 
			A = 16'h5246; 
            B = 16'hD3B4;

            #10 
			A = 16'h0801; 
            B = 16'h0401; 

            #10
			A = 16'h8801; 
            B = 16'h0401;

            #10 
			A = 16'hFC85;
            B = 16'h0401;

            #10 
			A = 16'h82ED;
            B = 16'h0401;
			
            #10 
			A = 16'h7000; 
            B = 16'hf030;

            #10 
			A =16'h0800;
            B =16'h0a00;

			#10
			A = 16'h1104;
            B = 16'h1162;
      
            #10 
			A = 16'h1506;
            B = 16'h1210;
      
            #10 
			A = 16'h5E90;
            B = 16'h5450;

            #10 
			A = 16'hfc00;
            B = 16'h0401;

            #10 
			A = 16'h0000;
            B = 16'h0000;

            #10 
			A = 16'h3152;
            B = 16'h3158;

			#10 
			A = 16'h7BFF; 
            B = 16'h7801; 

            #10 
			A = 16'h4920; 
            B = 16'h0000; 

            #10 
			A = 16'h4920; 
            B = 16'h8000; 

            #10 
			A = 16'h0400; 
            B = 16'h8401; 
            
            #10 
			A = 16'hC900; 
            B = 16'h4800; 
			
			#10
			$finish;
		end
		
endmodule
