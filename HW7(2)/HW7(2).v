module		Vending (open, clk, reset, n, d);

output		open;
input		clk;
input		reset;
input		n;
input		d;

reg		open;
reg	[1:0]	state_reg, state_next;

parameter	c0 = 2'b00, c5 = 2'b01, c10 = 2'b10, c15 = 2'b11; 

always@(posedge clk)
    begin
	if((!n & !d) | reset)
		state_reg <= 0;
	else
		state_reg <= state_next;
    end

always@*
    begin
	state_next = state_reg;
	open = 0;
	case(state_reg)
	    c0: //0 cents
		if(d)
		    state_next = c10;
		else if (n)
		    state_next = c5;
	    c5: //5 cents
		if(d)
		    begin
		    state_next = c15;
		    open = 1;
		    end
		else if (n)
		    state_next = c10;
	    c10: // 10 cents
		if(d|n)
		    begin
		    state_next = c15;
		    open = 1;
		    end
	    c15: // 15 cents
		if (reset)
		    state_next = c0;
		else
		    open = 1;
	    default:
		begin
		state_next = state_reg;
		open = 0;
		end
	endcase
    end

endmodule




module		tb_Vending;

reg		clk, reset, n, d;
wire		open;

Vending		UUT (open, clk, reset, n, d);

always  // Clock generation
    begin
        #0	clk = 0;
        #10	clk = 1;
        #10	;
    end

initial
    begin

	// initialize
	#0	reset = 1; n = 0; d = 0;

	//N+N+N
	#20 reset = 0; n = 1; d = 0; // N
	#20 reset = 0; n = 1; d = 0; // N
	#20 reset = 0; n = 1; d = 0; // N, open
	#20 reset = 1; n = 0; d = 0; // reset
	
	//N+D
	#20 reset = 0; n = 1; d = 0; // N
	#20 reset = 0; n = 0; d = 1; // D, open
	#20 reset = 1; n = 0; d = 0; // reset
	
	//D+N
	#20 reset = 0; n = 0; d = 1; // D
	#20 reset = 0; n = 1; d = 0; // N, open
	#20 reset = 1; n = 0; d = 0; // reset

	//D+D
	#20 reset = 0; n = 0; d = 1; // D
	#20 reset = 0; n = 0; d = 1; // D, open
	#20 reset = 1; n = 0; d = 0; // reset
    end

endmodule
