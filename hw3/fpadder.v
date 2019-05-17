module fpadder (   input [31:0] src1,
    input [31:0] src2,
    output reg [31:0] out
);
reg [47:0]fraTemp;
reg [45:0]fra1, fra2;
reg [23:0]temp;
reg [8:0]expTemp;
reg [7:0]exp1, exp2;
reg [5:0]fraDig, t1, t2;
reg [2:0]GRS;

function [47:0]ADD;
	input [45:0]fraB, fraS;
	input signB, signS;
	begin
		if( signB & signS ) begin
			ADD = fraB+fraS;
			ADD[47] = 1;
		end
		else if( signB & !signS ) begin
			ADD = fraB-fraS;
			ADD[47] = 1;
		end
		else if( !signB & signS ) begin
			ADD = fraB-fraS;	
			ADD[47] = 0;
		end
		else if( !signB & !signS)begin
			ADD = fraB +fraS;
			ADD[47] = 0;
		end
		else begin
		    ADD = fraB + fraS;
		    ADD[47] = 1'bx;
		end
	end
endfunction

always @(src1 or src2)
begin
    fra1 = 46'd0;
    fra2 = 46'd0;
    if( src1[30:23] == 8'b00000000 ) begin
        fra1[45] = 0;
        exp1 = 8'b00000001;
    end
    else begin
        fra1[45] = 1;
        exp1 = src1[30:23];
    end
    
    if( src2[30:23] == 8'b00000000 ) begin
        fra2[45] = 0;
        exp2 = 8'b00000001;
    end
    else begin
        fra2[45] = 1;
        exp2 = src2[30:23];
    end
        
	fra1[44:22] = src1[22:0];
	fra2[44:22] = src2[22:0];
	
	if( exp1 > exp2) begin
		fra2 = fra2 >> (exp1 - exp2);
		expTemp = exp1;
		fraTemp = ADD( fra1, fra2, src1[31], src2[31] );
	end
	else if( exp1 < exp2) begin
		fra1 = fra1 >> (exp2 - exp1);
		expTemp = exp2;
		fraTemp = ADD( fra2, fra1, src2[31], src1[31] );
	end
	else begin
		expTemp = exp2;
		if( fra1 > fra2 )
		    fraTemp = ADD( fra1, fra2, src1[31], src2[31] );
		else
		    fraTemp = ADD( fra2, fra1, src2[31], src1[31] );
	end
	
	out[31] = fraTemp[47];
	
	t1 = 6'd0;
	if(fraTemp[46]) begin
	    fraTemp = fraTemp >> 1;
	    expTemp = expTemp + 1;
	end
	else begin
	    while( !fraTemp[45]  & ( t1 < 6'd24 ) ) begin
	        t1 = t1 + 6'd1;
	        fraTemp = fraTemp << 1;
	        expTemp = expTemp - 1;
	    end
	end
	
	GRS[2:1] = fraTemp[21:20];
	
	if( fraTemp[19:0] != 20'd0 )
	    GRS[0] = 1;
	else
	    GRS[0] = 0;
	
	if( GRS == 3'd4 ) begin
	    if(fraTemp[22]) begin
		    temp = fraTemp[44:22];
		    temp = temp + 1;
		    fraTemp[44:22] = temp;
        end
	end
	else if ( GRS > 3'd4 ) begin
		temp = fraTemp[44:22];
		temp = temp + 1;
		fraTemp[44:22] = temp;
	end		

	out[22:0] = fraTemp[44:22];
	out[30:23] = expTemp[7:0] ;
	
	if( fraTemp[44:22]  == 23'd0)
	    out = 32'd0;
	
	if( src1[30:0] == src2[30:0]) begin
	    if(src1[31] & !src2[31] ) 
	        out = 32'd0;
	    else if( !src1[31] & src2[31])
            out = 32'd0;	        
    end	
    
    if( out[30:23] == 8'b11111111 )
        out[22:0] = 23'd0;
    
end

endmodule


