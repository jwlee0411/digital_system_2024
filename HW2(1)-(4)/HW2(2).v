module			Mux8 (o, i1, i2, s);

output	[7:0]	o;
input	[7:0]	i1;
input	[7:0]	i2;
input			s;
reg		[7:0]	o;

always@(i1 or i2 or s)
    begin
        if(s == 0)
            o = i1;
        else
            o = i2;
    end

endmodule
