module		U_bin_counter (q, pn, rstb, clkb, clrb, ldb, hdb, upb, d);

output	[3:0]	q;
output		pn;
input		rstb, clkb, clrb, ldb, hdb, upb;
input	[3:0]	d;

reg	[3:0]	q_reg, q_next;

always@(negedge clkb or negedge rstb)
    begin
	if(!rstb)
	    q_reg <= 0;
	else
	    q_reg <= q_next;
    end

always@*
    begin
	q_next = q_reg;
	if (!clrb)
	    q_next = 0;
	else if(!ldb)
	    q_next = d;
	else if(!hdb)
	    q_next = q_reg;
	else if(!upb)
	    q_next = q_reg + 1;
	else //upb == 0
	    q_next = q_reg - 1;
    end

assign	q = q_reg;
assign	pn = (q_reg == 4'd2 || q_reg == 4'd3 || q_reg == 4'd5 || q_reg == 4'd7 || q_reg == 4'd11 || q_reg == 4'd13) ? 1 : 0; // case statement is also OK instead of assign statement

endmodule




module		tb_U_bin_counter;

reg		rstb, clkb;
reg		clrb, ldb, hdb, upb;
reg	[3:0]	d;
wire	[3:0]	q;
wire		pn;

U_bin_counter	UUT (q, pn, rstb, clkb, clrb, ldb, hdb, upb, d);

always  // Clock generation
    begin
        #0	clkb = 0;
        #10	clkb = 1;
        #10	;
    end

initial
    begin
	#0	rstb = 1; clrb = 1; ldb = 1; hdb = 1; upb = 1; d = 4'd5;	// initial state
	#5	rstb = 0; clrb = 1; ldb = 1; hdb = 1; upb = 1; d = 4'd5;	// testing rstb (reset)
	#5	rstb = 1; clrb = 1; ldb = 0; hdb = 1; upb = 1; d = 4'd5;	// testing ldb  (load)
	#20	rstb = 1; clrb = 1; ldb = 1; hdb = 0; upb = 1; d = 4'd5;	// testing hdb  (hold)
	#20	rstb = 1; clrb = 1; ldb = 1; hdb = 1; upb = 1; d = 4'd5;	// testing upb  (count down)
	#20	rstb = 1; clrb = 1; ldb = 1; hdb = 1; upb = 0; d = 4'd5;	// testing upb  (count up)
	#200	rstb = 1; clrb = 0; ldb = 1; hdb = 1; upb = 1; d = 4'd5;	// testing clrb (clear)
    end

endmodule
