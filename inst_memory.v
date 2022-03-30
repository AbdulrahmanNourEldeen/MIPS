module inst_memory (
    input   wire    [31:0]      pc,
    output  reg     [31:0]      instr
);

    reg    [31:0]   mem    [0:99];
    
    initial 
        begin
            $readmemh ("Program1.txt",mem);
        end
    always @(*) 
        begin
            instr = mem[pc >> 2];
        end 

endmodule
