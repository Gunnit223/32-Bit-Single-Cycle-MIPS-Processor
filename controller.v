/*###################################################################################
Note: Please don’t upload the assignments, template file/solution and lab. manual on GitHub or others public repository. 
It violates the BITS’s Intellectual Property Rights (IPR).
************************************************************************************/

//MIPS's instruction's Opcode

`define ADDI    6'd8
`define LW      6'd35
`define SW      6'd43
`define BNE     6'd5
`define ADD     6'd0

// Control circuit. Generates the control signals. Default value for all the outputs is zero(0).

module controlCircuit(input [5:0] opcode, output reg [1:0] aluOp, output reg aluSrc, output reg branch, output reg memWrite, output reg memRead, output reg memtoReg, output reg regDest, output reg regWrite );
  
      //WRITE YOUR CODE HERE
      always @(*) begin
        // Default values for all control signals
        aluOp = 2'b00;
        aluSrc = 1'b0;
        branch = 1'b0;
        memWrite = 1'b0;
        memRead = 1'b0;
        memtoReg = 1'b0;
        regDest = 1'b0;
        regWrite = 1'b0;

        case(opcode)
            `ADD: begin
                // R-type instruction
                regDest = 1'b1;
                regWrite = 1'b1;
                aluOp = 2'b10; // For ADD instruction in R-type
            end

            `ADDI: begin
                // ADDI instruction
                aluSrc = 1'b1;
                regWrite = 1'b1;
                aluOp = 2'b00; // ALU performs addition
            end

            `LW: begin
                // Load Word (LW) instruction
                aluSrc = 1'b1;
                memRead = 1'b1;
                memtoReg = 1'b1;
                regWrite = 1'b1;
                aluOp = 2'b00; // ALU performs addition for address calculation
            end

            `SW: begin
                // Store Word (SW) instruction
                aluSrc = 1'b1;
                memWrite = 1'b1;
                aluOp = 2'b00; // ALU performs addition for address calculation
            end

            `BNE: begin
                // Branch if Not Equal (BNE) instruction
                branch = 1'b1;
                aluOp = 2'b01; // ALU performs subtraction for comparison
            end

            default: begin
                // Default case, all signals remain zero
            end
        endcase
      end


      
endmodule