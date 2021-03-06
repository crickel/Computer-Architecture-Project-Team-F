module Control_Unit(
op_in,
func_in,
regWrite, 
regDst, 
ALUSrc, 
branch, 
memWrite, 
memToReg,
memRead, 
jump,
ALUCntrl
);
   
input [5:0] op_in, func_in;
   
wire [3:0] ALUCntrl_out;
wire branch_out, jump_out;				
wire regWrite_out, regDst_out; 
wire ALUSrc_out;
wire memWrite_out, memRead_out, memToReg_out;

output regWrite, regDst, ALUSrc, branch, memWrite, memToReg, memRead, jump;
output [3:0] ALUCntrl;

parameter
ADD		= 6'b100_000,
SUB		= 6'b100_010,
OR		= 6'b100_101,
SLT		= 6'b100_010,
AND		= 6'b100_100,
ADDI	= 6'b001_000,
LW		= 6'b100_011,
SW		= 6'b101_011,
BEQ		= 6'b000_100,
J		= 6'b000_010,
DONTCARE= 6'bxxx_x,
ZERO	= 6'b000_000;

assign regWrite_out = 	(op_in == ADDI)	||
						(op_in == LW)	||
						(op_in == ZERO);
						

assign regDst_out	= 	op_in == ZERO;
						 
assign ALUSrc_out	= 	(op_in == ADDI)	||
						(op_in == LW)	||
						(op_in == SW);
						
assign branch_out	= 	op_in == BEQ;
						
assign memWrite_out = 	op_in == SW;
						
assign memToReg_out = 	op_in == LW;

assign memRead_out 	=	op_in == LW;
						
assign ALUCntrl_out		= 	//(op_in == ZERO && func_in == ADD) 		? 4'b0000 :
											(op_in == ZERO && func_in == SUB) 		? 4'b0001 :
											(op_in == ZERO && func_in == AND) 		? 4'b0010 :
											(op_in == ZERO && func_in == SLT)		  ? 4'b0100 :
											(op_in == ZERO && func_in == OR)  		? 4'b0101 :
											(op_in == ZERO && func_in == SLT)		  ? 4'b0100 :
											(op_in == LW && func_in == DONTCARE)	? 4'b1000 :
											(op_in == SW && func_in == DONTCARE)	? 4'b1000 :
											
											//(op_in == ADDI && func_in == DONTCARE)? 4'b0000 :
											(op_in == BEQ && func_in == DONTCARE)	? 4'b1000 : 1'b0;
											

						
assign jump_out		= 	op_in == J;

assign regWrite		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : regWrite_out;
assign regDst		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : regDst_out;
assign ALUSrc		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : ALUSrc_out;
assign branch		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : branch_out;
assign memWrite		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : memWrite_out;
assign memToReg		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : memToReg_out;
assign memRead		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : memRead_out;
assign jump			= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : jump_out;
assign ALUCntrl		= 	(op_in == ZERO && func_in == ZERO) ? 4'b0 : ALUCntrl_out;

endmodule 


