`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2023 22:01:07
// Design Name: 
// Module Name: bitSenderTest
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module bitSenderTest;

	// Inputs
	reg clk;
	reg en;
	reg reset;
	reg wr;
	reg in;

	// Outputs
	wire sent;
	wire out;

	// Instantiate the Unit Under Test (UUT)
	bitSender uut (
		.clk(clk), 
		.en(en), 
		.reset(reset), 
		.wr(wr), 
		.in(in), 
		.sent(sent), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		en = 1;
		reset = 0;
		wr = 0;
		in = 0;

		#100;
      in = 1;
		wr = 1;
		#100;
		wr = 0;
		// Add stimulus here

	end
	always begin
		#10
		clk <= ~clk;
	end
      
endmodule

