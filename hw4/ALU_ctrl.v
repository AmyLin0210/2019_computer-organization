module ALU_ctrl(
    input [6:0]Funct7,
    input [2:0]Funct3,
    input [1:0]ALUOp,
    output [4:0]ALU_ctrl_out
);

case ( ALUOp )
    2'b10:
        assign ALU_ctrl_out = 
            (Funct3 == 3'b000 && Funct7 == 7'b0000000)? 5'b00010 :
            (Funct3 == 3'b000 && Funct7 == 7'b0100000)? 5'b00110 :
            (Funct3 == 3'b001 && Funct7 == 7'b0000000)? 5'b01000 :
            (Funct3 == 3'b010 && Funct7 == 7'b0000000)? 5'b00111 :
            (Funct3 == 3'b011 && Funct7 == 7'b0000000)? 5'b01001 :
            (Funct3 == 3'b100 && Funct7 == 7'b0000000)? 5'b01010 :
            (Funct3 == 3'b101 && Funct7 == 7'b0000000)? 5'b01011 :
            (Funct3 == 3'b101 && Funct7 == 7'b0100000)? 5'b01100 :
            (Funct3 == 3'b110 && Funct7 == 7'b0000000)? 5'b01000 :
            (Funct3 == 3'b111 && Funct7 == 7'b0000000)? 5'b01000 : 5'b00000;
    2'b01:
        assign ALU_ctrl_out = 
            (Funct3 == 3'b000)? 5'b10110 :
            (Funct3 == 3'b001)? 5'b10001 :
            (Funct3 == 3'b100)? 5'b10010 :
            (Funct3 == 3'b101)? 5'b10011 :
            (Funct3 == 3'b110)? 5'b10100 :
            (Funct3 == 3'b111)? 5'b10101 : 5'b00000;
    2'b00:
        assign ALU_ctrl_out = 5'b00010;
    default:
        assign ALU_ctrl_out = 5'b00000;
endcase

endmodule