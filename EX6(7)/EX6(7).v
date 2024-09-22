module sign_mag_adder(s, a, b);

parameter	N = 4;
output	[N-1:0]	s;
input	[N-1:0]	a, b;
reg	[N-1:0]	s;
reg	[N-2:0]	mag_a, mag_b, mag_s, mag_1, mag_2;
reg		sign_a, sign_b, sign_s;

always@*
  begin
    mag_a = a[N-2:0];  mag_b = b[N-2:0]; sign_a = a[N-1]; sign_b = b[N-1];
    if (mag_a > mag_b)
      begin
        mag_1 = mag_a; mag_2 = mag_b; sign_s = sign_a;
      end
    else
      begin
        mag_1 = mag_b; mag_2 = mag_a; sign_s = sign_b;
      end
    if (sign_a == sign_b)
      mag_s = mag_1 + mag_2;
    else
      mag_s = mag_1 - mag_2;
    s = {sign_s, mag_s};
  end
endmodule




module tb_sign_mag_adder;

parameter	N = 4;
reg	[N-1:0]	a, b;
wire 	[N-1:0]	s;

sign_mag_adder	UUT (s, a, b);

initial
    begin
	#0	a = 4'b0100; b = 4'b1111; // a = +4, b = -7;
	#100	a = 4'b1111; b = 4'b0100; // a = -7, b = +4;
	#100	a = 4'b0111; b = 4'b1100; // a = +7, b = -4;
	#100	a = 4'b1100; b = 4'b0111; // a = -4, b = +7;
	#100	a = 4'b0100; b = 4'b0010; // a = +4, b = +2;
	#100	a = 4'b0010; b = 4'b0100; // a = +2, b = +4;
	#100	a = 4'b1100; b = 4'b1010; // a = -4, b = -2;
	#100	a = 4'b1010; b = 4'b1100; // a = -2, b = -4;
    end

endmodule