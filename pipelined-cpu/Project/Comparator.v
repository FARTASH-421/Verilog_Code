module Comparator(A_data, B_data, Comparator_Out); 

input [7:0] A_data, B_data; //The two 8-bit Inputs A_data and B_data 
output [3:0]Comparator_Out; //The Outputs of comparison 

reg Gt, Lt, Eq, Ne; 
always @(*) begin 
    Gt = ( A_data > B_data )? 1'b1 : 1'b0; 
    Lt = ( A_data < B_data )? 1'b1 : 1'b0; 
    Eq = ( A_data == B_data)? 1'b1 : 1'b0; 
    Ne = ( A_data != B_data)? 1'b1 : 1'b0; 
end 

assign Comparator_Out = {Lt,Gt,Eq,Ne};

endmodule