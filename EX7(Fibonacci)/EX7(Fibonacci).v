module fibonacci(ready, done_tick, f, clk, reset, start, i);

output          ready, done_tick;
output  [19:0]  f;
input           clk, reset, start;
input   [4:0]   i;
reg     [1:0]   state_reg, state_next;
reg     [19:0]  t0_reg, t0_next, t1_reg, t1_next;
reg     [4:0]   n_reg, n_next;
reg             ready, done_tick;

parameter       idle = 2'b00, op = 2'b01, done = 2'b10;

always@(posedge clk, posedge reset)
  if (reset)
    begin
      state_reg <= idle; t0_reg <= 0; t1_reg <= 0; n_reg <= 0;
    end
  else
    begin
      state_reg <= state_next; t0_reg <= t0_next; t1_reg <= t1_next; n_reg <= n_next;
    end
    
always@*
  begin
    state_next = state_reg; t0_next = t0_reg; t1_next = t1_reg; n_next = n_reg; ready = 0; done_tick = 0;
    case (state_reg)
      idle:
        begin
          ready = 1;
          if (start)
            begin
              t0_next = 0;
              t1_next = 1;
              n_next = i;
              state_next = op;
            end
        end
      op:
        if (n_reg == 0)
          begin
            t1_next = 0;
            state_next = done;
          end
        else if (n_reg == 1)
          state_next = done;
        else
          begin
            t1_next = t1_reg + t0_reg;
            t0_next = t1_reg;
            n_next = n_reg - 1;
          end
      done:
        begin
          done_tick = 1;
          state_next = idle;
        end
      default:
        state_next = idle;
    endcase
  end

assign f = t1_reg;

endmodule