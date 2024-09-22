module			BCD_Add_4 (c_out, z, x, y, c_in); 

output			c_out;
output	[3:0]	z;
input	[3:0]	x, y;
input			c_in;

wire			n0, n1, n2, n3, k, l, m, o;
supply0			logic0;

Add_4			ADD1 (k, {n3, n2, n1, n0}, x, y, c_in);
Add_4			ADD2 (o, z, {logic0, c_out, c_out, logic0}, {n3, n2, n1, n0}, logic0);
and				AND1 (l, n1, n3);
and				AND2 (m, n2, n3);
or				OR1 (c_out, k, l, m);

endmodule



