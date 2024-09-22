module ring_counter (q, clk, start);

output	[3:0]	q;
input		clk, start;
reg	[3:0]	q;

always@(posedge clk or posedge start)
  begin
    if (start)
      q <= 4'b0001;
    else
      q <= {q[2:0],q[3]};
  end
  
endmodule




module Johnson_counter (q, clk, start);

output	[3:0]	q;
input		clk, start;
reg	[3:0]	q;

always@(posedge clk or posedge start)
  begin
    if (start)
      q <= 4'b0000;
    else
      q <= {q[2:0],~q[3]};
  end
  
endmodule




module tb_counter;

reg		clk,start;
wire 	[3:0]	q_ring, q_Johnson;

ring_counter	UUT1 (q_ring, clk, start);
Johnson_counter	UUT2 (q_Johnson, clk, start);

always
    begin
	#0	clk = 0;
	#10	clk = 1;
	#10	;
    end

initial
    begin
	#0	start = 0;
	#15	start = 1;
	#10	start = 0;
    end

endmodule