# Power strap definition for layer M1 (rails):

#reset_db -category add_stripes
#set_db add_stripes_stacked_via_bottom_layer M1
#set_db add_stripes_stacked_via_top_layer M1
#set_db add_stripes_spacing_from_block 0.000
#add_stripes -pin_layer M1 -layer M1 -over_pins 1 -master "{TAPCELL*}" -block_ring_bottom_layer_limit M1 -block_ring_top_layer_limit M1 -pad_core_ring_bottom_layer_limit M1 -pad_core_ring_top_layer_limit M1 -direction horizontal -width pin_width -nets { VSS VDD }

# Power strap definition for layer M3:

#reset_db -category add_stripes
#set_db add_stripes_stacked_via_top_layer M3
#set_db add_stripes_stacked_via_bottom_layer M1
#set_db add_stripes_trim_antenna_back_to_shape {stripe}
#set_db add_stripes_spacing_from_block 0.000
#add_stripes -create_pins 0 -block_ring_bottom_layer_limit M3 -block_ring_top_layer_limit M1 -direction vertical -layer M3 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit M1 -set_to_set_distance 10.080 -spacing 4.104 -switch_layer_over_obs 0 -width 0.936 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 1.548]

# Power strap definition for layer M4:

#reset_db -category add_stripes
#set_db add_stripes_stacked_via_top_layer M4
#set_db add_stripes_stacked_via_bottom_layer M3
#set_db add_stripes_trim_antenna_back_to_shape {stripe}
#set_db add_stripes_spacing_from_block 0.000
#add_stripes -create_pins 0 -block_ring_bottom_layer_limit M4 -block_ring_top_layer_limit M3 -direction horizontal -layer M4 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit M3 -set_to_set_distance 10.752 -spacing 0.288 -switch_layer_over_obs 0 -width 0.864 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 1] + 2.304]

# Power strap definition for layer M5:

#reset_db -category add_stripes
#set_db add_stripes_stacked_via_top_layer M5
#set_db add_stripes_stacked_via_bottom_layer M4
#set_db add_stripes_trim_antenna_back_to_shape {stripe}
#set_db add_stripes_spacing_from_block 0.000
#add_stripes -create_pins 0 -block_ring_bottom_layer_limit M5 -block_ring_top_layer_limit M4 -direction vertical -layer M5 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit M4 -set_to_set_distance 10.752 -spacing 0.288 -switch_layer_over_obs 0 -width 0.864 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 2.304]

# Power strap definition for layer M6:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer M6
set_db add_stripes_stacked_via_bottom_layer M5
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 0.000
add_stripes -create_pins 0 -block_ring_bottom_layer_limit M6 -block_ring_top_layer_limit M5 -direction horizontal -layer M6 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit M5 -set_to_set_distance 14.336 -spacing 0.288 -switch_layer_over_obs 0 -width 1.152 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 1] + 2.976]

# Power strap definition for layer M7:

reset_db -category add_stripes
set_db add_stripes_stacked_via_top_layer M7
set_db add_stripes_stacked_via_bottom_layer M6
set_db add_stripes_trim_antenna_back_to_shape {stripe}
set_db add_stripes_spacing_from_block 0.000
add_stripes -create_pins 0 -block_ring_bottom_layer_limit M7 -block_ring_top_layer_limit M6 -direction vertical -layer M7 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit M6 -set_to_set_distance 14.336 -spacing 0.288 -switch_layer_over_obs 0 -width 1.152 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 2.976]

# Power strap definition for layer M8:

#reset_db -category add_stripes
#set_db add_stripes_stacked_via_top_layer M8
#set_db add_stripes_stacked_via_bottom_layer M7
#set_db add_stripes_trim_antenna_back_to_shape {stripe}
#set_db add_stripes_spacing_from_block 0.000
#add_stripes -create_pins 0 -block_ring_bottom_layer_limit M8 -block_ring_top_layer_limit M7 -direction horizontal -layer M8 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit M7 -set_to_set_distance 4.480 -spacing 0.480 -switch_layer_over_obs 0 -width 1.760 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 1] + 3.760]

# Power strap definition for layer M9:

#reset_db -category add_stripes
#set_db add_stripes_stacked_via_top_layer M9
#set_db add_stripes_stacked_via_bottom_layer M8
#set_db add_stripes_trim_antenna_back_to_shape {stripe}
#set_db add_stripes_spacing_from_block 0.000
#add_stripes -create_pins 1 -block_ring_bottom_layer_limit M9 -block_ring_top_layer_limit M8 -direction vertical -layer M9 -nets {VSS VDD} -pad_core_ring_bottom_layer_limit M8 -set_to_set_distance 4.480 -spacing 0.480 -switch_layer_over_obs 0 -width 1.760 -area [get_db designs .core_bbox] -start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + 3.760]
