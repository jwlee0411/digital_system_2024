module fp_adder (signout, expout, fracout, sign1, exp1, frac1, sign2, exp2, frac2);

// inputs and outputs
input		sign1, sign2;
input 	[3:0]	exp1, exp2;
input 	[7:0]	frac1, frac2;
output 		signout;
output 	[3:0]	expout;
output	[7:0]	fracout;
reg 		signout;
reg 	[3:0]	expout;
reg	[7:0]	fracout;

// big and small numbers
reg		signb, signs;
reg	[3:0]	expb, exps;
reg 	[7:0]	fracb, fracs;

// working variables
reg	[3:0]	expdiff, expn;
reg	[7:0]	fraca, fracn, sumnorm;
reg	[8:0]	sum;
reg	[2:0]	lead0;

always@*
    begin

	//stage 1: sort
	if ({exp1, frac1} > {exp2, frac2})
	    begin
		signb = sign1; signs = sign2;
		expb = exp1; exps = exp2;
		fracb = frac1; fracs = frac2;
	    end
	else
	    begin
		signb = sign2; signs = sign1;
		expb = exp2; exps = exp1;
		fracb = frac2; fracs = frac1;    
	    end	

	//stage 2: align
	expdiff = expb - exps;
	fraca = fracs >> expdiff;	

	//stage 3: add/sub
	if (signb == signs)
	    sum = {1'b0, fracb} + {1'b0, fraca};
	else
	    sum = {1'b0, fracb} - {1'b0, fraca};

	//stage 4: normalize 

	//counting leading 0
	if (sum[7])		lead0 = 3'o0;
	else if (sum[6])	lead0 = 3'o1; 
	else if (sum[5])	lead0 = 3'o2;
	else if (sum[4])	lead0 = 3'o3;
	else if (sum[3])	lead0 = 3'o4;
	else if (sum[2])	lead0 = 3'o5;
	else if (sum[1])	lead0 = 3'o6;
	else			lead0 = 3'o7;

	// shift fraction according to leading 0
	sumnorm = sum << lead0;  	

	// normalize with various conditions
	if (sum[8]) // with carry ==1
	    begin
		expn = expb + 1;
		fracn = sum[8:1];
	    end
	else if (lead0 > expb) // too small to normalize
	    begin
		expn = 0;
		fracn = 0;
	    end
	else // normalize
	    begin
		expn = expb - lead0;
		fracn = sumnorm;
	    end

	//output logic
	signout = signb;
	expout = expn;
	fracout = fracn;	
    end

endmodule


module tb_fp_adder;

reg		sign1, sign2;
reg 	[3:0]	exp1, exp2;
reg 	[7:0]	frac1, frac2;
wire 		signout;
wire 	[3:0]	expout;
wire	[7:0]	fracout;

fp_adder UUT (signout, expout, fracout, sign1, exp1, frac1, sign2, exp2, frac2);

initial
    begin
	#100	sign1 = 0; exp1 = 4'd3; frac1 = 8'b11101011;
		sign2 = 1; exp2 = 4'd4; frac2 = 8'b11010010;

	#100	sign1 = 0; exp1 = 4'd5; frac1 = 8'b11101100;
		sign2 = 1; exp2 = 4'd5; frac2 = 8'b10011101;

	#100	sign1 = 0; exp1 = 4'd2; frac1 = 8'b11001100; 
		sign2 = 1; exp2 = 4'd2; frac2 = 8'b11001111; 

	#100	sign1 = 0; exp1 = 4'd3; frac1 = 8'b11101110; 
		sign2 = 0; exp2 = 4'd3; frac2 = 8'b11101110; 
    end

endmodule
