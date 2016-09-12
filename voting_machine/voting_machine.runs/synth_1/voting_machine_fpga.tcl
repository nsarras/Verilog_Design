# 
# Synthesis run script generated by Vivado
# 

debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/nsarras/voting_machine/voting_machine.cache/wt [current_project]
set_property parent.project_path C:/Users/nsarras/voting_machine/voting_machine.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/nsarras/voting_machine/voting_machine.srcs/sources_1/new/voting_rule.v
  C:/Users/nsarras/voting_machine/voting_machine.srcs/sources_1/new/led_mux.v
  C:/Users/nsarras/voting_machine/voting_machine.srcs/sources_1/new/clk_gen.v
  C:/Users/nsarras/voting_machine/voting_machine.srcs/sources_1/new/bcd_to_7seg.v
  C:/Users/nsarras/voting_machine/voting_machine.srcs/sources_1/new/voting_machine_fpga.v
}
read_xdc C:/Users/nsarras/voting_machine/voting_machine.srcs/constrs_1/new/voting_machine_fpga.xdc
set_property used_in_implementation false [get_files C:/Users/nsarras/voting_machine/voting_machine.srcs/constrs_1/new/voting_machine_fpga.xdc]

synth_design -top voting_machine_fpga -part xc7a100tcsg324-1
write_checkpoint -noxdef voting_machine_fpga.dcp
catch { report_utilization -file voting_machine_fpga_utilization_synth.rpt -pb voting_machine_fpga_utilization_synth.pb }
