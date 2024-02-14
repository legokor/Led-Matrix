module RGBtoLEDTest;

	// Inputs
	reg clk;
	reg en;
	reg reset;
	reg [7:0] R;
	reg [7:0] G;
	reg [7:0] B;
	reg wr;

	// Outputs
	wire busy;
	wire rdy;
	wire dout;

	// Instantiate the Unit Under Test (UUT)
	RGBtoLED uut (
		.clk(clk), 
		.en(en), 
		.reset(reset), 
		.R(R), 
		.G(G), 
		.B(B), 
		.wr(wr), 
		.busy(busy), 
		.rdy(rdy), 
		.dout(dout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		en = 0;
		reset = 0;
		R = 0;
		G = 255;
		B = 0;
		wr = 0;

		// Wait 100 ns for global reset to finish
		#100;
		wr = 1;
        en = 1;
		// Add stimulus here

	end
   always begin
		#4
		clk <= ~clk;
	end
endmodule