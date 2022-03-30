module PC (
    input   wire    clk,
    input   wire    rst,
    input   wire    [31:0]      input_Adress,

    output  reg    [31:0]       output_Adress
);

    always @(posedge clk or negedge rst)
        begin
            if (!rst)
                begin
                    output_Adress <= 32'd0;
                end
            else
                begin
                    output_Adress <= input_Adress;
                end
        end
    
endmodule

