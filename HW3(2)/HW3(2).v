// Unit under test
module			DEC2x4 (d0, d1, d2, d3, s0, s1);

output			d0, d1, d2, d3;
input 			s0, s1;

wire			s0b, s1b, d0b, d1b, d2b, d3b;

not 	#1		NOT1 (s0b, s0);
not 	#1		NOT2 (s1b, s1);
not 	#1		NOT3 (d0, d0b);
not 	#1		NOT4 (d1, d1b);
not 	#3		NOT5 (d2, d2b);
not 	#2		NOT6 (d3, d3b);
nand 	#4		NAND1 (d0b, s0, s1);
nand 	#3		NAND2 (d1b, s0b, s1);
nand 	#1		NAND3 (d2b, s0, s1b);
nand 	#2		NAND4 (d3b, s0b, s1b);

endmodule




// Design Unit Testbench
module 			tb_DEC2x4;

reg 			s0, s1;
wire			d0, d1, d2, d3;

// Unit under test
DEC2x4			UUT (d0, d1, d2, d3, s0, s1);

// Stimulus generator
initial
    begin
        #20		s0 = 0;	s1 = 0;
        #20		s0 = 1;
        #20		s0 = 0;	s1 = 1;
        #20		s0 = 1;
    end
initial
	#100 $finish;

// Response monitor
initial
    begin
        $monitor("time = %2d, s0 = %1b, s1 = %1b, d0 = %1b, d1 = %1b, d2 = %1b, d3 = %1b", $time, s0, s1, d0, d1, d2, d3);
    end

endmodule
