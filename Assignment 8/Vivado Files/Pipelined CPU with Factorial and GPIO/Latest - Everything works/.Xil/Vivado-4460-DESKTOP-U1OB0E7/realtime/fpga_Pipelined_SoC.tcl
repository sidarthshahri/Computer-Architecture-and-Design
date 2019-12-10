# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_resetSystemStats
    rt::HARTNDb_startSystemStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    rt::set_parameter enableParallelHelperSpawn true
    set ::env(RT_TMP) "C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/.Xil/Vivado-4460-DESKTOP-U1OB0E7/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a35tcpg236-2L
     file delete -force synth_hints.os

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog -include {{C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/SoC}} {
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/CMP_ERROR.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/CMP_GT.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/CNT.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/CU.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/new/DE_EX_State_Reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/DP.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/new/EX_MEM_State_Reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/new/FE_DE_Stage_Reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/Factorial.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/new/MEM_WB_State_Reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/MUL.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/MUX.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/new/Pipelined_SoC.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/Factorial/REG.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/SoC_ad.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/SoC_mux4.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/adder.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/alu.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/auxdec.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/FPGA/button_debouncer.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/FPGA/clk_gen.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/controlunit.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/dmem.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/dreg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/fact_ad.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/fact_and.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/fact_done_stat_reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/fact_err_stat_reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/fact_mux4.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/fact_reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/fact_top.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/gpio_ad.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/gpio_mux4.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/gpio_reg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/gpio_top.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/FPGA/hex_to_7seg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/imem.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/FPGA/led_mux.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/maindec.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/mips.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/mult.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/mux2.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/regfile.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/shifter.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/signext.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/imports/sources/SoC/we_dreg.v}
      {C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/Pipelined_CPU_Factorial_GPIO.srcs/sources_1/new/fpga_Pipelined_SoC.v}
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top fpga_Pipelined_SoC
    rt::set_parameter enableIncremental true
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter elaborateRtlOnlyFlow true
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
# MODE: 
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "C:/Users/Sidarth Shahri/Documents/CMPE 140 Assignments/Assignment 8/Pipelined_CPU_Factorial_GPIO/.Xil/Vivado-4460-DESKTOP-U1OB0E7/"
    set ok_to_delete_rt_tmp true 
    if { [rt::get_parameter parallelDebug] } { 
       set ok_to_delete_rt_tmp false 
    } 
    if {$rt::useElabCache == false} {
        set oldMIITMVal [rt::get_parameter maxInputIncreaseToMerge]; rt::set_parameter maxInputIncreaseToMerge 1000
        set oldCDPCRL [rt::get_parameter createDfgPartConstrRecurLimit]; rt::set_parameter createDfgPartConstrRecurLimit 1
        $rt::db readXRFFile
      rt::run_rtlelab -module $rt::top
        rt::set_parameter maxInputIncreaseToMerge $oldMIITMVal
        rt::set_parameter createDfgPartConstrRecurLimit $oldCDPCRL
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }


  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  rt::set_parameter helper_shm_key "" 
    if { [ info exists ::env(RT_TMP) ] } {
      if { [info exists ok_to_delete_rt_tmp] && $ok_to_delete_rt_tmp } { 
        file delete -force $::env(RT_TMP)
      }
    }

    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  set hsKey [rt::get_parameter helper_shm_key] 
  if { $hsKey != "" && [info exists ::env(BUILTIN_SYNTH)] && [rt::get_parameter enableParallelHelperSpawn] } { 
     $rt::db killSynthHelper $hsKey
  } 
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
