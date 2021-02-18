//========== IF/ID ================
//========== 11/21/2020===========
//================================
`include "defines.v"
module if_id(
    input wire                  clk,
    input wire                  rst,
    
    // From pipeline control
	input wire  [5:0]           stall,
    input wire                  flush,

    // From instruction fetch
    input wire [`InstAddrBus]   if_pc,
    input wire [`InstBus]       if_inst,

    // Corresponding decoding signals
    output reg [`InstAddrBus]   id_pc,
    output reg [`InstBus]       id_inst
);

always @(posedge clk) begin
    if (rst == `RstEnable) begin
        id_pc   <= `ZeroWord;       // 0 @ resetting
        id_inst <= `ZeroWord;       // null inst @ resetting
    end else if(flush == 1'b1 ) begin
        id_pc <= `ZeroWord;
        id_inst <= `ZeroWord;
    end else if((stall[1] == `Stop) && (stall[2] == `NoStop)) begin
        id_pc   <= `ZeroWord;
        id_inst <= `ZeroWord;	
    end else if(stall[1] == `NoStop) begin
        id_pc   <= if_pc;
        id_inst <= if_inst;
    end
end


endmodule


