`include "radix4_booth_multiplier.v"

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
	
	always @(*) begin
		
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