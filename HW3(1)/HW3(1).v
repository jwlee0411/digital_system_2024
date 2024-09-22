// Unit under test
module			XOR00 (z, x, y);

output			z;
input			x, y;
wire			a, b, c;

nand	#4		NAND1 (a, x, y);
nand	#3		NAND2 (b, x, a);
nand	#1		NAND3 (c, a, y);
nand	#2		NAND4 (z, b, c);

endmodule



// Design Unit Testbench
module 			tb_XOR00;

reg 			x, y;
wire			z;

// Unit under test
XOR00			UUT (z, x, y);

// Stimulus generator
initial
    begin
        #20		x = 0; y = 0;
        #20		x = 1;
        #20		y = 1;
        #20		x = 0;
    end
initial
		#100	$finish;

// Response monitor
initial
    begin
        $monitor("time = %2d, x = %1b, y = %1b, z = %1b", $time, x, y, z);
    end

endmodule