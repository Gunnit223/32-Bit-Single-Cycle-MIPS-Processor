//Perform airthemtic or logical operations based on value of "ALUControl"
module ALU(input [31:0] aluIn1, input [31:0] aluIn2,input [3:0]ALUContrl, output reg [31:0]aluOut, output reg zero);
//WRITE YOUR CODE HERE
    always @(*) begin
        case (ALUContrl)
            4'b0000: aluOut = aluIn1 & aluIn2;  // AND
            4'b0001: aluOut = aluIn1 | aluIn2;  // OR
            4'b0010: aluOut = aluIn1 + aluIn2;  // ADD
            4'b0110: aluOut = aluIn1 - aluIn2;  // SUBTRACT
            4'b0111: aluOut = (aluIn1 < aluIn2) ? 32'b1 : 32'b0; // SLT (Set on Less Than)
            4'b1100: aluOut = ~(aluIn1 | aluIn2);  // NOR
            default: aluOut = 32'b0; // Default case, should not happen
        endcase

  if(aluOut==32'b0)
    zero=1'b1;
  else
    zero=1'b0;

end
endmodule

// follow the table given in question pdf
module aluCtrl(input [1:0] aluOp, input [5:0] func,output reg [3:0] ALUContrl);
//WRITE YOUR CODE HERE
always @(*) begin
        case (aluOp)
            2'b00: ALUContrl = 4'b0010; // LW and SW (Add)
            2'b01: ALUContrl = 4'b0110; // BEQ (Subtract)
            2'b10: begin
                case (func)
                    6'b100000: ALUContrl = 4'b0010; // ADD
                    6'b100010: ALUContrl = 4'b0110; // SUB
                    6'b100100: ALUContrl = 4'b0000; // AND
                    6'b100101: ALUContrl = 4'b0001; // OR
                    6'b101010: ALUContrl = 4'b0111; // SLT
                    6'b100111: ALUContrl = 4'b1100; // NOR
                    default: ALUContrl = 4'b0000; // Default case
                endcase
            end
            default: ALUContrl = 4'b0000; // Default case
        endcase
    end

endmodule
