
// our monitor class
class msdap_monitor extends uvm_monitor;
  `uvm_component_utils (msdap_monitor)
   
   //virtual dut_if   vif; //commentout by me
  virtual msdap_dut dut_vif; //added by me
  event mondone;//added by me

   // this event is used to signal from the driver that a drive operation has concluded
   event drvdone;

   // this is the analysis port that is used to send the data to the scoreboard
  uvm_analysis_port #(msdap_packet)   mon_analysis_port;
   
   function new (string name, uvm_component parent= null);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);

      //Get virtual interface handle from the configuration DB
     if(!uvm_config_db#(virtual msdap_dut)::get(this, "", "dut_vif", dut_vif)) begin  //added by me 
      `uvm_error("", "uvm_config_db::get failed")
    end

      // Create an instance of the analysis port
      mon_analysis_port = new ("mon_analysis_port", this);
     `uvm_info("TEST", $sformatf("MON build Passed"), UVM_MEDIUM);
            
   endfunction

 virtual task run_phase (uvm_phase phase);
   
      msdap_packet  data_obj = msdap_packet::type_id::create ("data_obj", this);
      forever begin
	  
	  
	  //you need to 1) wait for the drvdone event, 2) once the driver is done, reconstruct the data_obj packet by reading 
	  // the a,b,cmd, and most importantly the out fields of the interface

        @(drvdone); // added by me
        always @(negedge Sclk)
	begin
		if (OutReady)
		begin
			if(outputL_bitpos == 40)
				Frame = 1;
			
			if(outputL_bitpos > 0)
			begin
				reg_OutL[outputL_bitpos-1] = regSerialOutputL;
				reg_OutR[outputR_bitpos-1] = regSerialOutputR;
				outputL_bitpos = outputL_bitpos - 1;
				outputR_bitpos = outputR_bitpos - 1;
			end
			if(outputL_bitpos == 0)
			begin
				$fwrite (output_file, "%H      %H\n", reg_OutL[39:0], reg_OutR[39:0]);
				$display("%d  %H      %H\n",outputrowcount, reg_OutL, reg_OutR);
				outputrowcount=outputrowcount+1;	
			end
		end
		else begin
			outputL_bitpos = 40;
	      outputR_bitpos = 40;
	      reg_OutL = 40'b0;
	      reg_OutR = 40'b0;
		end
						
		if (outputrowcount > 6394 )
		begin
			$fclose(output_file);		
			$finish;	
			end
		//end
	end
		
		
       //write data object to the analysis port to the scoreboard
        mon_analysis_port.write(data_obj);  //added by me
        -> mondone; //added by me
       
      end
   endtask

endclass