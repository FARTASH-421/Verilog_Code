
module EnCoder4to2(I_0, I_1, I_2, I_3, O_0, O_1, V);
    output O_0, O_1, V;
    input I_0, I_1, I_2, I_3;
    wire a;

    and(a, ~I_2, I_1);
    or(O_0, a, I_3);
    or (O_1, I_2, I_3);
    or(V, O_1, I_0, I_1);
    
endmodule