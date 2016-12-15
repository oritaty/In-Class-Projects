module PS2(clk,rst,ps_clk,ps_data,dataout,led);
input clk,rst,ps_clk,ps_data;
output [7:0] dataout,led;

reg [7:0] dataout;
wire [7:0] dataout_temp;
reg [3:0] num;//PS_CLKʱ�Ӽ���
reg [10:0] data_buffer;//�������ݻ�����
reg [7:0] data_reg1,data_reg2,data_reg3,result;
reg isDone;
/*****************����ʶ��PS_CLK��ʱ��λ��*******************/
always @(posedge ps_clk)
 begin 
   if(num==4'd10)
       num<=4'd0; 
   else
     num<=num+4'd1;
 end
/***************��PS_CLK���½��ض�ȡ����**********************/
always @(negedge ps_clk)
   begin
     data_buffer[num]<=ps_data;//�½��ض�ȡ����
   end
/***************��ȡ����֡���ж��Ƿ񰴼��Ƿ�ſ�*************/
always @(posedge ps_clk or negedge rst)
  begin 
   if(!rst)
     result<=8'b0;
   else
    begin
    case (num)
      4'd9:data_reg1<=data_buffer[8:1];//��ȡ����
      4'd10:
			begin
			   if(data_reg1=='hf0) begin
					result<='hff;
			   end
			   else begin
					isDone <= 'd1;
					result <= data_reg1;
			   end
 
			end
      default:result<=8'b0;
    endcase
    
   end     
  end
assign dataout_temp=result;
assign led=~result;
/******************��ֵѰ��*****************************/
always @(posedge clk)
 begin
   case (dataout_temp)
     8'h1c:dataout<="A";//A
     8'h32:dataout<="B";//B
     8'h21:dataout<="C";//C
     8'h23:dataout<="D";//D
     8'h24:dataout<="E";//E
     8'h2b:dataout<="F";//F
     8'h34:dataout<="G";//G
     8'h33:dataout<="H";//H
     8'h43:dataout<="I";//I
     8'h3b:dataout<="J";//J
     8'h42:dataout<="K";//K
     8'h4b:dataout<="L";//L
     8'h3a:dataout<="M";//M
     8'h31:dataout<="N";//N
     8'h44:dataout<="O";//O
     8'h4d:dataout<="P";//P
     8'h15:dataout<="Q";//Q
     8'h2d:dataout<="R";//R
     8'h1b:dataout<="S";//S
     8'h2c:dataout<="T";//T
     8'h3c:dataout<="U";//U
     8'h2a:dataout<="V";//V
     8'h1d:dataout<="W";//W
     8'h22:dataout<="X";//X
     8'h35:dataout<="Y";//Y
     8'h1a:dataout<="Z";//Z
     
     8'h45:dataout<="0";//0
     8'h16:dataout<="1";//1
     8'h1e:dataout<="2";//2
     8'h26:dataout<="3";//3
     8'h25:dataout<="4";//4
     8'h2e:dataout<="5";//5
     8'h36:dataout<="6";//6
     8'h3d:dataout<="7";//7
     8'h3e:dataout<="8";//8
     8'h46:dataout<="9";//9
    default:dataout<=" ";//
   endcase 
 end 

endmodule