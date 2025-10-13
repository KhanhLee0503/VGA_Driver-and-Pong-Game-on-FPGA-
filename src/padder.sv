module padder(
              input clk,
              input reset,
              input left,
              input right,
              output reg[8:0] pad_xpos
              );

parameter PAD_WIDTH = 40;
parameter PAD_HEIGHT = 20;
parameter PAD_SPEED = 2;
parameter SCREEN_WIDTH = 430;
reg [8:0] x_pos;


always_ff@(posedge clk or posedge reset) begin
    if(reset)begin
        x_pos <= (SCREEN_WIDTH/2) - (PAD_WIDTH/2);
    end
    else begin
        if ((left&&!right) && (x_pos - PAD_SPEED - 1 > 0)) begin
            x_pos <= x_pos - PAD_SPEED;
        end
        else if ((right&&!left) && (x_pos < SCREEN_WIDTH-PAD_WIDTH)) begin
            x_pos <= x_pos + PAD_SPEED;
        end
    end
end

always_comb begin
    pad_xpos = x_pos;
end

endmodule
