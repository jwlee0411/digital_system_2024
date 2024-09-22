module encoder (o, valid, i);

output	[1:0]	o;
output		valid;
input	[3:0]	i;
reg	[1:0]	o;
reg		valid;

always@*
  begin
    o = 2'b00; valid = 1;
    case (i)
      4'b0001: o = 2'b00;
      4'b0010: o = 2'b01;
      4'b0100: o = 2'b10;
      4'b1000: o = 2'b11;
      default: valid = 0;
    endcase
  end

endmodule




module	pr_encoder (o, i);

output	[1:0]	o;
input	[3:0]	i;
reg	[1:0]	o;

always@*
  begin
    if (i[3]) o = 2'b11;
    else if (i[2]) o = 2'b10;
    else if (i[1]) o = 2'b01;
    else o = 2'b00;
  end

endmodule




module tb_encoder;

reg	[3:0]	i;
wire 	[1:0]	o_enc, o_pr_enc;
wire		valid;

encoder		UUT1 (o_enc, valid, i);
pr_encoder	UUT2 (o_pr_enc, i);

initial
    begin
	#0	i = 4'b0001;
	#100	i = 4'b1000;
	#100	i = 4'b1110; // not valid in encoder, o = 2'b11 in priority encoder
	#100	i = 4'b0110; // not valid in encoder, o = 2'b10 in priority encoder
    end

endmodule