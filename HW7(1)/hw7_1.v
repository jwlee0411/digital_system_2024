module DiceGame(Rb, Reset, CLK, Sum, Roll, Win, Lose);

input		Rb;
input		Reset;
input		CLK;
input	[3:0]	Sum;
output		Roll;
output		Win;
output		Lose;

reg		Roll;
reg		Win;
reg		Lose;

reg	[2:0]	State;
reg	[2:0]	Nextstate;
reg	[3:0]	Point;
reg		Sp;

initial
begin
	State = 0;
	Nextstate = 0;
	Point = 2;
end

always@(Rb or Reset or Sum or State)
begin
	Sp = 1'b0;
	Roll = 1'b0;
	Win = 1'b0;
	Lose = 1'b0;
	Nextstate = 0;
	case(State)
		3'd0:
		begin
			if(Rb == 1'b1)
			begin
				Nextstate = 1;
			end
		end
		3'd1:
		begin
			if(Rb == 1'b1)
			begin
				Roll = 1'b1;
			end
			else if(Sum == 7 | Sum == 11)
			begin
				Nextstate = 2;
			end
			else if(Sum == 2 | Sum == 3 | Sum == 12)
			begin
				Nextstate = 3;
			end
			else
			begin
				Sp = 1'b1;
				Nextstate = 4;
			end
		end
		3'd2://Win
		begin
			Win = 1;
			if(Reset == 1)
				Nextstate = 0;
			else
				Nextstate = 2;
		end
		3'd3://Lose
		begin
			Lose = 1;
			if(Reset == 1)
				Nextstate = 0;
			else
				Nextstate = 3;
		end
		3'd4:
		begin
			if(Rb == 1'b1)
			begin
				Nextstate = 5;
			end
			else
				Nextstate = 4;
		end
		3'd5:
		begin
			if(Rb == 1'b1)
			begin
				Roll = 1'b1;
			end
			else if(Sum == Point)
				Nextstate = 2;
			else if(Sum == 7)
				Nextstate = 3;
			else
				Nextstate = 4;
		end
	endcase
end

always@(posedge CLK)
begin
	State <= Nextstate;
	if(Sp == 1'b1)
	begin
		Point <= Sum;
	end
end

endmodule


module tb_DiceGame;

reg		Rb;
reg		Reset;
reg		CLK;
reg	[3:0]	Sum;
wire		Roll;
wire		Win;
wire		Lose;

DiceGame	UUT	(Rb, Reset, CLK, Sum, Roll, Win, Lose);

initial	CLK = 0;
always	#5 CLK = ~CLK;

initial
begin
	#10	Rb = 0; Reset = 0; Sum = 4'd0;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd7;//Win1
	#10	Rb = 0; Reset = 1; Sum = 4'd0;

	#10	Rb = 0; Reset = 0; Sum = 4'd0;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd11;//Win1
	#10	Rb = 0; Reset = 1; Sum = 4'd0;
	
	#10	Rb = 0; Reset = 0; Sum = 4'd0;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd2;//Lose1
	#10	Rb = 0; Reset = 1; Sum = 4'd0;
	
	#10	Rb = 0; Reset = 0; Sum = 4'd0;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd3;//Lose1
	#10	Rb = 0; Reset = 1; Sum = 4'd0;
	
	#10	Rb = 0; Reset = 0; Sum = 4'd0;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd12;//Lose1
	#10	Rb = 0; Reset = 1; Sum = 4'd0;

	//Second Phase
	#10	Rb = 0; Reset = 0; Sum = 4'd0;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd1;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd2;//Again
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd1;//Win Eq
	#10	Rb = 0; Reset = 1; Sum = 4'd0;

	#10	Rb = 0; Reset = 0; Sum = 4'd0;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd14;
	#10	Rb = 1; Reset = 0; Sum = 4'd0;
	#10	Rb = 0; Reset = 0; Sum = 4'd7;//Lose2
	#10	Rb = 0; Reset = 1; Sum = 4'd0;
end

endmodule
