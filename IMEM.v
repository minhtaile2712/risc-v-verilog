module IMEM (inst, PC);
parameter FIRST_PC = 32'h00000000;
parameter NUM_OF_BITS = 22;
parameter MEM_DEPTH = 1 << NUM_OF_BITS; // 16MBytes (2^24 bytes) - 4MWords (2^22 words)

input [31:0] PC;
output reg [31:0] inst;

reg [31:0] IMEM[0:MEM_DEPTH-1];
wire [NUM_OF_BITS-1:0] pWord;
wire [1:0] pByte;

assign pWord = PC[NUM_OF_BITS+1:2];
assign pByte = PC[1:0];

initial begin
	$readmemh("C:/workspace/rars/full_test.mem", IMEM, FIRST_PC >> 2); // first PC to upload code
end
always @(PC) begin
	if (pByte == 2'b00)
		inst <= IMEM[pWord];
	else
		inst <= 'hz;
end
endmodule
