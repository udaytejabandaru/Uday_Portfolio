
class msdap_packet extends uvm_sequence_item;

  `uvm_object_utils(msdap_packet)

	integer dataindex = 0, input_bitpos = 15, outputrowcount=0;;
	integer outputL_bitpos = 40,outputR_bitpos = 40;
	integer output_file;
	reg [39:0] reg_OutR = 40'b0, reg_OutL = 40'b0;
	reg reg_resetflag = 1'b0;
	reg [15:0] data [0:15055];
	reg [39:0] OutputL, OutputR;
	wire InReady, OutReady;
  
  $readmemh ("data.in", data);
	

  function new (string name = "");
    super.new(name);
  endfunction

  endclass msdap_packet

class msdap_sequence extends uvm_sequence#(msdap_packet);

  `uvm_object_utils(msdap_sequence)
  
 msdap_packet pkt; //added by me 

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
	// body of the sequence. Where you must generate 5 random patterns for each of the 5 commands
    `uvm_info ("BASE_SEQ", $sformatf ("Generating sequence"), UVM_MEDIUM); // added by me
    //pkt = salu_packet::type_id::create("pkt", this); // added by me
       pkt = msdap_packet::type_id::create("pkt");

    start_item(pkt); // added by me 
    assert(pkt.randomize()); // added by me 
    finish_item(pkt); // added by me 
  endtask: body

endclass: msdap_sequence