
// the DUT interface
interface msdap_dut;
    logic  Dclk;
    logic  Sclk;logic  Reset_n;
    logic  Frame;
    logic  Start;
    logic [15:0] InputL;logic [15:0] InputR;
	logic  regInReady;
	logic  regOutReady;
	logic  regSerialOutputL;
	logic  regSerialOutputR;    
endinterface
