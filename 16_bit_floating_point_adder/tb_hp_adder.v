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
			A = 16'h7000; 
            B = 16'hf030;

            #10 
			A =16'h0800;
            B =16'h0a00;

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
			A = 16'hfc00;
            B = 16'h0401;

            #10 
			A = 16'h0000;
            B = 16'h0000;

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
			$finish;
		end
		
endmodule