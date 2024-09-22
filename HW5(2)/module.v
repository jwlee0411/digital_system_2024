module			add_8 (o, a, b);

output	[7:0]	o;
input	[7:0]	a, b;

assign	o = a + b;

endmodule




module			sub_8 (o, a, b);

output	[7:0]	o;
input	[7:0]	a, b;

assign	o = a - b;

endmodule




module			mux_8 (o, a, b, s);

output	[7:0]	o;
input	[7:0]	a, b;
input			s;

assign	o = ((s == 0) ? a : b);

endmodule
