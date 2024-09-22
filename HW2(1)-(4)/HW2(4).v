// Synchronous set
module			DFFwS (q, set, d, clk);

output			q;
input			set, d, clk;
reg				q;

always@(posedge clk)
    begin
        if (set == 1)
            q <= 1;
        else
            q <= d;
    end

endmodule




// Asynchronous set
module			DFFwS (q, set, d, clk);

output			q;
input			set, d, clk;
reg				q;

always@(posedge set or posedge clk)
    begin
        if (set == 1)
            q <= 1;
        else
            q <= d;
    end

endmodule
