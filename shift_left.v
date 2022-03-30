module shift_left #(parameter width = 32, parameter width2 =32)
(
    input   wire[width-1:0]  In,
    output  wire[width2-1:0]  Out
);

assign Out = (In<<2);
    
endmodule