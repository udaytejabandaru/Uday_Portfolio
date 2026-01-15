create_floorplan -core_margins_by die -flip f -die_size_by_io_height max -site asap7sc7p5t -die_size { 236.864 180.328 0 0 0 0 }

place_inst rj_memL/mem_0_0 44.768 60.384 my
create_place_halo -insts rj_memL/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst rj_memL/mem_0_0

place_inst rj_memR/mem_0_0 180.288 60.384 my
create_place_halo -insts rj_memR/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst rj_memR/mem_0_0

place_inst COL/mem_0_0 1.92 121.824 my
create_place_halo -insts COL/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COL/mem_0_0

place_inst COL/mem_0_1 30.688 121.824 my
create_place_halo -insts COL/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COL/mem_0_1

place_inst COL/mem_0_2 59.456 121.824 my
create_place_halo -insts COL/mem_0_2 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COL/mem_0_2

place_inst COL/mem_0_3 88.224 121.824 my
create_place_halo -insts COL/mem_0_3 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COL/mem_0_3

place_inst COR/mem_0_0 209.056 121.824 r0
create_place_halo -insts COR/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COR/mem_0_0

place_inst COR/mem_0_1 180.288 121.824 r0
create_place_halo -insts COR/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COR/mem_0_1

place_inst COR/mem_0_2 151.52 121.824 r0
create_place_halo -insts COR/mem_0_2 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COR/mem_0_2

place_inst COR/mem_0_3 122.752 121.824 r0
create_place_halo -insts COR/mem_0_3 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst COR/mem_0_3

place_inst data_memL/mem_0_0 1.92 1.824 my
create_place_halo -insts data_memL/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst data_memL/mem_0_0

place_inst data_memL/mem_0_1 1.92 60.384 my
create_place_halo -insts data_memL/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst data_memL/mem_0_1

place_inst data_memR/mem_0_0 202.016 1.824 r0
create_place_halo -insts data_memR/mem_0_0 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst data_memR/mem_0_0

place_inst data_memR/mem_0_1 202.016 60.384 r0
create_place_halo -insts data_memR/mem_0_1 -halo_deltas {0.24 0.24 0.24 0.24} -snap_to_site
create_route_halo -bottom_layer M1 -space 0 -top_layer M4 -inst data_memR/mem_0_1


