// Design Unit Testbench
module			tb_ALU;

reg		[7:0]	a, b;
reg		[2:0]	s;
wire	[7:0]	f;

// Unit under test
ALU		UUT (f, a, b, s);


// Stimulus generator
initial
    begin
        #0		a = 8'b10101010; b = 8'b01010101; s = 3'b000;
        #100	a = 8'b00000011; b = 8'b00111111; s = 3'b001;
        #100	a = 8'b01111101; b = 8'b00000011; s = 3'b010;
        #100	a = 8'b01100111; b = 8'b11100111; s = 3'b011;
        #100	a = 8'b00110011; b = 8'b00001111; s = 3'b100;
        #100	a = 8'b11110000; b = 8'b11001100; s = 3'b101;
        #100	a = 8'b11110000; b = 8'b10011001; s = 3'b110;
        #100	a = 8'b01100111; b = 8'b11100111; s = 3'b111;
    end

initial
		#800	$finish;


// Response monitor
initial
    begin
        $monitor("time=%3d A=%8b B=%8b S=%3b O=%8b",$time, a, b, s, f);
    end

endmodule
