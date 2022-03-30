module ALU (
    input       wire    [2:0]   sel,
    input       wire    [31:0]  srcA,
    input       wire    [31:0]  srcB,
    
    output      wire             zero,
    output      reg     [31:0]   result
);

always @(*) 
    begin
        case (sel)
            3'd0:
                begin
                    result = srcA&srcB;
                end
            3'd1:
                begin
                    result = srcA|srcB;
                end
            3'd2:
                begin
                    result = srcA+srcB;
                end
            3'd4:
                begin
                    result = srcA-srcB;
                end
            3'd5:
                begin
                    result = srcA*srcB;
                end
            3'd6:
                begin
                    if (srcA < srcB) 
                        begin
                            result = 32'd1;
                        end
                    else
                        begin
                            result = 32'd0;
                        end
                end 
            default: 
                begin
                    result = 32'd0;
                end
        endcase
    end

    assign zero = (result == 32'd0);

endmodule