module reduce_1s(out, clk, reset, in);

output    out;
input     clk, reset, in;
reg       out;
reg       state_reg, state_next;

parameter zero = 1'b0, one1 = 1'b1;

always@(posedge clk, posedge reset)
  begin
    if (reset)
      state_reg <= zero;
    else
      state_reg <= state_next;
  end
  
always@*
  begin
    state_next = state_reg; out = 0; 
    case (state_reg)
      zero:
        if (in)
          state_next = one1;
      one1:
        if (in)
          out = 1;
        else
          state_next = zero;
      default:
        state_next = zero;
    endcase
  end

endmodule