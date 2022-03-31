module tb_barrel_shift_16bit ();
	reg [15:0] in;
	reg [3:0] ctrl;
	wire [15:0] out; 
	barrelLR uut(in, ctrl, out, 1'b0, 1'b0);
	initial
		begin
			$dumpfile("test.vcd");
			$dumpvars;
			
			in=16'd16385; ctrl=4'd0; //shift 0 bit;
			#5 in=16'd16385; ctrl=4'd1; //shift 1 bits;
			#5 in=16'd16385; ctrl=4'd2; //shift 2 bits;
			#5 in=16'd16385; ctrl=4'd3; //shift 3 bits;
			#5 in=16'd16385; ctrl=4'd4; //shift 4 bits;
			#5 in=16'd16385; ctrl=4'd5; //shift 5 bits;
			#5 in=16'd16385; ctrl=4'd6; //shift 6 bits;
			#5 in=16'd16385; ctrl=4'd7; //shift 7 bits;
			#5 in=16'd16385; ctrl=4'd8; //shift 8 bits;
			#5 in=16'd16385; ctrl=4'd9; //shift 9 bits;
			#5 in=16'd16385; ctrl=4'd10; //shift 10 bits;
			#5 in=16'd16385; ctrl=4'd11; //shift 11 bits;
			#5 in=16'd16385; ctrl=4'd12; //shift 12 bits;
			#5 in=16'd16385; ctrl=4'd13; //shift 13 bits;
			#5 in=16'd16385; ctrl=4'd14; //shift 14 bits;
			#5 in=16'd16385; ctrl=4'd15; //shift 15 bits;
			#5 $finish;
		end
		
endmodule


