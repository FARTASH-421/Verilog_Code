module ALU(ain,bin,func,result,z,carry);
	input [7:0]ain, bin;
	input [3:0]func;

	output reg [7:0]result;
	output reg carry;
	output reg z;

	reg [8:0] temp;

	initial begin
		result = 0;
		z = 0;
		carry = 0;
		temp = 0;
	end

	always @(*)begin
		if(func==4'b0001) begin //ADD
			temp = ain + bin;
			result = temp[7:0];
			carry = temp[8];
		if(result==0)
			z = 1;
		else
			z = 0;
		end
		else if(func==4'b0010)begin // SUBTRACT
			temp = ain - bin;
			result = temp[7:0];
			carry = temp[8];
		if(result==0)
			z = 1;
		else
			z = 0;
		end
		else if(func==4'b00011)begin // INCREMENT BY 1
			temp = ain + 1;
			result = temp[7:0];
			carry = temp[8];
		if(result==0)
			z = 1;
		else
			z = 0;
		end
		else if(func==4'b0100)begin // DECREMENT BY 1
			temp = ain - 1;
			result = temp[7:0];
			carry = temp[8];
		if(result==0)
			z = 1;
		else
			z = 0;
		end

		else if(func==4'b0101)begin // ADD Immediate
			result = ain + bin;
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end 
		else if(func==4'b0110)begin // Subtract Immediate
			result = ain - bin;
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end //AND
		else if(func==4'b0111)begin // EX OR
			result = ain^bin;
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end 
		else if(func==4'b0111)begin  // NAND
			result[0] = ~(ain[0]&bin[0]);
			result[1] = ~(ain[1]&bin[1]);
			result[2] = ~(ain[2]&bin[2]);
			result[3] = ~(ain[3]&bin[3]);
			result[4] = ~(ain[4]&bin[4]);
			result[5] = ~(ain[5]&bin[5]);
			result[6] = ~(ain[6]&bin[6]);
			result[7] = ~(ain[7]&bin[7]);
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end //NAND
		else if(func==4'b1000)begin  // NOT
			result[0] = ~ain[0];
			result[1] = ~ain[1];
			result[2] = ~ain[2];
			result[3] = ~ain[3];
			result[4] = ~ain[4];
			result[5] = ~ain[5];
			result[6] = ~ain[6];
			result[7] = ~ain[7];
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end //NOT

		else if(func==4'b1001)begin // BEQ Function
		if(ain==bin)
			result=0;
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end 

		else if(func==4'b1010)begin // BNE Function
			temp=ain-bin;
			carry = temp[8];
			result = temp[7:0];
		if(result==0)
			z = 1;
		else
			z = 0;
		end 

		else if(func==4'b1011)begin // BLT Function
			temp=ain-bin;
			carry = temp[8];
			result = temp[7:0];
		if(result==0)
			z = 1;
		else
			z = 0;
		end 

		else if(func==4'b1100)begin // BGT Function
			temp=bin-ain;
			carry = temp[8];
			result = temp[7:0];
		if(result==0)
			z = 1;
		else
			z = 0;
		end 

		else if(func==4'b1110)begin // LOAD
			result = ain + bin;
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end 

		else if(func==4'b1111)begin // STORE
			result = ain + bin;
			carry = 0;
		if(result==0)
			z = 1;
		else
			z = 0;
		end

		else begin 
			result = 4'bxxxx;
			carry = 0;
		end //Default
		if(result==0)
			z = 1;
		else
			z = 0;
		end

endmodule