module 			logic_unit (y, a, b, s);

output	[7:0]	y;
input	[7:0]	a, b;
input	[1:0]	s;

wire	[7:0]	t0, t1, t2, t3, t4, t5;

mux_8			MUX1 (y, t0, t1, s[1]); 
mux_8			MUX2 (t0, t2, t3, s[0]); 
mux_8			MUX3 (t1, t4, t5, s[0]);

//or	(t2, a, b);
or				OR1 (t2[7], a[7], b[7]);
or				OR2 (t2[6], a[6], b[6]);
or				OR3 (t2[5], a[5], b[5]);
or				OR4 (t2[4], a[4], b[4]);
or				OR5 (t2[3], a[3], b[3]);
or				OR6 (t2[2], a[2], b[2]);
or				OR7 (t2[1], a[1], b[1]);
or				OR8 (t2[0], a[0], b[0]);

//and	(t3, a, b);
and 			AND1 (t3[7], a[7], b[7]);
and 			AND2 (t3[6], a[6], b[6]);
and 			AND3 (t3[5], a[5], b[5]);
and 			AND4 (t3[4], a[4], b[4]);
and 			AND5 (t3[3], a[3], b[3]);
and 			AND6 (t3[2], a[2], b[2]);
and 			AND7 (t3[1], a[1], b[1]);
and 			AND8 (t3[0], a[0], b[0]);

//xor	(t4, a, b);
xor 			XOR1 (t4[7], a[7], b[7]);
xor 			XOR2 (t4[6], a[6], b[6]);
xor 			XOR3 (t4[5], a[5], b[5]);
xor 			XOR4 (t4[4], a[4], b[4]);
xor 			XOR5 (t4[3], a[3], b[3]);
xor 			XOR6 (t4[2], a[2], b[2]);
xor 			XOR7 (t4[1], a[1], b[1]);
xor 			XOR8 (t4[0], a[0], b[0]);

//not	(t5, a);
not 			NOT1 (t5[7], a[7]);
not 			NOT2 (t5[6], a[6]);
not 			NOT3 (t5[5], a[5]);
not 			NOT4 (t5[4], a[4]);
not 			NOT5 (t5[3], a[3]);
not 			NOT6 (t5[2], a[2]);
not 			NOT7 (t5[1], a[1]);
not 			NOT8 (t5[0], a[0]);

endmodule