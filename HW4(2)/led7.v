module			BCD_LED_7 (y, a, b, c, d);

output	[6:0]	y;
input			a, b, c, d;

assign y[0] = a | (b&d) | c | ((~b)&(~d));
assign y[1] = a | ((~c)&(~d)) | (c&d) | (~b);
assign y[2] = a | b | (~c) | d;
assign y[3] = ((~b)&(~d)) | (c&(~d)) | (b&(~c)&d) | ((~b)&c);
assign y[4] = ((~b)&(~d)) | (c&(~d));
assign y[5] = a | ((~c)&(~d)) | (b&(~d)) | (b&(~c));
assign y[6] = a | (c&(~d)) | (b&(~c)) | ((~b)&c);

endmodule



