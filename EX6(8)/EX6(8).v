module excess3_to_BCD (valid, o, i);

  output		valid;
  output	[3:0]	o;
  input		[3:0]	i;

  assign valid = ( ( (i>=3) && (i<=12) ) ? 1'b1 : 1'b0 );
  assign o = ( (valid) ? (i - 4'b0011) : i );

endmodule




module tb_excess3_to_BCD;

reg	[3:0]	i;
wire 	[3:0]	o;
wire		valid;

excess3_to_BCD	UUT (valid, o, i);

initial
    begin
	#0	i = 4'b0001; // not excess-3
	#100	i = 4'b1101; // not excess-3
	#100	i = 4'b1000; // excess-3 code, value = 1'd5
	#100	i = 4'b1100; // excess-3 code, value = 1'd9
    end

endmodule