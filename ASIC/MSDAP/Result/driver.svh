      
// driver class. gets items from sequencer and drives them into the dut
class msdap_driver extends uvm_driver #(msdap_packet);

  `uvm_component_utils(msdap_driver)
  
  virtual msdap_dut dut_vif;
  event drvdone, mondone; //added by me
  msdap_packet pkt; /////////Added by me
	

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual msdap_dut)::get(this, "", "dut_vif", dut_vif)) begin
      `uvm_error("", "uvm_config_db::get failed");
    end
    `uvm_info("TEST", $sformatf("DRV build Passed"), UVM_MEDIUM);
  endfunction 

  task run_phase(uvm_phase phase);
    `uvm_info("TEST", $sformatf("DRV run start"), UVM_MEDIUM);

    
    // drive the packet into the dut
    forever begin
      Start = 1'b0;
      #2; 
      Start = 1'b1;
	  //call get_next_item() on seq_item_port to get a packet. 2) configure the intreface signals using the packet.
      seq_item_port.get_next_item(pkt); //added by me
      
	  @(posedge msdap_if.Dclk)
      if ((((pkt.dataindex == 9458) || (pkt.dataindex == 13058)) && pkt.reg_rese<tflag == 1'b0))
		begin
			msdap_if.Reset_n <= 1'b0;
			msdap_if.reg_resetflag <= 1'b1;
		end
      else if (pkt.InReady || msdap_if.reg_resetflag)
		begin
          if (pkt.dataindex < 15056)
			begin
				msdap_if.Reset_n <= 1'b1;
              if (pkt.input_bitpos == 15 )
					msdap_if.Frame <= 1'b1;
				else
					msdap_if.Frame = 1'b0;
              if (pkt.input_bitpos == 15)
				begin
					msdap_if.InputL <= pkt.data[dataindex];
					msdap_if.InputR <= pkt.data[dataindex+1];
					msdap_if.input_bitpos <= input_bitpos - 1;
				end
              else if (msdap_if.input_bitpos >= 0)
				begin
					msdap_if.input_bitpos <= input_bitpos - 1;
				end
				else
				begin
					msdap_if.input_bitpos <= 15;
					pkt.dataindex = pkt.dataindex + 2;
					if (reg_resetflag)
						reg_resetflag = 1'b0;
				end
			end
		end
    end
	  //call item_done() on the seq_item_port to let the sequencer know you are ready for the next item.
      seq_item_port.item_done();//added by me
      
	  
	  //communicate to the monitor to let it know the signals have been written and the output is ready to received (use drvdone event)
      repeat(2)@(posedge dut_vif.clock); //added by me 
      `uvm_info ("write", $sformatf("DRV driving item time: %0t, a=%0b, b=%0b, cmd=%b", $time, pkt.a, pkt.b, pkt.cmd), UVM_MEDIUM) //added by me 
      ->drvdone; //added by me
	  //wait to make sure that monitor is done reading the output before loading the next item into the dut (you may create a new event, or simply wait some time)
      @(mondone); //added by me

    end
  endtask

endclass: msdap_driver
