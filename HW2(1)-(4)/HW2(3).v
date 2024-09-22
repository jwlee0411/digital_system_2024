module			Adder_8 (c_out, sum ,a, b, c_in);

output			c_out;
output	[7:0]	sum;
input	[7:0]	a;
input	[7:0]	b;
input			c_in;

assign {c_out, sum} = a + b + c_in;

endmodule



