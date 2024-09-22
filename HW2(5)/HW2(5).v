// T-ff does not need to be described in homework
module			Tff (d, t, rst, clk);

output			d;
input			t, rst, clk;
reg				d;

always@(posedge rst or posedge clk)
  begin
    if(rst == 1)
      d <= 0;
    else if (t == 1)
      d <= ~d;
    else
      d <= d; 
  end
endmodule




module			Counter4 (d, run, rst, clk);

output	[3:0]	d;
input			run, rst, clk;
wire			db0, db1, db2;
supply1			logic1;

not				NOT1 (db0, d[0]);
not				NOT2 (db1, d[1]);
not				NOT3 (db2, d[2]);
Tff				TFF1 (d[0], run, rst, clk); 
Tff				TFF2 (d[1], logic1, rst, db0);
Tff				TFF3 (d[2], logic1, rst, db1);
Tff				TFF4 (d[3], logic1, rst, db2);

endmodule




module			Counter16 (d, run, rst, clk);

output	[15:0]	d;
input			run, rst, clk;
wire			db3, db7, db11;
supply1			logic1;

not				NOT1 (db3, d[3]);
not				NOT2 (db7, d[7]);
not				NOT3 (db11, d[11]);
Counter4		CNTR1 (d[3:0], run, rst, clk); 
Counter4		CNTR2 (d[7:4], logic1, rst, db3);
Counter4		CNTR3 (d[11:8], logic1, rst, db7);
Counter4		CNTR4 (d[15:12], logic1, rst, db11);

endmodule




module			tb_Counter16;

reg				clk, rst, run;
wire	[15:0]	d;

Counter16		UUT (d, run, rst, clk);

always
    begin
        #0		clk = 0;
        #5		clk = 1;
        #5		;
    end

initial
    begin
        #0		run = 0; rst = 0;
        #20		rst = 1;
        #20		rst = 0; run = 1;
        #100	run = 0;
        #100	run = 1;
        #10		run = 0;
        #80		run = 1;
    end

endmodule
