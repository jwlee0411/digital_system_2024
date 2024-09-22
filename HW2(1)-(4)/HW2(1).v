module			Logic (out, a0, b0, a1, b1, a2, b2, a3, b3);

output			out;
input 			a0, b0, a1, b1, a2, b2, a3, b3;
wire			t0, t1, t2, t3, t4, t5;

xnor			XNOR1 (t0, a0, b0);
xnor			XNOR2 (t1, a1, b1);
xnor			XNOR3 (t2, a2, b2);
xnor			XNOR4 (t3, a3, b3);
nor				NOR1 (t4, t0, t1);
nor				NOR2 (t5, t2, t3);
nand			NAND1 (out, t4, t5);

endmodule
