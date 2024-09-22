// Design Unit Testbench: HW item (5)
module			tb_Barrel_shifter;

reg		[7:0]	i;
reg		[2:0]	s;
reg		[1:0]	c;
wire	[7:0]	o;
reg				clk;

// Unit under test
Barrel_shifter	UUT (o, i, s, c, clk);


// Stimulus generator
always  // Clock generation
    begin
        #0		clk = 0;
        #50		clk = 1;
        #50		;
    end

initial  // Simulation inputs
    begin
        #0		i = 8'b10101010;	c = 2'b11;	s = 3'b010;
        #100						c = 2'b01;
        #100	i = 8'b11100111;	c = 2'b11;	s = 3'b010;
        #100						c = 2'b10;
        #100	i = 8'b00011010;	c = 2'b11;	s = 3'b001;
        #100						c = 2'b01;
        #100	i = 8'b01010101;	c = 2'b11;	s = 3'b011;
        #100						c = 2'b10;
        #100	i = 8'b00011100;	c = 2'b11;	s = 3'b100;
        #100						c = 2'b01;
        #100	i = 8'b11001100;	c = 2'b11;	s = 3'b110;
        #100						c = 2'b10;
  end

initial  // Simulation end
		#1200	$finish;


// Response monitor
initial
    begin
        $monitor("time=%4d l=%8b C=%2b S=%3b O=%8b",$time, i, c, s, o);
    end

endmodule



