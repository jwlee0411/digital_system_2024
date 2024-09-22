module		Stopwatch (d0, d1, d2, clk, clr, go);

output	[3:0]	d0, d1, d2;
input		clk, clr;
input		go;

reg	[3:0]	d0_reg, d0_next, d1_reg, d1_next, d2_reg, d2_next;
reg	[25:0]	tick_reg, tick_next;

always@(posedge clk)
    begin
	tick_reg <= tick_next;
	d0_reg <= d0_next;
	d1_reg <= d1_next;
	d2_reg <= d2_next;
    end

always@*
    begin
	tick_next = tick_reg;
	d0_next = d0_reg;
	d1_next = d1_reg;
	d2_next = d2_reg;
	if (!clr)
	    begin
		tick_next = 0;
		d0_next = 0;
		d1_next = 0;
		d2_next = 0;
	    end
	else if (go) 
	    begin
		tick_next = tick_reg + 1;		
		if(tick_reg == 26'd49999999) // alternately: if(tick_next == 26'd50000000)
		    begin
			tick_next = 0;
			d0_next = d0_reg + 1;
			if(d0_reg == 4'd9) // alternately: if (d0_next == 4'd10)
			    begin
				d0_next = 0;
				d1_next = d1_reg + 1;
				if(d1_reg == 4'd9) // alternately: if (d1_next == 4'd10)
				    begin
					d1_next = 0;
					d2_next = d2_reg + 1;
					if(d2_reg == 4'd9) // alternately: if (d2_next == 4'd10)
					    d2_next = 0;
				    end
			    end
		    end
	    end
	else
	    begin
		tick_next = tick_reg;
		d0_next = d0_reg;
		d1_next = d1_reg;
		d2_next = d2_reg;
	    end
    end

assign d0 = d0_reg;
assign d1 = d1_reg;
assign d2 = d2_reg;

endmodule




module		tb_Stopwatch;

reg		clk, clr, go;
wire	[3:0]	d0, d1, d2;

Stopwatch	UUT (d0, d1, d2, clk, clr, go);


always  // Clock generation
    begin
        #0	clk = 0;
        #1	clk = 1;
        #1	;
    end

initial
    begin
	#0	clr = 1; go = 0;
	#2	clr = 0; go = 0;
	#4	clr = 1; go = 1;
    end

endmodule