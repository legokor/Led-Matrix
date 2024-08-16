`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2023 23:32:45
// Design Name: 
// Module Name: testLoader
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


module testLoader(
    input sysclk,
    input sw0,
    input sw1,
    output wire ar
    );

reg [10:0] pictureCounter = 0;
reg [9:0] pixelCounter = 0;
reg [26:0] resetCounter = 0;
reg [7:0] pixelR;
reg [7:0] pixelG;
reg [7:0] pixelB;


reg write;
wire rdy;
wire busy;

localparam idle = 2'b00;
localparam sendingPixel = 2'b01;
 localparam nextPixel = 2'b10;
localparam nextPicture = 2'b11;

reg [1:0]state = idle;    

reg indxStart = 0;
reg indxEnd =0;
reg [7:0] pictureData [0:5375];
reg first = 1;

initial begin
    write <= 0;
    state <= idle;
    pictureCounter <= 0;
    $readmemh("testfile.mem",pictureData,0,5375);
end
 
always @(posedge sysclk)begin
    if(sw1)begin
        case(state)
            idle:begin
                write <= 0;
                if(sw0 == 1)
                    state <= sendingPixel;
            end
            sendingPixel:begin
                pixelR <= pictureData[pictureCounter*768 + pixelCounter];
                pixelG <= pictureData[(pictureCounter*768 + pixelCounter)+1];
                pixelB <= pictureData[(pictureCounter*768 + pixelCounter)+2];
                
                write <= 1;
                if(rdy == 1)
                    state<= nextPixel;
            end
            nextPixel:begin
                write <=0;
                
                if(pixelCounter < 767)begin
                   pixelCounter <= pixelCounter + 3;
                   
                   state <= sendingPixel;
                end
                else begin
                   pixelCounter <= 0;
                   state <= nextPicture;
                end
                    
            end
            nextPicture:begin
                write <= 0;
                
                if (resetCounter < 62500000)begin
                    resetCounter <= resetCounter + 1;
                end
                else begin
                    resetCounter <= 0;
                   
                    if(pictureCounter < 7)
                       pictureCounter = pictureCounter + 1;
                    else
                       pictureCounter = 0;
                          
                    state <= idle;
                end
            end
        endcase 
    end
end


RGBtoLED matrix1 (
    .clk(sysclk),
    .en(sw1),
    .reset(0),
    .R(pixelR),
    .G(pixelG),
    .B(pixelB),
    .wr(sw0 && write),
    .busy(busy),
    .rdy(rdy),
    .dout(ar)
);

endmodule
