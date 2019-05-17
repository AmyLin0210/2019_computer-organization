`define R_type 7'b0110011
`define Load   7'b0000011
`define Store  7'b0100011
`define B_type 7'b1100011
`define I_type 7'b0010011
`define JALR   7'b1100111
`define JAL    7'b1101111

module Decoder(
    input  [6:0] OP,
    output       RegDst,
    output       ALUSrc, 
    output       MemtoReg, 
    output       RegWrite, 
    output       MemRead, 
    output       MemWrite, 
    output       Branch, 
    output [1:0] ALUOp,
    output       Jump
);

assign RegDst   = ( OP == R_type )? 1 : 0;
assign MemRead  = ( OP == Load   )? 1 : 0;
assign MemtoReg = ( OP == Load   )? 1 : 0;
assign MemWrite = ( OP == Store  )? 1 : 0;
assign ALUSrc   = ( OP == Load   )? 1 :
                  ( OP == Store  )? 1 :
                  ( OP == I_type )? 1 :
                  ( OP == JALR   )? 1 : 0;
assign Jump     = ( OP == JAL    )? 1 : 0;
assign Branch   = ( OP == B_type )? 1 : 0;
assign ALUOp    = ( OP == R_type )? 2'b10 : 
                  ( OP == B_type )? 2'b01 : 0;
assign RegWrite = ( OP == R_type )? 1 :
                  ( OP == Load   )? 1 :
                  ( OP == I_type )? 1 :
                  ( OP == JALR   )? 1 : 0; 
                  
endmodule