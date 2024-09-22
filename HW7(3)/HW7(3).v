module		Traffic (HG, HY, HR, FG, FY, FR, ST, reset, clk, C, TS, TL);

output		HG, HY, HR;
output		FG, FY, FR;
output		ST;
input		reset, clk;
input		C;
input		TS, TL;

reg		ST;
reg		HG, HY, HR;
reg		FG, FY, FR;
reg	[1:0]	state_reg;
reg	[1:0]	state_next;

parameter	s0 = 2'b00, s1 = 2'b01, s2 = 2'b10, s3 = 2'b11;


always@(posedge clk)
    begin
	if(reset)
		state_reg <= s0;
	else
		state_reg <= state_next;
    end

always@*
    begin
	state_next = state_reg;
	ST = 0;
	case(state_reg)
	    s0: //HG
		if(TL&C)
		    begin
			state_next = s1;
			ST = 1;
		    end
	    s1: //HY
		if(TS)
		    begin
			state_next = s2;
			ST = 1;
		    end
	    s2: //FG
		if(TL|(!C))
		    begin
			state_next = s3;
			ST = 1;
		    end
	    s3: //FY
		if(TS)
		    begin
			state_next = s0;
			ST = 1;
		    end
	    default:
		begin
			state_next = state_reg;
			ST = 0;
		end
	endcase
    end

always@*
    begin
	HG = 0; HY = 0; HR = 0;
	FG = 0; FY = 0; FR = 0;
	case(state_reg)
	    s0: //HG
		begin
			HG = 1; HY = 0; HR = 0;
			FG = 0; FY = 0; FR = 1;
		end
	    s1: //HY
		begin
			HG = 0; HY = 1; HR = 0;
			FG = 0; FY = 0; FR = 1;
		end
	    s2: //FG
		begin
			HG = 0; HY = 0; HR = 1;
			FG = 1; FY = 0; FR = 0;
		end
	    s3: //FY
		begin
			HG = 0; HY = 0; HR = 1;
			FG = 0; FY = 1; FR = 0;
		end
	    default:
		begin
			HG = 0; HY = 0; HR = 0;
			FG = 0; FY = 0; FR = 0;
		end
	endcase
    end

endmodule


module tb_Traffic;

reg		reset, clk;
reg		C;
reg		TS, TL;
wire		HG, HY, HR;
wire		FG, FY, FR;
wire		ST;




Traffic		UUT (HG, HY, HR, FG, FY, FR, ST, reset, clk, C, TS, TL);

always  // Clock generation
    begin
        #0	clk = 0;
        #10	clk = 1;
        #10	;
    end

initial
    begin
	// initialize
	#0  reset = 1; C = 0; TS = 0; TL = 0; // HG

	#20 reset = 0; C = 1; TS = 1; TL = 0;
	#20 reset = 0; C = 1; TS = 0; TL = 1; // HY

	#20 reset = 0; C = 1; TS = 1; TL = 0; // FG

	#20 reset = 0; C = 1; TS = 1; TL = 0;
	#20 reset = 0; C = 1; TS = 0; TL = 1; // FY

	#20 reset = 0; C = 1; TS = 1; TL = 0; // HG
    end

endmodule
