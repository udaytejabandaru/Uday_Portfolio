#Start up Innovus with "innovus -stylus"
# 1. Set root attributes
set_db design_process_node 7
#set_multi_cpu_usage -local_cpu 8
set_db timing_analysis_cppr both
set_db timing_analysis_type ocv
set_library_unit -time 1ps

# 2. Read libraries and SRAM macros
#read_physical -lef { \
#/proj/cad/library/asap7/asap7sc7p5t_27/techlef_misc/asap7_tech_4x_201209.lef \
#/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_R_4x_201211.lef \
#/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_L_4x_201211.lef \
#/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SL_4x_201211.lef \
#/proj/cad/library/asap7/asap7sc7p5t_27/LEF/scaled/asap7sc7p5t_27_SRAM_4x_201211.lef \

read_physical -lef { \
/proj/cad/library/asap7/asap7sc7p5t_28/techlef_misc/asap7_tech_1x_201209.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/asap7sc7p5t_27_R_1x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/asap7sc7p5t_27_L_1x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/asap7sc7p5t_27_SL_1x_201211.lef \
/proj/cad/library/asap7/asap7sc7p5t_27/LEF/asap7sc7p5t_27_SRAM_1x_201211.lef\
/home/eng/t/txg150930/workspace/ASIC/Memory/lef/SRAM1RW128x12_x4.lef \
/home/eng/t/txg150930/workspace/ASIC/Memory/lef/SRAM1RW256x8_x4.lef \
/home/eng/t/txg150930/workspace/ASIC/Memory/lef/SRAM2RW16x8_x4.lef }

# 3. Define corners
read_mmmc mmmc.tcl

# 4. Read netlist
read_netlist { /home/011/k/kx/kxr230001/Spring25/ASIC_DESIGN/Genus2/MSDAP_mapped.v } -top top
init_design

# 5. Setup power intent
read_power_intent -cpf power_spec.cpf
commit_power_intent

# 6. Exclude standard cells that may cause error
source set_dont_use.tcl

# 7. Set other attributes
set_db design_flow_effort standard
set_db route_design_bottom_routing_layer 2
set_db route_design_top_routing_layer 7
#Ignore 1e+31 removal arcs for ASYNC DFF cells
set_db timing_analysis_async_checks no_async
#Via preferences for stripes
set_db generate_special_via_rule_preference { M7_M6widePWR1p152 M6_M5widePWR1p152 M5_M4widePWR0p864 M4_M3widePWR0p864 M3_M2widePWR0p936 }
#set_db generate_special_via_rule_preference { M7_M6widePWR1p152 M6_M5widePWR1p152 M5_M4widePWR0p864 M3_M2widePWR0p936 }
#Prevent extending M1 pins in cells
set_db route_design_with_via_in_pin true

# 8. Read floorplan
source -echo -verbose floorplan.tcl

# 9. Create routing tracks
#add_tracks -honor_pitch -offsets { M4 horiz 0.048 M5 vert 0.048 M6 horiz 0.064 M7 vert 0.064 }

# lef 1x pitch
add_tracks -honor_pitch -offsets { M1 vert 0.036 M2 horiz 0.036 M3 vert 0.036 M4 horiz 0.048 M5 vert 0.048 M6 horiz 0.096 M7 vert 0.064 }

#add_tracks -honor_pitch -offsets { M2 horiz 0.144 M3 vert 0.144 M4 horiz 0.192 M5 vert 0.192 M6 horiz 0.256 M7 vert 0.256 }

#add_tracks -honor_pitch -offsets { M1 vert 0.072 M2 horiz 0.072 M3 vert 0.072 M4 horiz 0.048 M5 vert 0.048 M6 horiz 0.064 M7 vert 0.064 M8 horiz 0.16 M9 vert 0.16}

# 10. Create place blockage on top & bottom row (fixes wiring issue + power vias for DRC/LVS)
#set core_lly [get_db current_design .core_bbox.ll.y]
#set core_ury [expr [get_db current_design .core_bbox.ur.y] - 1.08]
#set botrow [get_db rows -if {.rect.ll.y == $core_lly}]
#set toprow [get_db rows -if {.rect.ur.y > $core_ury}]
#create_place_blockage -area [get_db $botrow .rect] -name ROW_BLOCK_BOT
#create_place_blockage -area [get_db $toprow .rect] -name ROW_BLOCK_TOP

# Get all rows
	set all_rows [get_db rows]

# Initialize trackers for lowest and highest Y-values
	set lowest_y +Inf
	set highest_y -Inf
	set botrow ""
	set toprow ""

# Loop through all rows and find the lowest and highest Y
	foreach row $all_rows {
	    set lly [get_db $row .rect.ll.y]
	    set ury [get_db $row .rect.ur.y]

	    if {$lly < $lowest_y} {
		set lowest_y $lly
		set botrow $row
	    }
	    if {$ury > $highest_y} {
		set highest_y $ury
		set toprow $row
	    }
	}

# Create blockages using their bounding boxes
	create_place_blockage -area [get_db $botrow .rect] -name ROW_BLOCK_BOT
	create_place_blockage -area [get_db $toprow .rect] -name ROW_BLOCK_TOP

# 11. Add well-tap cells
set_db add_well_taps_cell TAPCELL_ASAP7_75t_L
add_well_taps -cell_interval 50 -in_row_offset 10.564

