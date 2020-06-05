//VU XUAN SON 171298
//29/5/2020
//------------------------------------------------------------------------------------------------------
module Control_Unit(inst,br_ep,br_lt,
					pcmux_sel,imm_sel,regfilemux_sel,cmpop,alumux2_out,alumux1_out,aluop,dmem_sel,wbmux_sel);

input [31:0]inst;
input br_ep,br_lt;

reg [15:0]data; //cau truc: pcmux_sel_imm_sel_regfilemux_sel_cmpop_alumux2_out_alumux1_out_aluop_dmem_sel_wbmux_sel
				//----  	  [14]    [13:11]      [10]       [9]      [8]       [7]     [6:3]     [2]     [1:0]     -->tổng số bit = 15	
output reg pcmux_sel,regfilemux_sel,cmpop,alumux2_out,alumux1_out,dmem_sel;
output reg [2:0]imm_sel;
output reg [1:0]wbmux_sel;
output reg [3:0]aluop;

// inst[6:2]---------------------------------------------------------------------------------------------
localparam R =5'b01100;
localparam Ic=5'b00100;
localparam Il=5'b00000;
localparam S =5'b01000;
localparam B =5'b11000;
localparam J =5'b11011;

// inst[14:12]-------------------------------------------------------------------------------------------
//000
localparam add_sub=3'b000;
localparam addi=3'b000;
localparam beq=3'b000;
localparam jalr=3'b000;
//001
localparam sll=3'b001;
localparam slli=3'b001;
localparam bne=3'b001;
//010
localparam slt=3'b010;
localparam slti=3'b010;
localparam sw=3'b010;
//011
localparam sltu=3'b011;
localparam sltui=3'b011;
localparam lw=3'b011;
//100
localparam _xor =3'b100;
localparam xori=3'b100;
localparam blt=3'b100;
//101
localparam srl_sra=3'b101;
localparam srli_srai=3'b101;
localparam bge=3'b101;
//110
localparam _or=3'b110;
localparam ori=3'b110;
localparam bltu=3'b110;
//111
localparam _and=3'b111;
localparam andi=3'b111;
localparam bgeu=3'b111;
//--------------------------------------------------------------------------------------------
//chay
always @(*) begin
case(inst[6:2])
	R: begin
		case(inst[14:12])
		add_sub:
			begin
				if (inst[30]) data<=0_0_1_0_0_0_0000_0_01;
				else data<=0_0_1_0_0_0_0001_0_01;
			end
		sll:data<=0_0_1_0_0_0_0010_0_01;
		slt:data<=0_0_1_0_0_0_0011_0_01;
		sltu:data<=0_0_1_0_0_0_0100_0_01;
		_xor:data<=0_0_1_0_0_0_0101_0_01;
		srl_sra:
			begin
				if (inst[30]) data<=0_0_1_0_0_0_0111_0_01;
				else data<=0_0_1_0_0_0_0110_0_01;
			end
		_or:data<=0_0_1_0_0_0_1000_0_01;
		_and:data<=0_0_1_0_0_0_1001_0_01;
		endcase
    Ic: begin
		case(inst[14:12])
		addi:data<=0_000_1_0_1_0_0000_0_01;
		slti:data<=0_000_1_0_1_0_0011_0_01;
		sltui:data<=0_000_1_0_1_0_0100_0_01;
		xori:data<=0_000_1_0_1_0_0101_0_01;
		ori:data<=0_000_1_0_1_0_1000_0_01;
		andi:data<=0_000_1_0_1_0_1001_0_01;
		slli:data<=0_000_1_0_1_0_0010_0_01;
		srli_srai:
			begin
				if (inst[30]) data<=0_000_1_0_1_0_0111_0_01;
				else data<=0_000_1_0_1_0_0110_0_01;
			end
		endcase
		end
    Il:	begin
		case(inst[14:12])
		lw:data<=0_000_1_0_1_0_0000_0_00;
		endcase
		end
    S:	begin
		case(inst[14:12])
		sw:data<=0_001_0_0_1_0_0000_1_0;
		endcase
		end
	B: 	begin
			case(inst[14:12])
			beq: begin
				if(br_ep)  data<=1_010_0_0_1_1_0000_0_0;
				else  data<=0_010_0_0_1_1_0000_0_0;
				end
			bne: begin
				if(br_ep)  data<=0_010_0_0_1_1_0000_0_0;
				else  data<=1_010_0_0_1_1_0000_0_0;
				end
			blt: begin
				if(br_lt)  data<=1_010_0_0_1_1_0000_0_0;
				else  data<=0_010_0_0_1_1_0000_0_0;
				end
			bge: begin
				if(br_ep==1 || br_lt==0)  data<=1_010_0_0_1_1_0000_0_0;
				else  data<=0_010_0_0_1_1_0000_0_0;
				end
			bltu: begin
				if(br_lt==1) data<=1_010_0_1_1_1_0000_0_0;
				else data<= data<=0_010_0_1_1_1_0000_0_0;
				end
			bgeu: begin
				if(br_ep==1 || br_lt==0) data<=1_010_0_1_1_1_0000_0_0;
				else data<=0_010_0_1_1_1_0000_0_0;
				end
			endcase
		end
    J:	begin
		if (inst[14:12]=3'b000) data<=1_000_1_0_1_0_0000_0_10;
		else data<=1_100_1_0_1_1_0000_0_10;
		end
endcase

//đưa các tín hiệu đến các module
pcmux_sel<= data[14];
imm_sel <=data[13:11];
regfilemux_sel <=data[10];
cmpop <= data[9];
alumux2_out <= data[8];
alumux1_out <= data[7];
aluop <= data[6:3];
dmem_sel <= data[2];
wbmux_sel <= data[1:0];
end
endmodule
