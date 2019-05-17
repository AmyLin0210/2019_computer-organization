module ALU( 
    input  [31:0]Source1,
    input  [31:0]Source2,
    input  [4 :0]ALU_Ctrl,
    output [31:0]Result,
    output IsBranch
);

if( ALU_Ctrl[4] == 0 ) begin
    case ( ALU_Ctrl[3:0] )
        4'b0010: assign Result = Source1 + Source2;
        4'b0110: assign Result = Source1 - Source2;
        4'b1000: assign Result = Source1 << Source2[4:0];
        4'b0111: assign Result = ( Source1 < Source2 )? 1:0; // sign
        4'b1001: assign Result = ( Source1 < Source2 )? 1:0;
        4'b1010: assign Result = Source1 ^ Source2;
        4'b1011: assign Result = Source1 >> Source2[4:0];
        4'b1100: assign Result = Source1 >> Source2[4:0];    // sign
        4'b0001: assign Result = Source1 | Source2;
        4'b0000: assign Result = Source1 & Source2;
        default: assign Result = 31'b0;
    endcase
end
else begin
    case ( ALU_Ctrl[3:0] )
        4'b0110: assign IsBranch = ( (Source1-Source2) == 0 )? 1 : 0;
        4'b0001: assign IsBranch = ( (Source1-Source2) != 0 )? 1 : 0;
        4'b0010: assign IsBranch = ( Source1 < Source2 )? 1 : 0;  // sign
        4'b0011: assign IsBranch = ( Source1 >= Source2 )? 1 : 0;  // sign
        4'b0100: assign IsBranch = ( Source1 < Source2 )? 1 : 0;
        4'b0101: assign IsBranch = ( Source1 >= Source2 )? 1 : 0;
        default: assign IsBranch = 0;
    endcase
end

endmodule