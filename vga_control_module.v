module vga_control_module
(
  input CLK,
  input RSTn,
  input [2:0]N1,
  input [2:0]N2,
  input [2:0]N3,
  input [2:0]N4,
  input [2:0]N5,
  input [2:0]N6,
  input [2:0]N7,
  input [2:0]N8,
  input [2:0]N9,
  input [2:0]N10,
  input  [7:0]TuPianDat,
  input  [3:0]Num,
  input  [7:0]Point,
  input  End,
  output [7:0]R,
  output [7:0]G,
  output [7:0]B,
  output HSYNC,
  output VSYNC,
  output VGA_CLK,
  output VGA_BLANK_N,
  output VGA_SYNC_N,
  output [9:0]Addr

 );
 

 /*************VGA-REG*******************/
 reg [9:0]a;
 reg [9:0]b;
 reg [9:0]c;
 reg [9:0]d;
 reg [9:0]o;
 reg [9:0]p;
 reg [9:0]q;
 reg [9:0]r;
 /**************************************/

 reg [7:0]rR;
 reg [7:0]rG;
 reg [7:0]rB;
 reg [11:0]C1;
 reg [11:0]C2;
 reg rH,rV;
 reg [11:0]xpos;
 reg [11:0]ypos;
 
 reg [9:0]rAddr;
 
 reg [15:0]dispNumA0;
 reg [15:0]dispNumA1;
 reg [15:0]dispNumA2;
 reg [15:0]dispNumA3;
 reg [15:0]dispNumA4;
 reg [15:0]dispNumA5;
 reg [15:0]dispNumA6;
 reg [15:0]dispNumA7;
 
 reg [15:0]dispNumB0;
 reg [15:0]dispNumB1;
 reg [15:0]dispNumB2;
 reg [15:0]dispNumB3;
 reg [15:0]dispNumB4;
 reg [15:0]dispNumB5;
 reg [15:0]dispNumB6;
 reg [15:0]dispNumB7;
 
 
  reg rVGA_BLANK_N;
   reg rVGA_SYNC_N;
	
   reg CLK_25M;
	
	reg [7:0]DataShuJu;
	
 always @ ( posedge CLK )
 begin
	CLK_25M <= ~CLK_25M;
end 
 
 /******************************************************/ 
 always @ ( posedge CLK_25M or negedge RSTn )
 if( !RSTn ) begin
			rR <= 'd0;
			rG <= 'd0;
			rB <= 'd0;
	C1 <= 'd0;
	C2 <= 'd0;
	rH <= 1'b1;
	rV <= 1'b1;
	
/*****800X600*******/
/*	a <= 'd128; 
	b <= 'd88; 
	c <= 'd800; 
	d <= 'd40; 
	o <= 'd4; 
	p <= 'd23; 
	q <= 'd600; 
	r <= 'd1; */
/*******************/	

/*****640X480*******/
	a <= 'd96; 
	b <= 'd48; 
	c <= 'd640; 
	d <= 'd16; 
	o <= 'd2; 
	p <= 'd33; 
	q <= 'd480; 
	r <= 'd10; 
/*******************/
	
 end
 else begin																				

	/******************************************************/ 
