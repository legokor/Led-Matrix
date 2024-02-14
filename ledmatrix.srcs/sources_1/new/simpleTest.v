`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.11.2023 16:45:57
// Design Name: 
// Module Name: simpleTest
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


module simpleTest(
    input sysclk,
    input sw0,
    output wire ar
    );
    
reg busy;
wire rdy;
reg write;
localparam sending = 0;
localparam reset = 1;
reg state;

reg [13:0] resetCounter;
initial begin
    write <= 0;
    resetCounter <=0;
    state <= reset;
    #100;
end

reg [7:0] pictureCounter;

always @(posedge sysclk)begin
    if(sw0)begin
        case(state)
            sending:begin
                write<=1;   
                if(rdy == 1)begin
                    state <= reset;
                    /*if(pictureCounter < 255)begin
                        pictureCounter <= pictureCounter + 1;
                    end else
                        state <= reset; */
                end
            end
            reset:begin
                write<=0;
                if(resetCounter < 14000)begin
                    resetCounter <= resetCounter + 1;
                end
                else begin
                    resetCounter <= 0;
                    state <= sending;
                end
            end
        endcase
    end
end
    
    
RGBtoLED led (
    .clk(sysclk),
    .en(1),
    .reset(0),
    .R(8'b00000000),
    .G(8'b11111111),
    .B(8'b00000000),
    .wr(sw0 && write),
    .rdy(rdy),
    .dout(ar)
);
endmodule
