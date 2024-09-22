module			BCD_Add_Calc (l0, l1, l2, l3, l4, a0, a1, a2, a3, b0, b1, b2, b3);

output	[6:0]	l0, l1, l2, l3;
output			l4;
input	[3:0]	a0, a1, a2, a3;
input	[3:0]	b0, b1, b2, b3;

wire			c0, c1, c2;
wire	[3:0]	d0, d1, d2, d3;
supply0			logic0;


BCD_Add_4		ADD1 (c0, d0, a0, b0, logic0);
BCD_Add_4		ADD2 (c1, d1, a1, b1, c0);
BCD_Add_4		ADD3 (c2, d2, a2, b2, c1);
BCD_Add_4		ADD4 (l4, d3, a3, b3, c2);
BCD_LED_7		LED1 (l0, d0[3], d0[2], d0[1], d0[0]);
BCD_LED_7		LED2 (l1, d1[3], d1[2], d1[1], d1[0]);
BCD_LED_7		LED3 (l2, d2[3], d2[2], d2[1], d2[0]);
BCD_LED_7		LED4 (l3, d3[3], d3[2], d3[1], d3[0]);

endmodule



