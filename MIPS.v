module MIPS (
    input   wire    rst1,
    input   wire    clk1,
    output  wire  [15:0]  test_value_c
);

wire    [31:0]  Instr_c;
wire    [31:0]  PC_c;
wire    [31:0]  ReadData_c;

inst_memory U0_inst_memory 
(
    .instr(Instr_c),
    .pc(PC_c)
);

wire            RegWrite_c;
wire            RegDst_c;
wire            ALUSrc_c;
wire            MemtoReg_c;
wire            PCSrc_c;
wire            Jump_c;
wire   [2:0]    ALU_Control_c;
wire  [31:0]    ALUOut_c;
wire  [31:0]    WriteData_c;
wire            zero_c;
wire            MemWrite_c;

data_path U0_data_path
(
    .CLK(clk1),
    .RST(rst1),
    .ReadData(ReadData_c),
    .Instr(Instr_c),
    .RegWrite(RegWrite_c),
    .RegDst(RegDst_c),
    .ALUSrc(ALUSrc_c),
    .MemtoReg(MemtoReg_c),
    .PCSrc(PCSrc_c),
    .Jump(Jump_c),
    .ALU_Control(ALU_Control_c),
    .ALUOut(ALUOut_c),
    .WriteData(WriteData_c),
    .PC(PC_c),
    .zero(zero_c)
);


data_memory U0_data_memory
(
    .clk(clk1),
    .rst(rst1),
    .A(ALUOut_c),
    .WD(WriteData_c),
    .WE(MemWrite_c),
    .RD(ReadData_c),
    .test_value(test_value_c)
);

control_unit U0_control_unit 
(
    .Opcode(Instr_c[31:26]),
    .Funct(Instr_c[5:0]),
    .zero(zero_c),
    .PCSrc(PCSrc_c),
    .MemtoReg(MemtoReg_c),
    .MemWrite(MemWrite_c),
    .ALUSrc(ALUSrc_c),
    .RegDst(RegDst_c),
    .RegWrite(RegWrite_c),
    .Jump(Jump_c),
    .ALU_Control(ALU_Control_c)
);


endmodule