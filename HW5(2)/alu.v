module			ALU (f, a, b, s);

output	[7:0]	f;
input	[7:0]	a, b;
input	[2:0]	s;


wire	[7:0]	x, y;

add_unit		ADD1 (x, a, b, s[1:0]);
logic_unit		LOG1 (y, a, b, s[1:0]);
mux_8			MUX1 (f, x, y, s[2]);

endmodule
