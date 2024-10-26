/*###################################################################################
Note: Please don’t upload the assignments, template file/solution and lab. manual on GitHub or others public repository. 
It violates the BITS’s Intellectual Property Rights (IPR).
************************************************************************************/
`include "pc.v"
`include "instrMem.v"
`include "regFile.v"
`include "ALU.v"
`include "dataMem.v"
`include "adder.v"
`include "signExtn.v"
`include "muxRegAddr.v"
`include "muxData.v"
`include "controller.v"


module singleCycle(input clk, input reset);
	
    wire regWrite;
	wire branch;
	wire memtoReg;
    wire memWrite;
    wire memRead;
	wire [1:0] aluOp;
	wire regDest;
	wire zero;
	wire aluSrc;
    wire [31:0] inPc;
	wire [31:0] outPc;
	
	// IM
	wire [31:0] IR;
	
	// Rd Select Mux 
	wire [4:0] rdIn;
	
	// Reg File
	wire [31:0] regRs;
	wire [31:0] regRt;

	// Sign Extend 16 to 32
	wire [31:0] signExt16to32Out;

    // ALU Input 2 Select Mux 
	wire [31:0] aluIn2;

    // PC Adder
	wire [31:0] outPc4;

    wire [31:0] aluresult;
    wire [31:0] memOut;
    // Branch Mux
	wire [31:0] branchAddress;
	wire [31:0] branchMuxOut;

    wire [31:0] result;

    wire [3:0] ALUContrl;

	//Write Your Code Here
	register32bit_PC  register32bit_PC1(clk, reset, (!zero), branchMuxOut, outPc);
	IM IM1(clk,reset,outPc[6:2], IR);
	registerFile registerFile1(clk, reset, regWrite,IR[25:21],IR[20:16],rdIn,result, regRs, regRt);
	signExt16to32 signExt16to32(IR[15:0], signExt16to32Out);
	mux2to1_5bits mux2to1_5bits1(IR[20:16], IR[15:11], regDest, rdIn);
	mux2to1_32bits mux2to1_32bits1(regRt, signExt16to32Out, aluSrc, aluIn2);
	controlCircuit controlCircuit1(IR[31:26], aluOp, aluSrc, branch, memWrite, memRead, memtoReg, regDest, regWrite);
	aluCtrl aluCtrl1(aluOp, IR[5:0], ALUContrl);
	ALU ALU1(aluIn2, regRs, ALUContrl, aluresult, zero);
	DM DM1(clk,reset,memRead, memWrite,aluresult[6:2],regRt,memOut);
	adder adder1(outPc, 4, outPc4);
	adder adder2(outPc4, (signExt16to32Out<<2), branchAddress);
	mux2to1_32bits mux2to1_32bits2(outPc4, branchAddress, branch & (!zero), branchMuxOut);
	mux2to1_32bits mux2to1_32bits3(aluresult,memOut, memtoReg, result);

endmodule