//========== PC ================
//========== 11/21/2020===========
//================================
`include "defines.v"
module pc_reg(
    input wire                  clk,
    input wire                  rst,

    // From controller
    input wire  [5:0]           stall,
    input wire                  flush,
	input wire  [`RegBus]       new_pc,

    // Branch related
	input wire                  branch_flag_i,
	input wire  [`RegBus]       branch_target_address_i,

    output reg  [`InstAddrBus]  pc,
    output reg                  ce
);

always @(posedge clk) begin
    if (ce == `ChipDisable) begin
        pc <= `ZeroWord;
    end else begin 
        if (flush == 1'b1) begin
            pc <= new_pc;
        end else if(stall[0] == `NoStop) begin
            if(branch_flag_i == `Branch) begin
                pc <= branch_target_address_i;
            end else begin
                pc <= pc + 32'h4;
            end
        end
    end
end

always @(posedge clk) begin
    if (rst == `RstEnable) begin
        ce <= `ChipDisable;         // Disable ROM when resetting
    end else begin
        ce <= `ChipEnable;          // Enable ROM after resetting
    end
end

endmodule



