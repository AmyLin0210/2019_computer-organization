module  PC(
    input          clk,
    input          rst,
    input  [31:0]pc_in,
    output [31:0]pc_out
);

initial begin
    pc_out = 0;
end

always@( posedge clk ) begin
    if( rst )
        pc_out <= 0;
    else 
        pc_out <= pc_in;
end
    
endmodule