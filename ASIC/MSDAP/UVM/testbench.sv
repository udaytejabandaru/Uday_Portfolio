// In Vivado 2022 don't include this line. On EdaPlaygrounds do.
import uvm_pkg::*; 

`include "uvm_macros.svh"
`include "test.svh"
`include "interface.svh"

// Top module in the hierarchy. includes all the testing
module top;

  // Instantiate the interface
  msdap_dut msdap_if();
  
  // Instantiate the DUT and connect it to the interface
  MSDAP UUT (
    .Dclk(msdap_if.Dclk), 
    .Sclk(msdap_if.Sclk), 
    .Reset_n(msdap_if.Reset_n), 
    .Frame(msdap_if.Frame), 
    .Start(msdap_if.Start), 
    .InputL(msdap_if.InputL), 
    .InputR(msdap_if.InputR), 
    .InReady(msdap_if.regInReady), 
    .OutReady(msdap_if.regOutReady), 
    .OutputL(msdap_if.regSerialOutputL), 
    .OutputR(msdap_if.regSerialOutputR)
  );
  
  //Clocks
	parameter Dclk_Time = 1302; 
	parameter Sclk_Time = 30; 
	
	always
	begin
      #(Dclk_Time) msdap_if.Dclk = ~msdap_if.Dclk;
	end
	
	always
	begin
		#(Sclk_Time) msdap_if.Sclk = ~msdap_if.Sclk;
	end
    
  initial begin
    msdap_if.Dclk = 1;
	msdap_if.Sclk = 1;
    Frame = 0;
    msdap.InputL = 16'b0;
    msdap.InputR = 16'b0;
    msdap.Reset_n = 1;
    // Place the interface into the UVM configuration database
    uvm_config_db#(virtual msdap_dut)::set(null, "*", "dut_vif", msdap_if);
    // Start the test
    run_test("msdap_test");
  end
  
  
  // Dump waves
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
  
endmodule