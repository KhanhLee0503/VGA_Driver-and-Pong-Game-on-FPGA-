`timescale 1ns/1ns
module clock_tb();
wire h_sync;
wire v_sync;
reg clock;

clock_generator dut(.clk(clock), .H_Sync(h_sync), .V_Sync(v_sync));



//Generating clock
initial begin
    clock = 1'b0;
    forever #18.5 clock = ~clock;
end

endmodule