if( ((C1 > (a + b)) && (C1 <= (a + b + c)) ) && ( (C2 > (o + p)) && (C2 <= (o + p + q) )) ) begin	

					/*********************************************************************no1*********************************************************************************/	
							if((xpos>=2)&&(xpos<=2+7)&&(ypos>=2)&&(ypos<=2+15)) begin
									rAddr =(ypos-2)+ (1*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==16)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=2)&&(ypos<=2+15)) begin    //1
									rAddr =(ypos-2)+ (1*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //2
									rAddr =(ypos-2)+ (2*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //+
									DataShuJu = FunctionJia(ypos-2);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=2)&&(ypos<=2+15)) begin    //3
									rAddr =(ypos-2)+ (3*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //8
									rAddr =(ypos-2)+ (8*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-2);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //A
									rAddr =(ypos-2)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N1==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N1==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==16)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //2
									rAddr =(ypos-2)+ (2*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //2
									rAddr =(ypos-2)+ (2*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //B
									rAddr =(ypos-2)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N1==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N1==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==16)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //5
									rAddr =(ypos-2)+ (5*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //0
									rAddr =(ypos-2)+ (0*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //C
									rAddr =(ypos-2)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N1==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N1==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==16)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //1
									rAddr =(ypos-2)+ (1*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //9
									rAddr =(ypos-2)+ (9*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //D
									rAddr =(ypos-2)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N1==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N1==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==16)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //7
									rAddr =(ypos-2)+ (7*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=2)&&(ypos<=2+15)) begin  //5
									rAddr =(ypos-2)+ (5*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
					/*********************************************************************no1*********************************************************************************/
						
					/*********************************************************************no2*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=18)&&(ypos<=18+15)) begin
									rAddr =(ypos-18)+ (2*16);
									if(TuPianDat[(xpos-34)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==32)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=18)&&(ypos<=18+15)) begin    //5
									rAddr =(ypos-18)+ (5*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //6
									rAddr =(ypos-18)+ (6*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //+
									DataShuJu = FunctionJia(ypos-18);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=18)&&(ypos<=18+15)) begin    //3
									rAddr =(ypos-18)+ (1*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //8
									rAddr =(ypos-18)+ (9*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-18);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //A
									rAddr =(ypos-18)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N2==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N2==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==30)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //7
									rAddr =(ypos-18)+ (7*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //5
									rAddr =(ypos-18)+ (5*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //B
									rAddr =(ypos-18)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N2==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N2==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==32)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //2
									rAddr =(ypos-18)+ (2*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //3
									rAddr =(ypos-18)+ (3*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //C
									rAddr =(ypos-18)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N2==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N2==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==32)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //5
									rAddr =(ypos-18)+ (5*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //5
									rAddr =(ypos-18)+ (5*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //D
									rAddr =(ypos-18)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N2==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N2==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==32)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //9
									rAddr =(ypos-18)+ (9*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=18)&&(ypos<=18+15)) begin  //6
									rAddr =(ypos-18)+ (6*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no2*********************************************************************************/ 		
					/*********************************************************************no3*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=34)&&(ypos<=34+15)) begin
									rAddr =(ypos-34)+ (3*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==48)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=34)&&(ypos<=34+15)) begin    //9
									rAddr =(ypos-34)+ (9*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //9
									rAddr =(ypos-34)+ (9*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //-
									DataShuJu = FunctionJian(ypos-34);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=34)&&(ypos<=34+15)) begin    //6
									rAddr =(ypos-34)+ (6*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //9
									rAddr =(ypos-34)+ (9*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-34);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //A
									rAddr =(ypos-34)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N3==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N3==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==48)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //7
									rAddr =(ypos-34)+ (7*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //3
									rAddr =(ypos-34)+ (3*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //B
									rAddr =(ypos-34)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N3==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N3==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==48)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //5
									rAddr =(ypos-34)+ (5*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //7
									rAddr =(ypos-34)+ (7*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //C
									rAddr =(ypos-34)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N3==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N3==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==48)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //9
									rAddr =(ypos-34)+ (9*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //1
									rAddr =(ypos-34)+ (1*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //D
									rAddr =(ypos-34)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N3==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N3==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==48)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //3
									rAddr =(ypos-34)+ (3*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=34)&&(ypos<=34+15)) begin  //0
									rAddr =(ypos-34)+ (0*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no3*********************************************************************************/ 

					/*********************************************************************no4*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=50)&&(ypos<=50+15)) begin
									rAddr =(ypos-50)+ (4*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==64)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=50)&&(ypos<=50+15)) begin    //4
									rAddr =(ypos-50)+ (4*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //0
									rAddr =(ypos-50)+ (0*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //-
									DataShuJu = FunctionJian(ypos-50);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=50)&&(ypos<=50+15)) begin    //2
									rAddr =(ypos-50)+ (2*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //1
									rAddr =(ypos-50)+ (1*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-50);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //A
									rAddr =(ypos-50)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N4==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N4==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==64)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //1
									rAddr =(ypos-50)+ (1*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //8
									rAddr =(ypos-50)+ (8*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //B
									rAddr =(ypos-50)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N4==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N4==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==64)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //1
									rAddr =(ypos-50)+ (1*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //9
									rAddr =(ypos-50)+ (9*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //C
									rAddr =(ypos-50)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N4==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N4==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==64)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //2
									rAddr =(ypos-50)+ (2*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //0
									rAddr =(ypos-50)+ (0*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //D
									rAddr =(ypos-50)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N4==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N4==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==64)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //2
									rAddr =(ypos-50)+ (2*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=50)&&(ypos<=50+15)) begin  //1
									rAddr =(ypos-50)+ (1*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no4*********************************************************************************/ 

					 
					/*********************************************************************no5*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=66)&&(ypos<=66+15)) begin
									rAddr =(ypos-66)+ (5*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==80)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=66)&&(ypos<=66+15)) begin    //0
									rAddr =(ypos-66)+ (0*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //8
									rAddr =(ypos-66)+ (8*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //*
									DataShuJu = FunctionCheng(ypos-66);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=66)&&(ypos<=66+15)) begin    //0
									rAddr =(ypos-66)+ (0*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //8
									rAddr =(ypos-66)+ (8*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-66);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //A
									rAddr =(ypos-66)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N5==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N5==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==80)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //6
									rAddr =(ypos-66)+ (6*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //4
									rAddr =(ypos-66)+ (4*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //B
									rAddr =(ypos-66)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N5==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N5==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==80)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //6
									rAddr =(ypos-66)+ (6*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //8
									rAddr =(ypos-66)+ (8*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //C
									rAddr =(ypos-66)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N5==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N5==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==80)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //7
									rAddr =(ypos-66)+ (7*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //2
									rAddr =(ypos-66)+ (2*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //D
									rAddr =(ypos-66)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N5==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N5==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==80)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //5
									rAddr =(ypos-66)+ (5*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=66)&&(ypos<=66+15)) begin  //7
									rAddr =(ypos-66)+ (7*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no5*********************************************************************************/					 

					/*********************************************************************no6*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=82)&&(ypos<=82+15)) begin
									rAddr =(ypos-82)+ (6*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==96)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=82)&&(ypos<=82+15)) begin    //0
									rAddr =(ypos-82)+ (0*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //4
									rAddr =(ypos-82)+ (4*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //*
									DataShuJu = FunctionCheng(ypos-82);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=82)&&(ypos<=82+15)) begin    //0
									rAddr =(ypos-82)+ (0*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //8
									rAddr =(ypos-82)+ (8*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-82);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //A
									rAddr =(ypos-82)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N6==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N6==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==96)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //2
									rAddr =(ypos-82)+ (2*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //3
									rAddr =(ypos-82)+ (3*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //B
									rAddr =(ypos-82)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N6==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N6==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==96)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //8
									rAddr =(ypos-82)+ (8*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //2
									rAddr =(ypos-82)+ (2*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //C
									rAddr =(ypos-82)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N6==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N6==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==96)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //3
									rAddr =(ypos-82)+ (3*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //3
									rAddr =(ypos-82)+ (3*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //D
									rAddr =(ypos-82)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N6==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N6 ==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==96)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //3
									rAddr =(ypos-82)+ (3*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=82)&&(ypos<=82+15)) begin  //2
									rAddr =(ypos-82)+ (2*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no6*********************************************************************************/		

					/*********************************************************************no7*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=98)&&(ypos<=98+15)) begin
									rAddr =(ypos-98)+ (7*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==112)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=98)&&(ypos<=98+15)) begin    //1
									rAddr =(ypos-98)+ (1*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //2
									rAddr =(ypos-98)+ (2*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //*
									DataShuJu = FunctionCheng(ypos-98);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=98)&&(ypos<=98+15)) begin    //0
									rAddr =(ypos-98)+ (0*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //6
									rAddr =(ypos-98)+ (6*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-98);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //A
									rAddr =(ypos-98)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N7==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N7==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==112)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //7
									rAddr =(ypos-98)+ (7*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //0
									rAddr =(ypos-98)+ (0*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //B
									rAddr =(ypos-98)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N7==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N7==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==112)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //8
									rAddr =(ypos-98)+ (8*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //1
									rAddr =(ypos-98)+ (1*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //C
									rAddr =(ypos-98)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N7==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N7==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==112)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //8
									rAddr =(ypos-98)+ (8*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //2
									rAddr =(ypos-98)+ (2*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //D
									rAddr =(ypos-98)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N7==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N7 ==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==112)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //7
									rAddr =(ypos-98)+ (7*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=98)&&(ypos<=98+15)) begin  //2
									rAddr =(ypos-98)+ (2*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no7*********************************************************************************/	

					/*********************************************************************no8*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=114)&&(ypos<=114+15)) begin
									rAddr =(ypos-114)+ (8*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==128)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=114)&&(ypos<=114+15)) begin    //9
									rAddr =(ypos-114)+ (9*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //0
									rAddr =(ypos-114)+ (0*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=114)&&(ypos<=114+15)) begin  // /
									DataShuJu = FunctionChu(ypos-114);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=114)&&(ypos<=114+15)) begin    //1
									rAddr =(ypos-114)+ (1*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //5
									rAddr =(ypos-114)+ (5*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-114);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //A
									rAddr =(ypos-114)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N8==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N8==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==128)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //0
									rAddr =(ypos-114)+ (0*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //6
									rAddr =(ypos-114)+ (6*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //B
									rAddr =(ypos-114)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N8==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N8==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==128)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //0
									rAddr =(ypos-114)+ (0*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //8
									rAddr =(ypos-114)+ (8*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //C
									rAddr =(ypos-114)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N8==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N8==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==128)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //1
									rAddr =(ypos-114)+ (1*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //4
									rAddr =(ypos-114)+ (4*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //D
									rAddr =(ypos-114)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N8==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N8 ==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==128)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //1
									rAddr =(ypos-114)+ (1*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=114)&&(ypos<=114+15)) begin  //2
									rAddr =(ypos-114)+ (2*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no8*********************************************************************************/
					
					/*********************************************************************no9*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=130)&&(ypos<=130+15)) begin
									rAddr =(ypos-130)+ (9*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==11)&&(ypos==144)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end				
							else	if((xpos>=20)&&(xpos<=20+7)&&(ypos>=130)&&(ypos<=130+15)) begin    //8
									rAddr =(ypos-130)+ (8*16);
									if(TuPianDat[(xpos-20)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=27)&&(xpos<=28+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //0
									rAddr =(ypos-130)+ (0*16);
									if(TuPianDat[(xpos-28)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=44)&&(xpos<=44+7)&&(ypos>=130)&&(ypos<=130+15)) begin  // /
									DataShuJu = FunctionChu(ypos-130);
									if(DataShuJu[(xpos-44)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else	if((xpos>=60)&&(xpos<=60+7)&&(ypos>=130)&&(ypos<=130+15)) begin    //0
									rAddr =(ypos-130)+ (0*16);
									if(TuPianDat[(xpos-60)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=67)&&(xpos<=68+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //4
									rAddr =(ypos-130)+ (4*16);
									if(TuPianDat[(xpos-68)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							else if((xpos>=84)&&(xpos<=84+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //=
									DataShuJu = FunctionDeng(ypos-130);
									if(DataShuJu[(xpos-84)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //A
									rAddr =(ypos-130)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N9==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N9==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==144)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //2
									rAddr =(ypos-130)+ (2*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=180)&&(xpos<=180+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //0
									rAddr =(ypos-130)+ (0*16);
									if(TuPianDat[(xpos-180)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //B
									rAddr =(ypos-130)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N9==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N9==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==144)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //1
									rAddr =(ypos-130)+ (1*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=220)&&(xpos<=220+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //2
									rAddr =(ypos-130)+ (2*16);
									if(TuPianDat[(xpos-220)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //C
									rAddr =(ypos-130)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N9==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N9==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==144)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //1
									rAddr =(ypos-130)+ (1*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=260)&&(xpos<=260+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //3
									rAddr =(ypos-130)+ (3*16);
									if(TuPianDat[(xpos-260)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //D
									rAddr =(ypos-130)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N9==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N9 ==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==144)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //1
									rAddr =(ypos-130)+ (1*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=130)&&(ypos<=130+15)) begin  //4
									rAddr =(ypos-130)+ (4*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end		
							
					 /*********************************************************************no9*********************************************************************************/	
					 
					/*********************************************************************no10*********************************************************************************/	
							else if((xpos>=2)&&(xpos<=2+7)&&(ypos>=146)&&(ypos<=146+15)) begin
									rAddr =(ypos-146)+ (1*16);
									if(TuPianDat[(xpos-2)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=10)&&(xpos<=10+7)&&(ypos>=146)&&(ypos<=146+15)) begin
									rAddr =(ypos-146)+ (0*16);
									if(TuPianDat[(xpos-10)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end							
							else if((xpos==19)&&(ypos==160)) begin //.
										rR<='d255; rG<='d0; rB<='d255;
							end
				
							else if((xpos>=25)&&(xpos<=25+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //f
									rAddr =(ypos-146)+ (15*16);
									if(TuPianDat[(xpos-25)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=33)&&(xpos<=33+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //i
									rAddr =(ypos-146)+ (18*16);
									if(TuPianDat[(xpos-33)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=41)&&(xpos<=41+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //r
									rAddr =(ypos-146)+ (27*16);
									if(TuPianDat[(xpos-41)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=49)&&(xpos<=49+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //s
									rAddr =(ypos-146)+ (33*16);
									if(TuPianDat[(xpos-49)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=57)&&(xpos<=57+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //t
									rAddr =(ypos-146)+ (29*16);
									if(TuPianDat[(xpos-57)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
	
							else if((xpos>=73)&&(xpos<=73+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //L
									rAddr =(ypos-146)+ (21*16);
									if(TuPianDat[(xpos-73)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=81)&&(xpos<=81+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //e
									rAddr =(ypos-146)+ (14*16);
									if(TuPianDat[(xpos-81)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end	
							else if((xpos>=89)&&(xpos<=89+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //t
									rAddr =(ypos-146)+ (29*16);
									if(TuPianDat[(xpos-89)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=97)&&(xpos<=97+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //t
									rAddr =(ypos-146)+ (29*16);
									if(TuPianDat[(xpos-97)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=105)&&(xpos<=105+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //e
									rAddr =(ypos-146)+ (14*16);
									if(TuPianDat[(xpos-105)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=113)&&(xpos<=113+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //r
									rAddr =(ypos-146)+ (27*16);
									if(TuPianDat[(xpos-113)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=129)&&(xpos<=129+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //i
									rAddr =(ypos-146)+ (18*16);
									if(TuPianDat[(xpos-129)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=137)&&(xpos<=137+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //s
									rAddr =(ypos-146)+ (28*16);
									if(TuPianDat[(xpos-137)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							
						
							else if((xpos>=160)&&(xpos<=160+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //A
									rAddr =(ypos-146)+ (10*16);
									if(TuPianDat[(xpos-160)]) begin
										if(N10==1) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N10==1) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==168)&&(ypos==160)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=172)&&(xpos<=172+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //a
									rAddr =(ypos-146)+ (10*16);
									if(TuPianDat[(xpos-172)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=200)&&(xpos<=200+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //B
									rAddr =(ypos-146)+ (11*16);
									if(TuPianDat[(xpos-200)]) begin
										if(N10==2) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N10==2) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==208)&&(ypos==160)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=212)&&(xpos<=212+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //b
									rAddr =(ypos-146)+ (11*16);
									if(TuPianDat[(xpos-212)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
							else if((xpos>=240)&&(xpos<=240+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //C
									rAddr =(ypos-146)+ (12*16);
									if(TuPianDat[(xpos-240)]) begin
										if(N10==3) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N10==3) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==248)&&(ypos==160)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=252)&&(xpos<=252+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //c
									rAddr =(ypos-146)+ (12*16);
									if(TuPianDat[(xpos-252)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							
							else if((xpos>=280)&&(xpos<=280+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //D
									rAddr =(ypos-146)+ (13*16);
									if(TuPianDat[(xpos-280)]) begin
										if(N10==4) begin rR<='d0; rG<='d0; rB<='d0; end
										else begin rR<='d255; rG<='d0; rB<='d255; end
									end 
									else begin
										if(N10 ==4) begin rR<='d255; rG<='d0; rB<='d255; end
										else begin rR<='d0; rG<='d0; rB<='d0; end	
									end
							end		
							else if((xpos==288)&&(ypos==160)) begin 		//.
										rR<='d255; rG<='d0; rB<='d255;
							end	
							else if((xpos>=292)&&(xpos<=292+7)&&(ypos>=146)&&(ypos<=146+15)) begin  //d
									rAddr =(ypos-146)+ (13*16);
									if(TuPianDat[(xpos-292)]) begin
										rR<='d255; rG<='d0; rB<='d255;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
						
					
							else if((xpos>=300)&&(xpos<=300+7)&&(ypos>=200)&&(ypos<=200+15)) begin  //Num
									rAddr =(ypos-200)+ (Num*16);
									if(TuPianDat[(xpos-300)]) begin
										rR<='d255; rG<='d0; rB<='d0;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
		
							else if((xpos>=50)&&(xpos<=50+7)&&(ypos>=200)&&(ypos<=200+15)&&(End==1)) begin  //point
									rAddr =(ypos-200)+ ((Point/100)*16);
									if(TuPianDat[(xpos-50)]) begin
										rR<='d0; rG<='d255; rB<='d0;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=58)&&(xpos<=58+7)&&(ypos>=200)&&(ypos<=200+15)&&(End==1)) begin  //point
									rAddr =(ypos-200)+ ((Point/10%10)*16);
									if(TuPianDat[(xpos-58)]) begin
										rR<='d0; rG<='d255; rB<='d0;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end
							else if((xpos>=66)&&(xpos<=66+7)&&(ypos>=200)&&(ypos<=200+15)&&(End==1)) begin  //point
									rAddr =(ypos-200)+ ((Point%10)*16);
									if(TuPianDat[(xpos-66)]) begin
										rR<='d0; rG<='d255; rB<='d0;
									end 
									else begin
										rR<='d0; rG<='d0; rB<='d0;
									end		
							end				
							
					 /*********************************************************************no10*********************************************************************************/	
					 
							/**********/
							else begin
									rR<='d0; rG<='d0; rB<='d0;	
							end	
							 		
			
end
else begin 
		rR<='d0; rG<='d0; rB<='d0;
end
	
	xpos <= (C1 - 'd144)/2;
	ypos <= (C2 - 'd35)/2;
	
	/******************************************************/ 	
	if( C1 == (a+b+c+d) ) rH <= 1'b0;
	else if( C1 == a ) rH <= 1'b1;

	if( C2 == (o+p+q+r) ) rV <= 1'b0;
	else if( C2 == o ) rV <= 1'b1;

	if( C2 == (o+p+q+r) ) C2 <= 10'd1;
	else if( C1 == (a+b+c+d) ) C2 <= C2 + 1'b1;

	if( C1 == (a+b+c+d) ) C1 <= 11'd1;
	else 
	C1 <= C1 + 1'b1;
	/******************************************************/	
 end
 

 /***********************************/  //+  
    function [7:0]FunctionJia;
	 input [3:0]CntValue;
		case (CntValue)
				 'd0 : FunctionJia = 8'h00; 
				 'd1 : FunctionJia = 8'h00; 
				 'd2 : FunctionJia = 8'h00; 
				 'd3 : FunctionJia = 8'h00; 
				 'd4 : FunctionJia = 8'h08; 
				 'd5 : FunctionJia = 8'h08; 
				 'd6 : FunctionJia = 8'h08; 
				 'd7 : FunctionJia = 8'h08; 
				 'd8 : FunctionJia = 8'h7F; 
				 'd9 : FunctionJia = 8'h08; 
				'd10 : FunctionJia = 8'h08; 
				'd11 : FunctionJia = 8'h08; 
				'd12 : FunctionJia = 8'h08; 
				'd13 : FunctionJia = 8'h00; 
				'd14 : FunctionJia = 8'h00; 
				'd15 : FunctionJia = 8'h00;
		endcase 
   endfunction   
 /***********************************/ 
 
  /***********************************/  //- 
    function [7:0]FunctionJian;
	input [3:0]CntValue;
		case (CntValue)
				 'd0 : FunctionJian = 8'h00; 
				 'd1 : FunctionJian = 8'h00; 
				 'd2 : FunctionJian = 8'h00; 
				 'd3 : FunctionJian = 8'h00; 
				 'd4 : FunctionJian = 8'h00; 
				 'd5 : FunctionJian = 8'h00; 
				 'd6 : FunctionJian = 8'h00; 
				 'd7 : FunctionJian = 8'h00; 
				 'd8 : FunctionJian = 8'hFE; 
				 'd9 : FunctionJian = 8'h00; 
				'd10 : FunctionJian = 8'h00; 
				'd11 : FunctionJian = 8'h00; 
				'd12 : FunctionJian = 8'h00; 
				'd13 : FunctionJian = 8'h00; 
				'd14 : FunctionJian = 8'h00; 
				'd15 : FunctionJian = 8'h00;
		endcase 
   endfunction   
 /***********************************/ 
 
 
   /***********************************/  //*
    function [7:0]FunctionCheng;
	input [3:0]CntValue;
		case (CntValue)
				 'd0 : FunctionCheng = 8'h00; 
				 'd1 : FunctionCheng = 8'h00; 
				 'd2 : FunctionCheng = 8'h00; 
				 'd3 : FunctionCheng = 8'h00; 
				 'd4 : FunctionCheng = 8'h08; 
				 'd5 : FunctionCheng = 8'h08; 
				 'd6 : FunctionCheng = 8'h6B; 
				 'd7 : FunctionCheng = 8'h1C; 
				 'd8 : FunctionCheng = 8'h1C; 
				 'd9 : FunctionCheng = 8'h6B; 
				'd10 : FunctionCheng = 8'h08; 
				'd11 : FunctionCheng = 8'h08; 
				'd12 : FunctionCheng = 8'h00; 
				'd13 : FunctionCheng = 8'h00; 
				'd14 : FunctionCheng = 8'h00; 
				'd15 : FunctionCheng = 8'h00;
		endcase 
   endfunction   
 /***********************************/ 
 
    /***********************************/  // /
    function [7:0]FunctionChu;
	input [3:0]CntValue;
		case (CntValue)
				 'd0 : FunctionChu = 8'h00; 
				 'd1 : FunctionChu = 8'h00; 
				 'd2 : FunctionChu = 8'h80; 
				 'd3 : FunctionChu = 8'h40; 
				 'd4 : FunctionChu = 8'h40; 
				 'd5 : FunctionChu = 8'h20; 
				 'd6 : FunctionChu = 8'h20; 
				 'd7 : FunctionChu = 8'h10; 
				 'd8 : FunctionChu = 8'h10; 
				 'd9 : FunctionChu = 8'h08; 
				'd10 : FunctionChu = 8'h08; 
				'd11 : FunctionChu = 8'h04; 
				'd12 : FunctionChu = 8'h04; 
				'd13 : FunctionChu = 8'h02; 
				'd14 : FunctionChu = 8'h02; 
				'd15 : FunctionChu = 8'h00;
		endcase 
   endfunction   
 /***********************************/ 
 
    /***********************************/  // =
    function [7:0]FunctionDeng;
	 input [3:0]CntValue;
		case (CntValue)
				 'd0 : FunctionDeng = 8'h00; 
				 'd1 : FunctionDeng = 8'h00; 
				 'd2 : FunctionDeng = 8'h00; 
				 'd3 : FunctionDeng = 8'h00; 
				 'd4 : FunctionDeng = 8'h00; 
				 'd5 : FunctionDeng = 8'h00; 
				 'd6 : FunctionDeng = 8'h7F; 
				 'd7 : FunctionDeng = 8'h00; 
				 'd8 : FunctionDeng = 8'h00; 
				 'd9 : FunctionDeng = 8'h00; 
				'd10 : FunctionDeng = 8'h7F; 
				'd11 : FunctionDeng = 8'h00; 
				'd12 : FunctionDeng = 8'h00;   
				'd13 : FunctionDeng = 8'h00; 
				'd14 : FunctionDeng = 8'h00; 
				'd15 : FunctionDeng = 8'h00;
		endcase 
   endfunction   
 /***********************************/ 
 

 /****************************/

 assign R = rR;
 assign G = rG;
 assign B = rB;
 assign HSYNC = rH;
 assign VSYNC = rV;
 assign VGA_CLK = CLK_25M;
 assign VGA_BLANK_N = rH && rV;
 assign VGA_SYNC_N = 'd0;
 assign Addr = rAddr; 
 

 /*****************************/
 endmodule