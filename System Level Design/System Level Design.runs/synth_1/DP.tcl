# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/nsarras/System Level Design/System Level Design.cache/wt} [current_project]
set_property parent.project_path {C:/Users/nsarras/System Level Design/System Level Design.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  {C:/Users/nsarras/System Level Design/System Level Design.srcs/sources_1/new/RF.v}
  {C:/Users/nsarras/System Level Design/System Level Design.srcs/sources_1/new/MUX2.v}
  {C:/Users/nsarras/System Level Design/System Level Design.srcs/sources_1/new/MUX1.v}
  {C:/Users/nsarras/System Level Design/System Level Design.srcs/sources_1/new/ALU.v}
  {C:/Users/nsarras/System Level Design/System Level Design.srcs/sources_1/new/DP.v}
}
read_xdc {{C:/Users/nsarras/System Level Design/System Level Design.srcs/constrs_1/new/FPGA.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/nsarras/System Level Design/System Level Design.srcs/constrs_1/new/FPGA.xdc}}]

synth_design -top DP -part xc7a100tcsg324-1
write_checkpoint -noxdef DP.dcp
catch { report_utilization -file DP_utilization_synth.rpt -pb DP_utilization_synth.pb }
