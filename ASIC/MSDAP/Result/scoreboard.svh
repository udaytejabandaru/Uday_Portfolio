
// scoreboard object
class msdap_scoreboard extends uvm_scoreboard;
  `uvm_component_utils (msdap_scoreboard)
	
  function new (string name = "msdap_scoreboard", uvm_component parent);
		super.new (name, parent);
	endfunction

	//define analysis port
  uvm_analysis_imp #(msdap_packet, msdap_scoreboard) ap_imp; // added by me 
	
	function void build_phase (uvm_phase phase);
		ap_imp = new ("ap_imp", this);
      `uvm_info("TEST", $sformatf("SCO build Passed"), UVM_MEDIUM);
	endfunction
	
	// this function gets called when the monitor sends data to the scoreboard. We read the data and perform checks here
  virtual function void write (msdap_packet data);

	endfunction

endclass
