module			Add_4 (co, c, a, b, ci);

output			co;
output	[3:0]	c;
input	[3:0]	a, b;
input			ci;

assign {co, c} = a + b + ci ;

endmodule