module Mux #(parameter width = 32)
(
    input   wire    [width-1:0]     In1,
    input   wire    [width-1:0]     In2,
    output  reg     [width-1:0]     out,
    input   wire                    sel

);

always @(*) 
    begin
        if(!sel)
            begin
                out = In1;
            end
        else
            begin
                out = In2;
            end
    end
    
endmodule