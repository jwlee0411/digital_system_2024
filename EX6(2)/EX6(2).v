module		mod_m_counter (q, clk, reset);

parameter	N=4;	// number of bits in a counter
parameter  	M=10;	// mod-M
output	[N-1:0]	q;
input		clk, reset;
reg	[N-1:0]	r_reg;
wire	[N-1:0]	r_next;

always@(posedge clk, posedge reset) // register
    if (reset)
	r_reg <= 0;
    else
	r_reg <= r_next;

assign r_next = ( (r_reg==(M-1)) ? 0 : (r_reg+1) ); // next-state logic

assign q = r_reg; // output logic

endmodule


module tb_mod_m_counter;

parameter	N=4;	// number of bits in a counter
parameter  	M=10;	// mod-M
reg		clk, reset;
wire 	[N-1:0]	q;

mod_m_counter	UUT (q, clk, reset);

always
    begin
	#0	clk = 0;
	#10	clk = 1;
	#10	;
    end

initial
    begin
	#0	reset = 0;
	#3	reset = 1;
	#3	reset = 0;
    end

endmodule
