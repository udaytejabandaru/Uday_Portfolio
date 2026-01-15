create_constraint_mode -name my_constraint_mode -sdc_files [list /home/011/k/kx/kxr230001/Spring25/ASIC_DESIGN/Genus2/clock_constraints_fragment.sdc /home/011/k/kx/kxr230001/Spring25/ASIC_DESIGN/Genus2/pin_constraints_fragment.sdc /home/011/k/kx/kxr230001/Spring25/ASIC_DESIGN/Genus2/MSDAP_mapped.sdc]

create_library_set -name PVT_0P63V_100C.setup_set -timing [list \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_RVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_LVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_SLVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_SRAM_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_RVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_LVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_SLVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_SRAM_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_RVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_LVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_SLVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_SRAM_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_RVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_LVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_SLVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_SRAM_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_RVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_LVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_SLVT_SS_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_SRAM_SS_nldm_201020.lib \
/home/eng/t/txg150930/workspace/ASIC/Memory/lib/SRAM1RW128x12_lib/SRAM1RW128x12_PVT_0P63V_100C.lib \
/home/eng/t/txg150930/workspace/ASIC/Memory/lib/SRAM1RW256x8_lib/SRAM1RW256x8_PVT_0P63V_100C.lib \
/home/eng/t/txg150930/workspace/ASIC/Memory/lib/SRAM2RW16x8_lib/SRAM2RW16x8_PVT_0P63V_100C.lib]

create_timing_condition -name PVT_0P63V_100C.setup_cond -library_sets [list PVT_0P63V_100C.setup_set]
create_rc_corner -name PVT_0P63V_100C.setup_rc -temperature 100.0 -qrc_tech /proj/cad/library/asap7/asap7sc7p5t_27/qrc/qrcTechFile_typ03_scaled4xV06
create_delay_corner -name PVT_0P63V_100C.setup_delay -timing_condition PVT_0P63V_100C.setup_cond -rc_corner PVT_0P63V_100C.setup_rc
create_analysis_view -name PVT_0P63V_100C.setup_view -delay_corner PVT_0P63V_100C.setup_delay -constraint_mode my_constraint_mode

create_library_set -name PVT_0P77V_0C.hold_set -timing [list \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_RVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_LVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_SLVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SIMPLE_SRAM_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_RVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_LVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_SLVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_AO_SRAM_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_RVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_LVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_SLVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_OA_SRAM_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_RVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_LVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_SLVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_SEQ_SRAM_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_RVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_LVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_SLVT_FF_nldm_201020.lib \
/proj/cad/library/asap7/asap7sc7p5t_27/LIB/NLDM/asap7sc7p5t_INVBUF_SRAM_FF_nldm_201020.lib \
/home/eng/t/txg150930/workspace/ASIC/Memory/lib/SRAM1RW128x12_lib/SRAM1RW128x12_PVT_0P77V_0C.lib \
/home/eng/t/txg150930/workspace/ASIC/Memory/lib/SRAM1RW256x8_lib/SRAM1RW256x8_PVT_0P77V_0C.lib \
/home/eng/t/txg150930/workspace/ASIC/Memory/lib/SRAM2RW16x8_lib/SRAM2RW16x8_PVT_0P77V_0C.lib]

create_timing_condition -name PVT_0P77V_0C.hold_cond -library_sets [list PVT_0P77V_0C.hold_set]
create_rc_corner -name PVT_0P77V_0C.hold_rc -temperature 0.0 -qrc_tech /proj/cad/library/asap7/asap7sc7p5t_27/qrc/qrcTechFile_typ03_scaled4xV06
create_delay_corner -name PVT_0P77V_0C.hold_delay -timing_condition PVT_0P77V_0C.hold_cond -rc_corner PVT_0P77V_0C.hold_rc
create_analysis_view -name PVT_0P77V_0C.hold_view -delay_corner PVT_0P77V_0C.hold_delay -constraint_mode my_constraint_mode
set_analysis_view -setup { PVT_0P63V_100C.setup_view } -hold { PVT_0P77V_0C.hold_view  }
