module Control_Unit(
op_in,
func_in,
regWrite, 
regDst, 
ALUSrc, 
branch, 
memWrite, 
memToReg, 
jump,
ALUOp
);
   
input [5:0] op_in, func_in;
   
wire [1:0] ALUOp_out;
wire branch_out, jump_out;				
wire regWrite_out, regDst_out; 
wire ALUSrc_out;
wire memWrite_out, memRead_out, memToReg_out;

output regWrite, regDst, ALUSrc, branch, memWrite, memToReg, jump;
output [1:0] ALUOp;

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
ZERO	= 6'b000_000;

assign regWrite_out = 	(op_in == ADDI)	||
						(op_in == LW)	||
						(op_in == 6'b000_000);
						

assign regDst_out	= 	op_in == 6'b000_000;
						 
assign ALUSrc_out	= 	(op_in == ADDI)	||
						(op_in == LW)	||
						(op_in == SW);
						
assign branch_out	= 	op_in == BEQ;
						
assign memWrite_out = 	op_in == SW;
						
assign memToReg_out = 	op_in == LW;

assign memRead_out 	=	op_in == LW;
						
assign ALUOp_out[1] = 	op_in == 6'b000_000;
assign ALUOp_out[0] = 	op_in == BEQ;
						
assign jump_out		= 	op_in == J;

assign regWrite		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : regWrite_out;
assign regDst		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : regDst_out;
assign ALUSrc		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : ALUSrc_out;
assign branch		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : branch_out;
assign memWrite		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : memWrite_out;
assign memToReg		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : memToReg_out;
assign memRead		= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : memRead_out;
assign jump			= 	(op_in == ZERO && func_in == ZERO) ? 1'b0 : jump_out;
assign ALUOp		= 	(op_in == ZERO && func_in == ZERO) ? 2'b0 : ALUOp_out;

endmodule 


