module reg_file (
    input   wire    [31:0]      WD3,
    input   wire                WE3,
    input   wire    [4:0]       A3,

    input   wire    [4:0]       A1,
    input   wire    [4:0]       A2,

    input   wire                clk,
    input   wire                rst,

    output  reg    [31:0]      RD1,
    output  reg    [31:0]      RD2
);

    reg     [31:0]    reg_file    [0:99];
    integer i;

    always @(*) 
        begin
            RD1 = reg_file[A1];
            RD2 = reg_file[A2];
        end

    always @(posedge clk or negedge rst)
        begin
            if (!rst)
                begin
                    for (i=0;i<100;i=i+1)
                        begin
                            reg_file[i] <= 32'd0;
                        end
                end

            else if (WE3)
                begin
                    reg_file[A3] = WD3;
                end
        end
    
endmodule
