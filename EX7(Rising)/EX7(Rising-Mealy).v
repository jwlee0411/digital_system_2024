module rising_edge_detector(tick, clk, reset, level);

output    tick;
input     clk, reset, level;
reg       tick;
reg       state_reg, state_next;

parameter zero = 1'b0, one = 1'b1;

always@(posedge clk, posedge reset)
  begin
    if (reset)
      state_reg <= zero;
    else
      state_reg <= state_next;
  end
  
always@*
  begin
    state_next = state_reg; tick = 0;
    case (state_reg)
      zero:
        if (level)
          begin
            tick = 1;
            state_next = one;
          end
      one:
        if (~level)
          state_next = zero;
      default:
        state_next = zero;
    endcase
  end
  
endmodule

