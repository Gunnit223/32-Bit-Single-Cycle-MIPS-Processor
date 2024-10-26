/*###################################################################################
Note: Please don’t upload the assignments, template file/solution and lab. manual on GitHub or others public repository. 
It violates the BITS’s Intellectual Property Rights (IPR).
************************************************************************************/
`include "topModule.v"
module testbench();
	reg clk;
	reg reset;
	//wire [31:0] result;
	singleCycle SC(clk, reset);

	always
	#5 clk=~clk;
	
	initial
	begin
        $dumpfile("2021A8PS2330G_SCFibo.vcd"); // Write your CampusID here
        $dumpvars(0,testbench);

		clk=1; reset=1;//clk=0; reset=1;
		#10  reset=0;	
		//$monitor($time," %x ",result);
		#810 $finish;
	end
	 initial begin
        $monitor($time, " PC: %d, Instruction: %b Result: %d ", SC.outPc, SC.IM1.IR,SC.result);
    end

      
endmodule