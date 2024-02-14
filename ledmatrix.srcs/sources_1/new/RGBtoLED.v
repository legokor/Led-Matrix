module RGBtoLED(
	input clk,
	input en,
	input reset,
	input [7:0]R,
	input [7:0]G,
	input [7:0]B,
	input wr,
	output reg busy,
	output reg rdy,
	output wire dout
	);
reg [23:0] colourData;
reg currentbit;
reg [4:0] sentNum = 0;
wire sentOne;
reg sendBit = 0;

localparam [1:0] idle = 2'b00;
localparam [1:0] sending = 2'b01;
localparam [1:0] done = 2'b10;

reg [1:0] state = idle;

initial begin
colourData <= {G,R,B};
currentbit <= colourData[23];
sendBit <= 0;
end

always @(posedge clk)begin
	if(en)begin
		if(reset)begin
			sentNum <= 0;
			colourData <= {G,R,B};
			currentbit <= colourData[23];
			sendBit <= 0;
		end 
		else begin
			case(state)
				idle:begin
					sentNum <= 0;
					colourData <= {G,R,B};
					currentbit <= colourData[23];
					sendBit <= 0;
					if(wr)
						state <= sending;
				end
				sending:begin
					if(wr)begin
						colourData <= {G,R,B};
						currentbit = colourData[23-sentNum];
						if(sentNum < 24)begin
							rdy <= 0;
							busy <= 1;
							sendBit <= 1;
							if(sentOne == 1)begin
								sendBit = 0;
								sentNum = sentNum + 1;
								currentbit = colourData[23-sentNum];
							end
						end
						else begin
							sendBit<= 0;
							state <= done;
						end
					end
					else begin
						sendBit<= 0;
					end
				end
				done:begin
					rdy <= 1;
					busy <= 0;
					state <= idle;
				end
				
			endcase
		end
	end

end

bitSender bitSender(
	.clk(clk),
	.en(en),
	.reset(reset),
	.wr(sendBit),
	.in(currentbit),
	.sent(sentOne),
	.out(dout)
);

endmodule