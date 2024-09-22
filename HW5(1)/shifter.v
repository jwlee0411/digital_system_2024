module			Barrel_shifter (o, i, s, c, clk);

output	[7:0]	o;
input	[7:0]	i;
input	[2:0]	s;
input	[1:0]	c;
input			clk;

reg		[7:0]	o;
reg		[7:0]	o_t;
reg		[2:0]	t;

always@(posedge clk)
    begin
        case(c)
            2'b00:	#20 o <= o;
            2'b01:	#20 //o <= o << s
                begin
                    o_t = o;
                    for(t = 0; t < s; t = t + 1)
                        o_t = {o_t[6:0],1'b0};
                    o = o_t;
                end
            2'b10:	#20 //o <= o >> s
                begin
                    o_t = o;
                    for(t = 0; t < s; t = t + 1)
                        o_t = {1'b0,o_t[7:1]};
                    o = o_t;
                end
            2'b11:	#20 o <= i;
            default:	#20 o <= 8'bx;
        endcase
    end

endmodule