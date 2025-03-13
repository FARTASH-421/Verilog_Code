module multiWithAdd_Shift(
    input clk, rst, 
    input [7:0] A, B,
    output reg [15:0] C
);

integer i;
reg [15:0]A1, Cout;
reg [7:0] rA, rB;
always@(posedge clk or posedge rst )
begin
	if (rst)begin
		C=0;
	end
	else begin
		    rA = A;
            rB = B;

            if(A[7] == 1'b1) begin
                rA = (~A) + 1'b1;
            end
            if(B[7] == 1'b1) begin
                 rB = (~B )+ 1'b1;
            end 

            Cout=0;
		    A1[7:0]=rA;
            A1[15:8]=0;
        

            for (i=0; i<7; i=i+1) begin

			    if(rB[i]==1'b0) begin
				    Cout=Cout+0;
			    end
			    else 
                if (rB[i] == 1'b1)begin
				Cout = Cout + (A1 << i);
			    end
		    end

            if((B[7] == 1'b1) && (A[7]== 1'b1)  || (B[7] == 1'b0) && (A[7]== 1'b0) ) begin
                C = Cout;
            end else if((B[7] == 1'b1) || (A[7]== 1'b1)) begin
                C = ~Cout +1 ;
            end       

	end

end
endmodule
