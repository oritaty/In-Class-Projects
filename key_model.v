module key_model             //秒计时模块
 (
 		input       CLK,                     //FPGA时钟脉冲					
 		input       PinIn,
 		output      PinOut 	            
 );
 
 
reg rPinOut;
reg LastPinIn;
reg En;
reg [19:0]count;
  
always @ ( posedge CLK ) //检测时钟上升沿和复位下降沿
 begin
	LastPinIn <= PinIn;
	if( (PinIn==0)&&(LastPinIn==1) ) begin 
		En<='b1;
	end
	
	if(En==1) begin
		count <= count + 'b1;
	end 
	
	if(count>'d500000) begin
		if(PinIn==0) begin
			rPinOut <= 'b1;
		end 
		count <= 'd0;
		En <= 'b0;
	end 
	
	if(rPinOut==1) begin
		rPinOut <= 'b0;
	end
	
 end 
		
/****************************/          

assign PinOut = rPinOut; 

/****************************/  


endmodule 