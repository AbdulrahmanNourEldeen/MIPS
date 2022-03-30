module control_unit
(
input 	wire 	[5:0] 	Opcode,
input 	wire 	[5:0] 	Funct,
input	wire			zero,

output	wire			PCSrc,
output 	reg 			MemtoReg,
output 	reg 			MemWrite,
output 	reg 			ALUSrc,
output 	reg 			RegDst,
output 	reg 			RegWrite,
output 	reg 			Jump,
output 	reg 	[2:0] 	ALU_Control
);


reg [1:0] ALUOP;
reg Branch;

always @(*)
begin
	case(Opcode)
	 6'b10_0011:
		begin
			Jump		= 1'b0;
			ALUOP		= 2'b00;
			MemWrite	= 1'b0;
			RegWrite	= 1'b1;
			RegDst 		= 1'b0;
			ALUSrc 		= 1'b1;
			MemtoReg 	= 1'b1;
			Branch 		= 1'b0;
		end
	 6'b10_1011:
	 	begin
			Jump		= 1'b0;
			ALUOP		= 2'b00;
			MemWrite	= 1'b1;
			RegWrite	= 1'b0;
			RegDst 		= 1'b0;
			ALUSrc 		= 1'b1;
			MemtoReg 	= 1'b1;
			Branch 		= 1'b0;
		end
	 6'b00_0000:
	 	begin
			Jump		= 1'b0;
			ALUOP		= 2'b10;
			MemWrite	= 1'b0;
			RegWrite	= 1'b1;
			RegDst 		= 1'b1;
			ALUSrc 		= 1'b0;
			MemtoReg 	= 1'b0;
			Branch 		= 1'b0;
		end
	 6'b00_1000:
		begin
			Jump		= 1'b0;
			ALUOP		= 2'b00;
			MemWrite	= 1'b0;
			RegWrite	= 1'b1;
			RegDst 		= 1'b0;
			ALUSrc 		= 1'b1;
			MemtoReg 	= 1'b0;
			Branch 		= 1'b0;
		end
	 6'b00_0100:
		begin
			Jump		= 1'b0;
			ALUOP		= 2'b01;
			MemWrite	= 1'b0;
			RegWrite	= 1'b0;
			RegDst 		= 1'b0;
			ALUSrc 		= 1'b0;
			MemtoReg 	= 1'b0;
			Branch 		= 1'b1;
		end
	 6'b00_0010:
		begin
			Jump		= 1'b1;
			ALUOP		= 2'b00;
			MemWrite	= 1'b0;
			RegWrite	= 1'b0;
			RegDst 		= 1'b0;
			ALUSrc 		= 1'b0;
			MemtoReg 	= 1'b0;
			Branch 		= 1'b0;
		end
	 default:
	 		begin
			Jump		= 1'b0;
			ALUOP		= 2'b00;
			MemWrite	= 1'b0;
			RegWrite	= 1'b0;
			RegDst 		= 1'b0;
			ALUSrc 		= 1'b0;
			MemtoReg 	= 1'b0;
			Branch 		= 1'b0;
			end
			
	endcase
end


always @(*)	
begin

	case (ALUOP)
	
		2'b00:	begin
					ALU_Control = 3'b010;
				end
		2'b01:	begin
					ALU_Control = 3'b100;				
				end
		2'b10:	begin
					case (Funct)
						6'b10_0000 : ALU_Control = 3'b010;
						6'b10_0010 : ALU_Control = 3'b100;
						6'b10_1010 : ALU_Control = 3'b110;
						6'b01_1100 : ALU_Control = 3'b101;
					
						default	   : ALU_Control = 3'b000;
					endcase
				end

		default: ALU_Control = 3'b010;
	endcase
end

assign PCSrc = Branch & zero;

endmodule