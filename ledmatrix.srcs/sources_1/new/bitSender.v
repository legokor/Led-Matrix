`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2023 21:58:19
// Design Name: 
// Module Name: bitSender
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


module bitSender(
	input clk,
	input en,
	input reset,
	input wr,
	input in,
	output reg sent,
	output reg out
   );
localparam [1:0] idle = 2'b00;
localparam [1:0] sending = 2'b01;
localparam [1:0] done = 2'b10;

reg [1:0]state = idle;
//reg send; 
reg [7:0]highCounter = 0;
reg [7:0]lowCounter = 0;

always @(posedge clk)begin
	if(en)begin
		if(reset)begin
			highCounter <= 0;
			lowCounter <= 0;
			out <=0;
			sent <= 0;
		end 
		else begin
			case(state)
				idle:begin
					//send <= in;
					sent <= 0;
					out <= 0;
					highCounter <= 0;
					lowCounter <= 0;
					if(wr == 1)
						state <= sending;
				end
				sending:begin
					if(in == 1)begin
						if(highCounter < 100)begin
							out <= 1;
							sent <= 0;
							highCounter <= highCounter + 1;
						end
						else begin
							if(lowCounter < 55)begin
								lowCounter <= lowCounter + 1;
								out <= 0;
								sent <= 0;
							end
							else 
								state <= done;
						end
					end
					else begin
						if(highCounter < 50)begin
							out <= 1;
							sent <= 0;
							highCounter <= highCounter + 1;
						end
						else begin
							if(lowCounter < 105)begin
								lowCounter <= lowCounter + 1;
								out <= 0;
								sent <= 0;
							end
							else 
								state <= done;
						end
					end
				end
				done:begin
					sent <= 1;
					out <= 0;
					state <= idle;
				end
				default:
					state <= idle;
			endcase
		end
					
			
		
	end
	else begin
		out<= 0;
		sent <= 0;
	end
end

endmodule
