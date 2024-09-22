// Design Unit Testbench
module 			tb_BCD_Add_Calc;

reg		[3:0]	a0, b0;
reg		[3:0]	a1, b1;
reg		[3:0]	a2, b2;
reg		[3:0]	a3, b3;
wire	[6:0]	l0, l1, l2, l3;
wire			l4;

// Unit under test
BCD_Add_Calc	UUT (l0, l1, l2, l3, l4, a0, a1, a2, a3, b0, b1, b2, b3);

// Stimulus generator
initial
    begin
        #10 a3 = 4'd1; a2 = 4'd2; a1 = 4'd3; a0 = 4'd4;
            b3 = 4'd4; b2 = 4'd3; b1 = 4'd2; b0 = 4'd1;
        #10 a3 = 4'd7; a2 = 4'd2; a1 = 4'd1; a0 = 4'd8;
            b3 = 4'd0; b2 = 4'd3; b1 = 4'd6; b0 = 4'd9;
        #10 a3 = 4'd0; a2 = 4'd5; a1 = 4'd0; a0 = 4'd4;
            b3 = 4'd9; b2 = 4'd8; b1 = 4'd2; b0 = 4'd6;
        #10 a3 = 4'd5; a2 = 4'd3; a1 = 4'd4; a0 = 4'd7;
            b3 = 4'd2; b2 = 4'd1; b1 = 4'd4; b0 = 4'd8;
    end

// Response monitor
initial
		#50 $finish;
initial
    begin
        $monitor("time=%2d A=%1d%1d%1d%1d B=%1d%1d%1d%1d L=%1b %7b %7b %7b %7b",
                 $time, a3, a2, a1, a0, b3, b2, b1, b0, l4, l3, l2, l1, l0);
    end

endmodule



