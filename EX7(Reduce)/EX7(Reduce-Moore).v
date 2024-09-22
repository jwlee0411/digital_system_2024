module reduce_1s(out, clk, reset, in);

output        out;
input         clk, reset, in;
reg           out;
reg     [1:0] state_reg, state_next;

parameter     zero = 2'b00, one1 = 2'b01, two1s = 2'b10;

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
          state_next = two1s;
        else
          state_next = zero;
      two1s:
        begin
          out = 1;
          if (~in)
            state_next = zero;
        end
      default:
        state_next = zero;
    endcase
  end

endmodule