# 12. Create power straps
source -echo -verbose power_straps.tcl

# 13. Set I/O pin locations
set_db assign_pins_edit_in_batch true
#Innovus automatically places the pin in given range
edit_pin -fixed_pin -pin * -hinst top -pattern fill_optimised -layer { M5 M7 } -side bottom -start { 236.864 0 } -end { 0 0 }   
set_db assign_pins_edit_in_batch false

# 14. Place cells
place_opt_design
 
# 15. Synthesize clock tree
create_clock_tree_spec
ccopt_design -hold -report_dir hammer_cts_debug -report_prefix hammer_cts

# 16. Add filler cells
set_db add_fillers_cells "DECAPx1_ASAP7_75t_R DECAPx1_ASAP7_75t_L DECAPx1_ASAP7_75t_SL DECAPx1_ASAP7_75t_SRAM DECAPx2_ASAP7_75t_R DECAPx2_ASAP7_75t_L DECAPx2_ASAP7_75t_SL DECAPx2_ASAP7_75t_SRAM DECAPx2b_ASAP7_75t_R DECAPx2b_ASAP7_75t_L DECAPx2b_ASAP7_75t_SL DECAPx2b_ASAP7_75t_SRAM DECAPx4_ASAP7_75t_R DECAPx4_ASAP7_75t_L DECAPx4_ASAP7_75t_SL DECAPx4_ASAP7_75t_SRAM DECAPx6_ASAP7_75t_R DECAPx6_ASAP7_75t_L DECAPx6_ASAP7_75t_SL DECAPx6_ASAP7_75t_SRAM DECAPx10_ASAP7_75t_R DECAPx10_ASAP7_75t_L DECAPx10_ASAP7_75t_SL DECAPx10_ASAP7_75t_SRAM"
add_fillers
set_db add_fillers_cells "FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM"
add_fillers

# 17. Route your design

#set_db route_design_with_via_in_pin true
#set_db route_design_detail_search_and_repair true
#set_db route_design_detail_post_route_swap_via true
#set_db route_design_extra_via_enclosure 0.04
route_design
#opt_design -post_route -hold
#opt_design -post_route -setup
opt_design -post_route -setup -hold -expanded_views
 
write_db MSDAP_FINAL -def -verilog
set_db write_stream_virtual_connection false

write_netlist MSDAP_lvs.v -top_module_first -top_module top -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM } 

write_netlist MSDAP_sim.v -top_module_first -top_module top -exclude_leaf_cells -exclude_insts_of_cells { TAPCELL_ASAP7_75t_R TAPCELL_ASAP7_75t_L TAPCELL_ASAP7_75t_SL TAPCELL_ASAP7_75t_SRAM TAPCELL_WITH_FILLER_ASAP7_75t_R TAPCELL_WITH_FILLER_ASAP7_75t_L TAPCELL_WITH_FILLER_ASAP7_75t_SL TAPCELL_WITH_FILLER_ASAP7_75t_SRAM FILLER_ASAP7_75t_R FILLER_ASAP7_75t_L FILLER_ASAP7_75t_SL FILLER_ASAP7_75t_SRAM FILLERxp5_ASAP7_75t_R FILLERxp5_ASAP7_75t_L FILLERxp5_ASAP7_75t_SL FILLERxp5_ASAP7_75t_SRAM } 

#write_stream -mode ALL -map_file /proj/cad/library/asap7/asap7_pdk_r1p7/cdslib/asap7_TechLib \
#-uniquify_cell_names -merge { \
#/proj/cad/library/asap7/asap7sc7p5t_27/GDS/asap7sc7p5t_27_L_201211.gds \
#/proj/cad/library/asap7/asap7sc7p5t_27/GDS/asap7sc7p5t_27_R_201211.gds \
#/proj/cad/library/asap7/asap7sc7p5t_27/GDS/asap7sc7p5t_27_SL_201211.gds \
#/proj/cad/library/asap7/asap7sc7p5t_27/GDS/asap7sc7p5t_27_SRAM_201211.gds \
#/home/eng/t/txg150930/workspace/ASIC/Memory/gds/SRAM1RW128x12_x4.gds \
#/home/eng/t/txg150930/workspace/ASIC/Memory/gds/SRAM1RW256x8_x4.gds \
#/home/eng/t/txg150930/workspace/ASIC/Memory/gds/SRAM2RW16x8_x4.gds }  \
#MSDAP.gds

#write_sdf MSDAP_physical.sdf

# 18. Extracts RC characteristics for the interconnects
set_db extract_rc_coupled true
extract_rc

#write_parasitics -spef_file MSDAP.PVT_0P63V_100C.par.spef -rc_corner PVT_0P63V_100C.setup_rc
#write_parasitics -spef_file MSDAP.PVT_0P77V_0C.par.spef -rc_corner PVT_0P77V_0C.hold_rc

# 19. Save the design
write_db MSDAP_FINAL

# 20. Output reports
#exec mkdir -f "reports"
if {[file exists "reports"]} {
    file delete -force "reports"
}
file mkdir "reports"

report_timing -late -max_paths 3 > reports/setup.rpt
report_timing -early -max_paths 3 > reports/hold.rpt
report_power -out_file reports/power.rpt
report_area -out_file reports/area.rpt
check_drc -limit 2000 -out_file reports/drc.rpt
#exit

