module data_memory (
    input   wire    [31:0]      WD,
    input   wire    [31:0]      A,
    input   wire                WE,
    
    input   wire                clk,
    input   wire                rst,

    output  reg     [31:0]      RD,
    output  reg     [15:0]      test_value
);
    
    reg    [31:0]   data_memory     [0:99];
    integer i;

    always @(*) 
        begin
            RD          = data_memory[A];
            test_value  = data_memory[32'd0]; 
        end

    always @(posedge clk or negedge rst)
        begin
            if (!rst)
                begin
                    for (i=0;i<100;i=i+1)
                        begin
                            data_memory[i] <= 32'd0;
                        end
                end
            else if (WE)
                begin
                    data_memory[A] <= WD;
                end
        end

endmodule
