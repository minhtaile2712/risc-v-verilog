//VU XUAN SON 171298
//29/5/2020
//------------------------------------------------------------------------------------------------------
module ControlUnit(inst,br_eq,br_lt,pcmux_sel,imm_sel,regfilemux_sel,cmpop,alumux2_sel,alumux1_sel,aluop,dmem_sel,wbmux_sel);

input [31:0]inst;
input br_eq,br_lt;

reg [14:0]data; //cau truc: pcmux_sel_imm_sel_regfilemux_sel_cmpop_alumux2_sel_alumux1_sel_aluop_dmem_sel_wbmux_sel
				//----  	  [14]    [13:11]      [10]       [9]      [8]       [7]     [6:3]     [2]     [1:0]     -->tổng số bit = 15	
output reg pcmux_sel,regfilemux_sel,cmpop,alumux2_sel,alumux1_sel,dmem_sel;
output reg [2:0]imm_sel;
output reg [1:0]wbmux_sel;
output reg [3:0]aluop;
//-----------------------------------------------------------------------------------------------------
// inst[6:2]
localparam R =5'b01100;
localparam Ic=5'b00100;
localparam Il=5'b00000;
localparam S =5'b01000;
localparam B =5'b11000;
localparam J =5'b11011;

// inst[14:12]
//000
localparam _add_sub=3'b000;
localparam _addi=3'b000;
localparam _beq=3'b000;
localparam _jalr=3'b000;
//001
localparam _sll=3'b001;
localparam _slli=3'b001;
localparam _bne=3'b001;
//010      
localparam _slt=3'b010;
localparam _slti=3'b010;
localparam _sw=3'b010;
//011      
localparam _sltu=3'b011;
localparam _sltui=3'b011;
localparam _lw=3'b011;
//100      
localparam _xor =3'b100;
localparam _xori=3'b100;
localparam _blt=3'b100;
//101      
localparam _srl_sra=3'b101;
localparam _srli_srai=3'b101;
localparam _bge=3'b101;
//110      
localparam _or=3'b110;
localparam _ori=3'b110;
localparam _bltu=3'b110;
//111      
localparam _and=3'b111;
localparam _andi=3'b111;
localparam _bgeu=3'b111;
//---------------------------------------------------------------------------------------------------
//chay
always @ (*) begin
case(inst[6:2])
	R: begin
		case(inst[14:12])
		_add_sub:
			begin
				if (inst[30]) data <= 15'b 0_000_1_0_0_0_0001_0_01;
				else data <= 15'b 0_000_1_0_0_0_0000_0_01;
			end
		_sll:  data <= 15'b 0_000_1_0_0_0_0010_0_01;
		_slt:  data <= 15'b 0_000_1_0_0_0_0011_0_01;
		_sltu: data <= 15'b 0_000_1_0_0_0_0100_0_01;
		_xor:  data <= 15'b 0_000_1_0_0_0_0101_0_01;
		_srl_sra:
			begin
				if (inst[30]) data <= 15'b 0_000_1_0_0_0_0111_0_01;
				else data <= 15'b 0_000_1_0_0_0_0110_0_01;
			end
		_or:data <= 15'b 0_000_1_0_0_0_1000_0_01;
		_and:data <= 15'b 0_000_1_0_0_0_1001_0_01;
		endcase
		end
    Ic: begin
			case(inst[14:12])
			_addi:data <= 15'b 0_000_1_0_1_0_0000_0_01;
			_slti:data <= 15'b 0_000_1_0_1_0_0011_0_01;
			_sltui:data <= 15'b 0_000_1_0_1_0_0100_0_01;
			_xori:data <= 15'b 0_000_1_0_1_0_0101_0_01;
			_ori:data <= 15'b 0_000_1_0_1_0_1000_0_01;
			_andi:data <= 15'b 0_000_1_0_1_0_1001_0_01;
			_slli:data <= 15'b 0_000_1_0_1_0_0010_0_01;
			_srli_srai:
				begin
					if (inst[30]) data <= 15'b 0_000_1_0_1_0_0111_0_01;
					else data <= 15'b 0_000_1_0_1_0_0110_0_01;
				end
			endcase
		end
    Il:	begin
			case(inst[14:12])
			_lw: data <= 15'b 0_001_0_0_1_0_0000_1_00;
			endcase
		end
    S:	begin
			case(inst[14:12])
			_sw: data <= 15'b 0_000_1_0_1_0_0000_0_00;
			endcase
		end
	B: 	begin
			case(inst[14:12])
			_beq:begin
					if(br_eq)  data <= 15'b 1_010_0_0_1_1_0000_0_00;
					else  data <= 15'b 0_010_0_0_1_1_0000_0_00;
				end
			_bne:begin
					if(br_eq)  data <= 15'b 0_010_0_0_1_1_0000_0_00;
					else  data <= 15'b 1_010_0_0_1_1_0000_0_00;
				end
			_blt:begin
					if(br_lt)  data <= 15'b 1_010_0_0_1_1_0000_0_00;
					else  data <= 15'b 0_010_0_0_1_1_0000_0_00;
				end
			_bge:begin
					if(br_eq==1 || br_lt==0)  data <= 15'b 1_010_0_0_1_1_0000_0_00;
					else  data <= 15'b 0_010_0_0_1_1_0000_0_00;
				end
			_bltu:begin
					if(br_lt==1) data <= 15'b 1_010_0_1_1_1_0000_0_00;
					else data <= 15'b 0_010_0_1_1_1_0000_0_00;
				end
			_bgeu:begin
					if(br_eq==1 || br_lt==0) data <= 15'b 1_010_0_1_1_1_0000_0_00;
					else data <= 15'b 0_010_0_1_1_1_0000_0_00;
				end
			endcase
		end
    J:	begin
			if (inst[14:12]==3'b000) data <= 15'b 1_000_1_0_1_0_0000_0_10;
			else data <= 15'b 1_100_1_0_1_1_0000_0_10;
		end
endcase

//đưa các tín hiệu đến các module
pcmux_sel<= data[14];
imm_sel <=data[13:11];
regfilemux_sel <=data[10];
cmpop <= data[9];
alumux2_sel <= data[8];
alumux1_sel <= data[7];
aluop <= data[6:3];
dmem_sel <= data[2];
wbmux_sel <= data[1:0];
end
endmodule
