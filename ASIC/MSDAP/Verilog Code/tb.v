`timescale 1ns / 1ps

module tb;

	// Inputs
	reg Dclk;
	reg Sclk;
	reg Reset_n;
	reg Frame;
	reg Start;
	reg InputL;
	reg InputR;

	// Outputs
	wire InReady_reg;
	wire OutReady_reg;
	wire OutputL_reg;
	wire OutputR_reg;

	// Aliases
	wire InReady = InReady_reg;
	wire OutReady = OutReady_reg;

	// Testbench control
	integer count = 0;
	integer mv;

	// Input data memory
	reg [15:0] data [0:15055];

	// Parameters
	parameter Dclk_Time = 651;
	parameter Sclk_Time = 18;

	// Shift register capture
	integer l = 39, m = 0, n = 15;
	reg [39:0] writeL = 40'd0, writeR = 40'd0;
	reg flag_reset = 1'b0;

	// Instantiate the DUT
	top uut_reg (
		.Dclk(Dclk),
		.Sclk(Sclk),
		.Reset_n(Reset_n),
		.Frame(Frame),
		.Start(Start),
		.InputL(InputL),
		.InputR(InputR),
		.InReady(InReady_reg),
		.OutReady(OutReady_reg),
		.OutputL(OutputL_reg),
		.OutputR(OutputR_reg)
	);

	// Clock generation
	initial begin
		Dclk = 0;
		Sclk = 0;
	end

	always #(Dclk_Time) Dclk = ~Dclk;
	always #(Sclk_Time) Sclk = ~Sclk;

	// File initialization and data load
	initial begin
		Frame = 0;
		InputL = 0;
		InputR = 0;
		Reset_n = 1'b0;
		Start = 1'b0;

		// Load memory first
		$readmemh("data1.in.txt", data);
		mv = $fopen("data1_s.out", "w+");

		#50;
		Reset_n = 1'b1;
		Start = 1'b1;
		#2 Start = 1'b0;
	end

	// Input feeding FSM
	always @(posedge Dclk) begin
		if ((m == 9458 || m == 13058) && !flag_reset) begin
			Reset_n <= 1'b0;
			flag_reset <= 1'b1;
		end else if (InReady || flag_reset) begin
			if (m < 15054) begin  // Prevent overflow at data[m+1]
				Frame <= (n == 15) ? 1'b1 : 1'b0;

				if (n >= 0) begin
					InputL <= data[m][n];
					InputR <= data[m + 1][n];
					n = n - 1;
				end

				if (n < 0) begin
					n = 15;
					m = m + 2;
					if (flag_reset) begin
						Reset_n <= 1'b1;
						flag_reset <= 1'b0;
					end
				end
			end else begin
				InputL <= 0;
				InputR <= 0;
				Frame <= 0;
			end
		end
	end

	// Output capture logic
	always @(negedge Sclk) begin
		if (OutReady) begin
			if (l >= 0) begin
				writeL[l] = OutputL_reg;
				writeR[l] = OutputR_reg;
				l = l - 1;
			end

			if (l < 0 && count < 6395) begin
				if (count != 3798 && count != 5397)
					$fwrite(mv, "%010h %010h\n", writeL, writeR);
				count = count + 1;
				l = 39;
			end

			if (count == 6394) begin
				$display("Simulation completed at count = %0d", count);
				$fclose(mv);
				$finish;
			end
		end
	end

	// VCD dump for waveform
	initial begin
		$dumpfile("tb_dump.vcd");
		$dumpvars(0, tb);
	end

endmodule

