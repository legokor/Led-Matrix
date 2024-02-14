`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2023 23:45:28
// Design Name: 
// Module Name: testLoaderTest
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


module testLoaderTest;
    reg sysclk;
    reg sw0;
    reg sw1;
    reg reset;
    wire ar;
    
testLoader uut(
    .sysclk(sysclk),
    .sw0(sw0),
    .sw1(sw1),
    .ar(ar)
);
initial begin
    sysclk = 0;
    sw0 = 0;
    sw1 = 0;
    reset = 0;
    #100
    sw0 = 1;
    sw1 = 1;
end
    
always begin
    #4
	sysclk <= ~sysclk;
end 
endmodule
