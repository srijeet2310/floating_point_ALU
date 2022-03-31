`include "roundUp.v"
`include "setOutput.v"

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

//adjustMantissa am1 (tempManTemp, tempExp, tempMan, finalExp, tempException);
//roundUp ru1 (tempMan, finalExp, fman, fexp, exception);
//setOutput so2 (fman, fexp, signB, op);

