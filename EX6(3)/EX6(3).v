module		FIFO (rd_data, empty, full, wr_data, clk, reset, rd, wr);

// parameters
parameter	B = 8; // number of bits in a word
parameter	W = 4; // number of address bits

// inputs and outputs
output 	[B-1:0]	rd_data;
output 		empty, full;
input	[B-1:0]	wr_data;
input		clk, reset;
input 		rd, wr;

// registers, arrays, pointers, status flags
reg 	[B-1:0]	array_reg [2**W-1:0];
reg 	[W-1:0]	wr_ptr_reg, wr_ptr_next;
reg 	[W-1:0]	rd_ptr_reg, rd_ptr_next;
reg		full_reg, full_next;
reg		empty_reg, empty_next;

// state register
always@(posedge clk, posedge reset)
    if (reset)
	begin
	    wr_ptr_reg <= 0;
	    rd_ptr_reg <= 0;
	    full_reg <= 1'b0; 
	    empty_reg <= 1'b1; // initial state is empty
	end
    else
	begin
	    wr_ptr_reg <= wr_ptr_next;
	    rd_ptr_reg <= rd_ptr_next;
	    full_reg <= full_next;
	    empty_reg <= empty_next;
	end

// write operation
always@(posedge clk)
    if (wr&(~full_reg)) // write enabled, buffer not full
	array_reg[wr_ptr_reg] <= wr_data;

// read operation
assign rd_data = array_reg[rd_ptr_reg];

// next-state logic
always@*
    begin
	// default values
	rd_ptr_next = rd_ptr_reg; wr_ptr_next = wr_ptr_reg;
	full_next = full_reg; empty_next = empty_reg;
	// read or write    
	case({wr,rd})
	    2'b01: // read
		if (~empty_reg) // if buffer not empty
		    begin
			rd_ptr_next = rd_ptr_reg + 1;
			full_next = 1'b0; // after read, buffer is not full
			if (rd_ptr_next == wr_ptr_reg) // when 2 pointers equal
			    empty_next = 1'b1;
		    end
	    2'b10: // write
		if (~full_reg) // if buffer not full
		    begin
			wr_ptr_next = wr_ptr_reg + 1;
			empty_next = 1'b0; // after write, buffer is not empty
			if (wr_ptr_next == rd_ptr_reg) // when 2 pointers equal
			    full_next = 1'b1;
		    end
	    2'b11: // read and write
		begin
		    rd_ptr_next = rd_ptr_reg + 1;
		    wr_ptr_next = wr_ptr_reg + 1;
		end
	    default: // no operation
		;
    endcase
end


// output logic
// rd_data is already described in ищ
assign full = full_reg;
assign empty = empty_reg;

endmodule




module tb_FIFO;

parameter	B = 8; // number of bits in a word
parameter	W = 4; // number of address bits
reg	[B-1:0]	wr_data;
reg		clk, reset;
reg 		rd, wr;
wire 	[B-1:0]	rd_data;
wire 		empty, full;

FIFO UUT (rd_data, empty, full, wr_data, clk, reset, rd, wr);

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

initial
    begin
	#0	rd = 0; wr = 1; wr_data = 0;
	#20	rd = 0; wr = 1; wr_data = 2;
	#20	rd = 0; wr = 1; wr_data = 4;
	#20	rd = 0; wr = 1; wr_data = 6;
	#20	rd = 0; wr = 1; wr_data = 8;
	#20	rd = 1; wr = 0;
	#20	rd = 0; wr = 1; wr_data = 10;
	#20	rd = 0; wr = 1; wr_data = 12;
	#20	rd = 0; wr = 1; wr_data = 14;
	#20	rd = 0; wr = 1; wr_data = 16;
	#20	rd = 0; wr = 1; wr_data = 18;
	#20	rd = 0; wr = 1; wr_data = 20;
	#20	rd = 0; wr = 1; wr_data = 22;
	#20	rd = 0; wr = 1; wr_data = 24;
	#20	rd = 0; wr = 1; wr_data = 26;
	#20	rd = 0; wr = 1; wr_data = 28;
	#20	rd = 0; wr = 1; wr_data = 30;
	#20	rd = 0; wr = 1; wr_data = 32; // buffer full
	#20	rd = 0; wr = 1; wr_data = 34; // write ignored when buffer full
	#20	rd = 0; wr = 1; wr_data = 36; // write ignored when buffer full
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0;
	#20	rd = 1; wr = 0; // buffer empty
	#20	rd = 1; wr = 0; // read ignored when buffer empty
	#20	rd = 1; wr = 0; // read ignored when buffer empty
	#20	rd = 0; wr = 1; wr_data = 100;
	#20	rd = 0; wr = 1; wr_data = 102;
	#20	rd = 0; wr = 1; wr_data = 104;
	#20	rd = 0; wr = 0; wr_data = 0; // end of simulation
    end

endmodule
