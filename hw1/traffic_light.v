/* 
 * Do not change Module name 
*/
module traffic_light (
    input  clk,
    input  rst,
    input  pass,
    output reg R,
    output reg G,
    output reg Y
);


reg [9:0]count = 10'd0;
reg [2:0]status = 3'd0;

always @(posedge clk or posedge rst)
begin

if( pass )
begin
	if( status != 3'd0 )
	begin
		status = 3'd0;
		count = 10'd0;
	end
end

if( rst )
begin
    status = 3'd0;
    count = 10'd0;
	 G = 1'b0;
	 R = 1'b0;
	 Y = 1'b0;
end
	case( status )
		 3'd0: begin
			  if( count < 10'd1023 )
			  begin
					G = 1'b1;
					R = 1'b0;
					Y = 1'b0;
					count = count + 10'd1;
			  end
			  else
			  begin
					count = 10'd0;
					status = 3'd1;
			  end
		 end
		 3'd1: begin
			  if( count < 10'd127 )
			  begin
					G = 1'b0;
					R = 1'b0;
					Y = 1'b0;
					count = count + 10'd1;
			  end
			  else
			  begin
					status = 3'd2;
					count = 10'd0;
			  end
		 end
		 3'd2: begin
			  if( count < 10'd127 )
			  begin
					G = 1'b1;
					R = 1'b0;
					Y = 1'b0;
					count = count + 10'd1;
			  end
			  else
			  begin
					status = 3'd3;
					count = 10'd0;
			  end
		 end
		 3'd3: begin
			  if( count < 10'd127 )
			  begin
					G = 1'b0;
					R = 1'b0;
					Y = 1'b0;
					count = count + 10'd1;
			  end
			  else
			  begin
					status = 3'd4;
					count = 10'd0;
			  end
		 end
		 3'd4: begin
			  if( count < 10'd127 )
			  begin
					G = 1'b1;
					R = 1'b0;
					Y = 1'b0;
					count = count + 10'd1;
			  end
			  else
			  begin
					status = 3'd5;
					count = 10'd0;
			  end
		 end
		 3'd5: begin
			  if( count < 10'd511 )
			  begin
					G = 1'b0;
					R = 1'b0;
					Y = 1;
					count = count + 10'd1;
			  end
			  else
			  begin
					status = 3'd6;
					count = 10'd0;
			  end
		 end
		 3'd6: begin
			  if( count < 10'd1023 )
			  begin
					G = 1'b0;
					R = 1;
					Y = 1'b0;
					count = count + 10'd1;
			  end
			  else
			  begin
					status = 3'd0;
					count = 10'd0;
			  end
		 end
		 default: begin
			  G = 1;
			  R = 1'b0;
			  Y = 1'b0;
			  count = 10'd0;
			  status = 3'd0;
		 end
	endcase
end


endmodule
