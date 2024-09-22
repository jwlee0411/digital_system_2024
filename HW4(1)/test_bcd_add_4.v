// Design Unit Testbench
module			tb_BCD_Add_4; 

reg		[3:0]	x, y;
reg				c_in;
wire			c_out;
wire	[3:0]	z;

// Unit under test
BCD_Add_4		UUT (c_out, z, x, y, c_in);

// Stimulus generator
initial
    begin
        #10		x = 4'd1; y = 4'd2; c_in = 0;
        #10		x = 4'd7; y = 4'd3;
        #10		x = 4'd8; y = 4'd5;
        #10		x = 4'd9; y = 4'd9;
    end
initial
		#50	$finish;

// Response monitor
initial
    begin
        $monitor("time=%2d	X=%4b	Y=%4b	X+Y=%1b%4b", $time, x, y, c_out, z);
    end

endmodule


