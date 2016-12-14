module contorl_model             //秒计时模块
 (
 		input       CLK,                     //FPGA时钟脉冲					
 		input       RSTn,
		input       Key1,
		input       Key2,
		input       Key3,
 		output      [2:0]N1, 
		output      [2:0]N2,	
		output      [2:0]N3,	
		output      [2:0]N4,	
		output      [2:0]N5,	
		output      [2:0]N6,	
		output      [2:0]N7,	
		output      [2:0]N8,	
		output      [2:0]N9,	
		output      [2:0]N10,	
		output      [3:0]Num,
		output      [7:0]Point,
		output      End
 );
 
 
reg [2:0]rN1;
reg [2:0]rN2;
reg [2:0]rN3;
reg [2:0]rN4;
reg [2:0]rN5;
reg [2:0]rN6;
reg [2:0]rN7;
reg [2:0]rN8;
reg [2:0]rN9;
reg [2:0]rN10;

reg [3:0]rNum;
reg [7:0]rPoint;

reg rEnd;
reg En;

reg [3:0]a1;
reg [3:0]a2;
reg [3:0]a3;
reg [3:0]a4;
reg [3:0]a5;
reg [3:0]a6;
reg [3:0]a7;
reg [3:0]a8;
reg [3:0]a9;
reg [3:0]a10;

 reg [2:0]i;
 reg [2:0]j;
 
 
  
always @ ( posedge CLK ) //检测时钟上升沿和复位下降沿
 begin
	if(RSTn==0) begin
			rEnd <= 'd0;
			rN1 <= 'd0;
			rN2 <= 'd0;
			rN3 <= 'd0;
			rN4 <= 'd0;
			rN5 <= 'd0;
			rN6 <= 'd0;
			rN7 <= 'd0;
			rN8 <= 'd0;
			rN9 <= 'd0;
			rN10 <= 'd0;
			rNum <= 'd1;
			rPoint <= 'd0;
			En <= 'd0;
			a1 <= 'd0;
			a2 <= 'd0;
			a3 <= 'd0;
			a4 <= 'd0;
			a5 <= 'd0;
			a6 <= 'd0;
			a7 <= 'd0;
			a8 <= 'd0;
			a9 <= 'd0;
			a10 <= 'd0;
	end
	else begin
	
			if(Key1&&(rEnd==0)) begin
					case(rNum)
							'd1:  begin if(rN1<4) rN1<=rN1+'d1; else rN1<='d1; end
							'd2:  begin if(rN2<4) rN2<=rN2+'d1; else rN2<='d1; end
							'd3:  begin if(rN3<4) rN3<=rN3+'d1; else rN3<='d1; end
							'd4:  begin if(rN4<4) rN4<=rN4+'d1; else rN4<='d1; end
							'd5:  begin if(rN5<4) rN5<=rN5+'d1; else rN5<='d1; end
							'd6:  begin if(rN6<4) rN6<=rN6+'d1; else rN6<='d1; end
							'd7:  begin if(rN7<4) rN7<=rN7+'d1; else rN7<='d1; end
							'd8:  begin if(rN8<4) rN8<=rN8+'d1; else rN8<='d1; end
							'd9:  begin if(rN9<4) rN9<=rN9+'d1; else rN9<='d1; end
							'd10:  begin if(rN10<4) rN10<=rN10+'d1; else rN10<='d1; end
					endcase
			end
			
			if(Key2&&(rEnd==0)) begin
					if(rNum<10) rNum<=rNum+'d1;
					else rNum<='d1;
			end
		
			if(Key3) begin
					rEnd <= 'd1;
					En <= 'd1;
					a1 <= 'd0;
					a2 <= 'd0;
					a3 <= 'd0;
					a4 <= 'd0;
					a5 <= 'd0;
					a6 <= 'd0;
					a7 <= 'd0;
					a8 <= 'd0;
					a9 <= 'd0;
					a10 <= 'd0;
			end
			
			if(En) begin
					En <= 'd0;
					if(rN1==2) a1<='d10;
					if(rN2==1) a2<='d10;
					if(rN3==4) a3<='d10;
					if(rN4==2) a4<='d10;
					if(rN5==1) a5<='d10;
					if(rN6==4) a6<='d10;
					if(rN7==4) a7<='d10;
					if(rN8==1) a8<='d10;
					if(rN9==1) a9<='d10;
					if(rN10==1) a10<='d10;
			end
			
			rPoint <= a1+a2+a3+a4+a5+a6+a7+a8+a9+a10;
		
		
	end
	
 end 
		
/****************************/          

assign N1 = rN1; 
assign N2 = rN2;
assign N3 = rN3;
assign N4 = rN4;
assign N5 = rN5;
assign N6 = rN6;
assign N7 = rN7;
assign N8 = rN8;
assign N9 = rN9;
assign N10 = rN10;
assign Num = rNum;
assign Point = rPoint;
assign End = rEnd;

/****************************/  


endmodule 