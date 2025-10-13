module ball(
    input  logic clk,
    input  logic reset,
    input logic direction_y,
    input logic direction_x,
    output logic [8:0] ball_xpos,
    output logic [9:0] ball_ypos
);
    // --- Thông số màn hình và kích thước bóng ---
    localparam [9:0] SCREEN_WIDTH   = 10'd430;
    localparam [10:0] SCREEN_HEIGHT = 11'd768;
    parameter BALL_SIZE         = 6;
    parameter DIRECTION_LEFT    = 0;
    parameter DIRECTION_RIGHT   = 1;
    parameter DIRECTION_UP      = 0;
    parameter DIRECTION_DOWN    = 1;
    parameter BALL_SPEED        = 2;

    parameter PAD_Y      = 748;
    parameter PAD_WIDTH = 40;

    // --- Vị trí và vận tốc ---
    logic [9:0]  x_pos;
    logic [10:0] y_pos;
    logic [8:0] pad_pos;

padder padder(
      .clk(clk),
      .reset(reset),
      .pad_xpos(pad_pos)
       );

always_ff@(posedge clk) begin
    if(reset) begin
           x_pos <= SCREEN_WIDTH/2 - BALL_SIZE/2;
           y_pos <= SCREEN_HEIGHT/8 - BALL_SIZE/2;
    end
    
    else begin    
            if      (direction_x == DIRECTION_LEFT)  x_pos <= x_pos - BALL_SPEED;
            if (direction_x== DIRECTION_RIGHT)      x_pos <= x_pos + BALL_SPEED;
            if      (direction_y == DIRECTION_UP)    y_pos <= y_pos - BALL_SPEED;
            if (direction_y == DIRECTION_DOWN)       y_pos <= y_pos + BALL_SPEED;
    end
end

assign ball_xpos = x_pos;
assign ball_ypos = y_pos;
endmodule
