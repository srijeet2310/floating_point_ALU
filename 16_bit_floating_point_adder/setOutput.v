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
