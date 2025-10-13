// This module represents a Block RAM (BRAM) used to store the pixel data for VGA.
// The data is pre-loaded from a .hex file during synthesis.
module vga_memory(
    input   wire        i_clk,     // System clock
    input   wire [18:0] i_addr,    // 19-bit address bus (0 to 341,849)
    output  reg  [5:0]  o_rdata    // 6-bit color data output
);
parameter N = 105000;
/*
// Declare the memory array with 6-bit data width and 330240 locations.
// The `(* rom_style = "block" *)` attribute tells the synthesizer to use BRAM.
// The `(* rom_file = "sekiro_6bit.hex" *)` attribute specifies the .hex file to load.
// Adjust the filename to match the .hex file you generate.
(* rom_style = "block", rom_file = "sekiro_6bit.hex" *)
*/
reg [5:0] mem_word [0:N-1];

initial begin
    $readmemh("sekiro_6bit_350x300.hex",mem_word,0,N-1);
end

//(* rom_style = "block", rom_file = "sekiro_6bit.hex" *) 

// This `always_ff` block implements a synchronous read from the BRAM.
// The read data is only updated on the positive edge of the clock.
always_ff @(posedge i_clk) begin
    o_rdata <= mem_word[i_addr];
end
    
endmodule
