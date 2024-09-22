module rising_edge_detector(tick, clk, reset, level);

output        tick;
input         clk, reset, level;
reg           tick;
reg     [1:0] state_reg, state_next;

parameter     zero = 2'b00, edg = 2'b01, one = 2'b10;

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
          state_next = edg;
      edg:
        begin
          tick = 1;
          if (level)
            state_next = one;
          else
            state_next = zero;
        end
      one:
        if (~level)
          state_next = zero;
      default:
        state_next = zero;
    endcase
  end
  
endmodule

