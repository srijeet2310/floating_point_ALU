// Name: Srijeet Guha ID: 2019A3PS0280P ----

module radix4_booth_multiplier (manA, manB, product); 
	//radix4_booth_multiplier
	input [12:0] manA;
	input [12:0] manB;
   
	output reg [25:0] product;
	
	reg [12:0] m, m2, m1, m21, sum;
	reg [2:0] mult, j;
	
	always @ (*) begin
	
		j = 3'b0;
		m = manA;
		m2 = manA << 1'b1;
		m1 = ~manA + 13'd1;
		m21 = m1 << 1'b1;
		product = {13'b0, manB}; 
		
		while (j < 6) begin
			mult = product[2:0];
			case (mult)
				3'b000:	sum = product[25:13];
				3'b001:	sum = product[25:13] + m;
				3'b010:	sum = product[25:13] + m;
				3'b011:	sum = product[25:13] + m2;
				3'b100:	sum = product[25:13] + m21;
				3'b101:	sum = product[25:13] + m1;
				3'b110:	sum = product[25:13] + m1;
				3'b111:	sum = product[25:13];
			endcase
			product = {sum[12], sum[12], sum[12:0], product[12:2]};
			j = j + 1;
		end
		
	end
endmodule

module multiplier (A, B, op, exceptions);
	input [15:0] A, B;
	
	output reg [15:0] op;
	output reg [1:0] exceptions;
	
	reg [9:0] manA, manB;
	reg [4:0] expA, expB;
	reg signA, signB;
	
	reg [5:0] exp_product;
	reg sign_product;
    reg [9:0] man_product;
	reg [12:0] booth_manA, booth_manB;
	wire [25:0] booth_product;

    reg[5:0] exp_product_flow;
    reg[1:0] normCheck;
	
    radix4_booth_multiplier a1 (booth_manA, booth_manB, booth_product);
	
	always @ (*) begin
		
		signA = A[15];
		expA = A[14:10];
		manA = A[9:0];
		signB = B[15];
		expB = B[14:10];
		manB = B[9:0];
		
		exp_product = expA + expB - 5'd15;
		sign_product = signA ^ signB;
			
		#100;
        booth_manA = {3'b001, manA};
		booth_manB = {2'b01, manB, 1'b0};
        #100;
		
		exp_product_flow = {1'b0, exp_product} + 5'd15;
		if (exp_product_flow < 6'd16) begin
			$display("Exception - Underflow\n");
			exceptions = 2'b10;
			op = 16'bx;
		end
		else if (exp_product_flow > 6'd45) begin
			$display("Exception - Overflow\n");
			exceptions = 2'b01;
			op = 16'bx;
		end
		else begin
			$display("Valid Output\n");
			op = {sign_product, exp_product[4:0], man_product};
			exceptions = 2'b00;
		end
	end
endmodule

module hp_multiplier (hp_inA, hp_inB, hp_product, Exceptions);
	input [15:0] hp_inA, hp_inB;
	output [15:0] hp_product;
	output [1:0] Exceptions;
	
	multiplier m (hp_inA, hp_inB, hp_product, Exceptions);
endmodule

module tb_hp_multiplier ();
	reg [15:0] A, B;
	wire [15:0] op;
	wire [1:0] excep;
	
	tb_hp_multiplier uut(A, B, op, excep);
	
	initial
		begin
			$dumpfile("test.vcd");
			$dumpvars;
			
			A = 16'h7BFF;
            B = 16'h7BFF;
            
			#10 
			A = 16'h3152;
            B = 16'h3158;

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
			A = 16'hC900; 
            B = 16'h4800; 

            #10 
			A = 16'h7000; 
            B = 16'hf030;

            #10 
			A =16'h0800;
            B =16'h0a00;

            #10 
			A = 16'h5246;
            B = 16'h53B4; 
			
			#10 
			A = 16'h0400;
            B = 16'h0400;

            #10 
			A = 16'h3800;
            B = 16'h0000;


            #10 
			A = 16'h4D20; 
            B = 16'h4959;

            #10 
			A = 16'hfc00;
            B = 16'h0401;

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
			A = 16'h7BFF;
            B = 16'h3C0A;

            #10 
			A = 16'h63FF; 
            B = 16'h4100; 

            #10 
			A = 16'h0400;
            B = 16'h3800;

            #10 
			A = 16'h0000;
            B = 16'h0000;
			
			#10
			$finish;
		end
		
endmodule
