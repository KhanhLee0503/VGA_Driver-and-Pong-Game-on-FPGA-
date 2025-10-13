module graphics_render(input clk,
                       input reset,
                       input left,
                       input right,
                       output reg V_Sync,
                       output reg H_Sync,
                       output reg[1:0]RED,
                       output reg[1:0]GREEN,
                       output reg[1:0]BLUE,
                       output reg button_left,
                       output reg button_right);

parameter PAD_WIDTH = 40;
parameter PAD_HEIGHT = 20;
parameter PAD_SPEED = 1;
parameter PAD_Y = 748;
parameter SCREEN_WIDTH = 430;
parameter SCREEN_HEIGHT = 768;
parameter BALL_SIZE = 6;

parameter DIRECTION_LEFT    = 0;
parameter DIRECTION_RIGHT   = 1;
parameter DIRECTION_UP      = 0;
parameter DIRECTION_DOWN    = 1;
parameter BALL_SPEED        = 2;

wire inDisplay;
reg [9:0] x_counter;
reg [9:0] y_counter;

reg [8:0] pad_x;
reg [8:0] ball_x;
reg [9:0] ball_y;

logic i_reset;
logic direction_x_reg;
logic direction_y_reg;

reg clk_divided;
reg [17:0] clk_counter = 17'b0;
//Clock divider from 25MHz to 100Hz
always_ff@(posedge clk) begin
    if (clk_counter == 124999) begin
            clk_counter <= 17'b0;
            clk_divided <= ~clk_divided;
    end
    else    clk_counter <= clk_counter + 1;

end

clock_generator clkgen(.clk(clk), .X_counter(x_counter), .Y_counter(y_counter), .DisplayArea(inDisplay), .H_Sync(H_Sync), .V_Sync(V_Sync));

padder padder(.clk(clk_divided), .reset(reset), .pad_xpos(pad_x), .left(left), .right(right));

ball ball(.clk(clk_divided), .reset(i_reset), .ball_xpos(ball_x), .ball_ypos(ball_y), .direction_y(direction_y_reg), .direction_x(direction_x_reg));


always_ff@(posedge clk) begin
    i_reset = 1'b0;

    //Paddle Collison
    if ((ball_x >= pad_x) && (ball_x + BALL_SIZE <= pad_x + PAD_WIDTH) && (ball_y + BALL_SIZE >= PAD_Y))
        direction_y_reg <= DIRECTION_UP;
    
    //Monitor Collision
            if((ball_x == SCREEN_WIDTH - BALL_SIZE) && (direction_x_reg == DIRECTION_RIGHT))
                direction_x_reg <= DIRECTION_LEFT;

            if(ball_y == SCREEN_HEIGHT - BALL_SIZE - BALL_SPEED - 1)
                i_reset = 1'b1;

            if((ball_x == 0 + BALL_SIZE) && (direction_x_reg == DIRECTION_LEFT))
                direction_x_reg <= DIRECTION_RIGHT;
            
            if((ball_y == 0 + BALL_SIZE + BALL_SPEED + 1) && (direction_y_reg == DIRECTION_UP))
                direction_y_reg <= DIRECTION_DOWN;
    
    //Drawing paddle
    if ((x_counter>=pad_x) && (x_counter<=pad_x+PAD_WIDTH) && (y_counter>=PAD_Y) && (y_counter<=PAD_Y+PAD_HEIGHT) && inDisplay) begin
        RED   <= 2'b11;
        BLUE  <= 2'b11;
        GREEN <= 2'b11;
    end
    
    //Drawing a ball
    else if ((x_counter>=ball_x) && (x_counter<=ball_x+BALL_SIZE) && (y_counter>=ball_y) && (y_counter<=ball_y+BALL_SIZE) && inDisplay) begin
        RED   <= 2'b11;
        BLUE  <= 2'b11;
        GREEN <= 2'b11;
    end    
    
    else begin
        RED   <= 2'b00;
        BLUE  <= 2'b00;
        GREEN <= 2'b00;
    end 
end


always_comb begin
    if (left == 1'b1)  button_left = 1'b1;
    else if (left == 1'b0) button_left = 1'b0;
end

always_comb begin
    if (right == 1'b1)  button_right = 1'b1;
    else if (right == 1'b0) button_right = 1'b0;
end


endmodule
