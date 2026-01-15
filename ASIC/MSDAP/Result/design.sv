module top(input Dclk, Sclk, Reset_n, Frame, Start, 
		input[15:0] InputL, InputR, 
		output InReady, OutReady, OutputL, OutputR);
	
	wire rj_enable, coeff_enable, data_enable,rjL_enable, coeffL_enable, inputL_enable,rjR_enable, coeffR_enable, inputR_enable,
		work_enable, sleep_flag, Sclk_in;
	wire [3:0] rjwrite, rjL_addr, rjR_addr;
	wire [8:0] coeffwrite, coeffL_addr, coeffR_addr;
	wire [7:0] datawrite, inputL_addr, inputR_addr;
	wire [15:0] rjdataL, coeffdataL, indataL;
	wire [15:0] rjdataR, coeffdataR, indataR;
	wire flag_zeroL, flag_zeroR,addsubL, adderL_en, shiftL_en, loadL, clearL, en_PISO_L,addsubR, adderR_en, shiftR_en, loadR, clearR, en_PISO_R,
			OutReadyL, OutReadyR,Frame_in, Dclk_in, Clear, input_ready;
	wire [39:0] addL_input, addR_input;
	wire [39:0] Shift_done_L, Shift_done_R, sum_L, sum_R;
	wire [15:0] dataL, dataR;


	PISO PISOL (.Sclk(Sclk_in), .Clear(Clear), .Frame(Frame_in), .InputParallel(Shift_done_L), .OutputSerial(OutputL), .enable_PISO(en_PISO_L), .OutReady(OutReadyL));
	
	PISO PISOR (.Sclk(Sclk_in), .Clear(Clear), .Frame(Frame_in), .InputParallel(Shift_done_R), .OutputSerial(OutputR), .enable_PISO(en_PISO_R), .OutReady(OutReadyR));

	PIPO pipo (.Frame(Frame_in), .Dclk(Dclk_in), .Clear(Clear), .InputL(InputL), .InputR(InputR), .input_ready(input_ready), .dataL(dataL), .dataR(dataR));
	assign OutReady = OutReadyL && OutReadyR;
	
	rj_memory rjL (.write_enable(rj_enable), .read_enable(rjL_enable), .Sclk(Sclk_in),.Frame(Frame),
					.Write_Address(rjwrite), .Read_Address(rjL_addr),
					.data_in(dataL), .Rj(rjdataL));
	
	rj_memory rjR (.write_enable(rj_enable), .read_enable(rjR_enable), .Sclk(Sclk_in),.Frame(Frame),
					.Write_Address(rjwrite), .Read_Address(rjR_addr),
					.data_in(dataR), .Rj(rjdataR));
					
	coeff_memory coeffL (.write_enable(coeff_enable), .read_enable(coeffL_enable), .Sclk(Sclk_in),.Frame(Frame),
						  .Write_Address(coeffwrite), .Read_Address(coeffL_addr),
						  .data_in(dataL), .Coeff(coeffdataL));
	
	coeff_memory coeffR (.write_enable(coeff_enable), .read_enable(coeffR_enable), .Sclk(Sclk_in),.Frame(Frame),
						  .Write_Address(coeffwrite), .Read_Address(coeffR_addr),
						  .data_in(dataR), .Coeff(coeffdataR));

	data_memory inL (.write_enable(data_enable), .read_enable(inputL_enable), .Sclk(Sclk_in),.Frame(Frame),
						.input_ready(input_ready),.Write_Address(datawrite), .Read_Address(inputL_addr),
					   .data_in(dataL), .data_stored(indataL), .allzeros(flag_zeroL));

	data_memory inR (.write_enable(data_enable), .read_enable(inputR_enable), .Sclk(Sclk_in),.Frame(Frame),
						.input_ready(input_ready), .Write_Address(datawrite), .Read_Address(inputR_addr),
					   .data_in(dataR), .data_stored(indataR), .allzeros(flag_zeroR));
	
	adder addL (.input1(addL_input), .input2(Shift_done_L), .op(addsubL), .out(sum_L));
	
	adder addR (.input1(addR_input), .input2(Shift_done_R), .op(addsubR), .out(sum_R));
	
	shifter shiftL (.shift_en(shiftL_en), .load(loadL), .clear(clearL), .sclk(Sclk_in), .inputdata(sum_L), .outputdata(Shift_done_L));
	
	shifter shiftR (.shift_en(shiftR_en), .load(loadR), .clear(clearR), .sclk(Sclk_in), .inputdata(sum_R), .outputdata(Shift_done_R));
	
					   
	main_controller main_ctrl (.Sclk(Sclk), .Dclk(Dclk), .Start(Start), .Reset_n(Reset_n),
								.Frame(Frame), .input_ready(input_ready), .allzeros_L(flag_zeroL), .allzeros_R(flag_zeroR),
								.Rj_Read_Address(rjwrite), .Coefficient_Read_Address(coeffwrite), .Input_Read_Address(datawrite),
								.Rj_Read_Enable(rj_enable), .Coefficient_Read_Enable(coeff_enable), .Data_Read_Enable(data_enable), .Clear(Clear),
								.Frame_out(Frame_in), .Dclk_out(Dclk_in), .Sclk_out(Sclk_in),
								.en_FIR(work_enable), .sleep_flag(sleep_flag),
								.InReady(InReady));
	
	alu_controller alu_ctrl (.en_FIR(work_enable), .Clear(Clear), .Sclk(Sclk_in), .sleep_flag(sleep_flag),
							 .rjdataL(rjdataL), .coeffdataL(coeffdataL), .indataL(indataL),
							 .rjdataR(rjdataR), .coeffdataR(coeffdataR), .indataR(indataR),
							 .addL_input(addL_input), .addR_input(addR_input),
							 .rjL_addr(rjL_addr), .coeffL_addr(coeffL_addr), .inputL_addr(inputL_addr),
							 .rjR_addr(rjR_addr), .coeffR_addr(coeffR_addr), .inputR_addr(inputR_addr),
							 .rjL_enable(rjL_enable), .coeffL_enable(coeffL_enable), .inputL_enable(inputL_enable),
							 .rjR_enable(rjR_enable), .coeffR_enable(coeffR_enable), .inputR_enable(inputR_enable),
						.addsubL(addsubL), .adderL_en(adderL_en), .shiftL_en(shiftL_en), .loadL(loadL), .clearL(clearL), .enable_PISO_L(en_PISO_L),
						 .addsubR(addsubR), .adderR_en(adderR_en), .shiftR_en(shiftR_en), .loadR(loadR), .clearR(clearR), .enable_PISO_R(en_PISO_R));
							 
	
	
	
endmodule

