module IM(
	input [7:0] pc,
	output[15:0] instruction
);

integer i;
reg [15:0] rom [255:0];
initial begin
	$readmemb ("opcodes.txt", rom);
	for(i = 22; i<256; i = i +1)
		rom[i] <= 15'd0;
end

assign instruction = rom[pc];

endmodule
