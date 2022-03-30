module Adder (
    input   wire    [31:0]      inputA,
    input   wire    [31:0]      inputB,
    output  wire    [31:0]      result
);

assign result = inputA + inputB;

endmodule