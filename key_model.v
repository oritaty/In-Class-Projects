module key_model             //���ʱģ��
 (
 		input       CLK,                     //FPGAʱ������					
 		input       PinIn,
 		output      PinOut 	            
 );
 
 
reg rPinOut;
reg LastPinIn;
reg En;
reg [19:0]count;
  
always @ ( posedge CLK ) //���ʱ�������غ͸�λ�½���
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