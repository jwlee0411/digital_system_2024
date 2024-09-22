module			add_unit (x, a, b, s);

output	[7:0]	x;
input	[7:0]	a, b;
input	[1:0]	s;

wire	[7:0]	add0, add1, sub0, sub1, sub2;

mux_8			MUX1 (x, 		add0, 	sub0, 	s[1]); 
mux_8			MUX2 (add1, 	8'b0, 	b, 		s[0]);
mux_8			MUX3 (sub1, 	a, 		8'b0, 	s[0]);
mux_8			MUX4 (sub2, 	b, 		a, 		s[0]);
add_8			ADD1 (add0, 	a, 		add1);
sub_8			SUB1 (sub0, 	sub1, 	sub2);

endmodule
