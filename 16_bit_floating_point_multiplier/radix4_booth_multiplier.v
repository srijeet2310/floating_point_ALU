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