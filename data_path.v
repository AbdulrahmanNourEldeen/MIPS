module data_path (
    input   wire            CLK,
    input   wire            RST,
    input   wire  [31:0]    ReadData,
    input   wire  [31:0]    Instr,
    input   wire            RegWrite,
    input   wire            RegDst,
    input   wire            ALUSrc,
    input   wire            MemtoReg,
    input   wire            PCSrc,
    input   wire            Jump,
    input   wire   [2:0]    ALU_Control,

    output  wire  [31:0]    ALUOut,
    output  wire  [31:0]    WriteData,
    output  wire  [31:0]    PC,
    output  wire            zero
);
    
wire    [4:0]   WriteReg;

Mux #(.width(5)) U0_Mux_3 (
    .In1(Instr[20:16]),
    .In2(Instr[15:11]),
    .out(WriteReg),
    .sel(RegDst)
); 
wire    [31:0]  WD3_c;
wire    [31:0]  ALUOut_c;

Mux #(.width(32)) U0_Mux_2 (
    .In1(ALUOut_c),
    .In2(ReadData),
    .out(WD3_c),
    .sel(MemtoReg)
); 

wire    [31:0]  RD1_c;
wire    [31:0]  RD2_c;

assign  WriteData = RD2_c;
reg_file U0_reg_file (
    .clk(CLK),
    .rst(RST),
    .A1(Instr[25:21]),
    .A2(Instr[20:16]),
    .A3(WriteReg),
    .WE3(RegWrite),
    .WD3(WD3_c),
    .RD1(RD1_c),
    .RD2(RD2_c)
);

wire    [31:0]  srcB_c;
wire    [31:0]  SignImm_c;
wire            zero_c;

Mux #(.width(32)) U0_Mux_1 (
    .In1(RD2_c),
    .In2(SignImm_c),
    .out(srcB_c),
    .sel(ALUSrc)
); 

assign  ALUOut = ALUOut_c;
assign  zero = zero_c;

ALU U0_ALU (
    .sel(ALU_Control),
    .srcA(RD1_c),
    .srcB(srcB_c),
    .result(ALUOut_c),
    .zero(zero_c)
);


sign_extend U0_sign_extend (
    .Instr(Instr[15:0]),
    .SignImm(SignImm_c)
);

wire    [27:0]  lower_shifter_c;
wire    [27:0]  lower_shifter_in_c;
assign lower_shifter_in_c = {2'b00,Instr[25:0]};

shift_left #(.width(28),.width2(28)) U0_shift_left  (
    .Out(lower_shifter_c),
    .In(lower_shifter_in_c)
);

wire   [31:0] PCBranch_in_c;
wire   [31:0] PCBranch_out_c;
wire   [31:0] PCPlus4_c;

shift_left #(.width(32),.width2(32)) U1_shift_left  (
    .Out(PCBranch_in_c),
    .In(SignImm_c)
);

Adder U0_Adder (
    .inputA(PCBranch_in_c),
    .inputB(PCPlus4_c),
    .result(PCBranch_out_c)
);

wire    [31:0]  Mux_left1_out_c;

Mux #(.width(32)) U0_Mux_left1 (
    .In1(PCPlus4_c),
    .In2(PCBranch_out_c),
    .out(Mux_left1_out_c),
    .sel(PCSrc)
); 

wire    [31:0]  input_Adress_c;
wire    [31:0]  pc_jump_c;
assign pc_jump_c = ({PCPlus4_c[31:28],lower_shifter_c[27:0]});

Mux #(.width(32)) U1_Mux_left2 (
    .In1(Mux_left1_out_c),
    .In2(pc_jump_c),
    .out(input_Adress_c),
    .sel(Jump)
); 

wire    [31:0]  PC_c;

PC U0_PC (
    .clk(CLK),
    .rst(RST),
    .input_Adress(input_Adress_c),
    .output_Adress(PC_c)
);
assign  PC = PC_c;


Adder U1_Adder (
    .inputA(PC_c),
    .inputB(32'd4),
    .result(PCPlus4_c)
);

endmodule