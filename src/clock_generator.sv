module clock_generator(input clk,
                       output reg H_Sync,
                       output reg V_Sync,
                       output reg [9:0] X_counter,
                       output reg [9:0] Y_counter,
                       output reg DisplayArea
                        );
parameter X_counter_maxed = 565;
parameter Y_counter_maxed = 794;

reg h_signal;
reg v_signal;

always_ff@(posedge clk) begin
    if(X_counter == X_counter_maxed) X_counter <= 0;
    else X_counter <= X_counter + 1;
end


always_ff@(posedge clk) begin
    if (Y_counter == Y_counter_maxed) Y_counter <= 0;
    else begin
            if(X_counter == X_counter_maxed) Y_counter <= Y_counter + 1;
    end
end

always_ff@(posedge clk) begin
    if((X_counter >= 10'd452) && (X_counter <= 10'd496)) h_signal <= 0;
    else h_signal <= 1;
    
    if((Y_counter >= 10'd768) && (Y_counter <= 10'd770)) v_signal <= 0;
    else v_signal <= 1;
end

always_ff@(posedge clk) begin
    if((X_counter >= 0)&&(X_counter <= 429)&&(Y_counter >= 0)&&(Y_counter <= 767)) DisplayArea <= 1;
    else DisplayArea <= 0; 
end
assign H_Sync = h_signal;
assign V_Sync = v_signal;

endmodule:clock_generator
