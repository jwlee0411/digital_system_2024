module parity_gen(p,a,c);

output		p;
input	[7:0]	a;
input		c;
reg		p;
reg		x; 
integer		i;

always@*
  begin
    x = 0;
    for (i=0;i<8;i=i+1)
      begin
        if (a[i]==1) x = ~x; 
      end
    if (c==0)
      p = x;
    else
      p = ~x;
  end
endmodule




module parity_chk(p,a,c);
output		p;
input	[7:0]	a;
input		c;
reg		p;
reg		x; 
integer		i;

always@*
  begin
    x = 0;
    for (i=0;i<8;i=i+1)
      begin
        if (a[i]==1) x = ~x; 
      end
    if (c==0)
      p = ~x;
    else
      p =  x;
  end
endmodule




module tb_parity_gen_chk;

reg	[7:0]	a;
reg		c;
wire 		p_gen, p_chk;

parity_gen UUT1 (p_gen,a,c);
parity_chk UUT2 (p_chk,a,c);

initial
    begin
	#0	c = 0; a = 8'b10101010; // c: even parity, a: even parity	-> p_gen = 0 to make {p,a[7:0]} as even parity	-> p_chk = 1 since "a[7:0] is even parity" is true
	#100	c = 0; a = 8'b10101011; // c: even parity, a: odd parity	-> p_gen = 1 to make {p,a[7:0]} as even parity	-> p_chk = 0 since "a[7:0] is even parity" is false
	#100	c = 1; a = 8'b10101010; // c: odd parity, a: even parity	-> p_gen = 1 to make {p,a[7:0]} as odd parity	-> p_chk = 0 since "a[7:0] is odd parity" is false
	#100	c = 1; a = 8'b10101011; // c: odd parity, a: odd parity		-> p_gen = 0 to make {p,a[7:0]} as odd parity	-> p_chk = 1 since "a[7:0] is odd parity" is true
    end

endmodule