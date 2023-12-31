#========================================================================================================================
# Copyright (c) 2019 by Bitvis AS.  All rights reserved.
# You should have received a copy of the license file containing the MIT License (see LICENSE.TXT), if not,
# contact Bitvis AS <support@bitvis.no>.
#
# UVVM AND ANY PART THEREOF ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH UVVM OR THE USE OR
# OTHER DEALINGS IN UVVM.
#========================================================================================================================

#-----------------------------------------------------------------------
# This file must be called with 2 arguments:
#
#   arg 1: Part directory of this library/module
#   arg 2: Target directory
#-----------------------------------------------------------------------

# End the simulations if there's an error or when run from terminal.
if {[batch_mode]} {
  onerror {abort all; exit -f -code 1}
} else {
  onerror {abort all}
}

# Detect simulator
if {[catch {eval "vsim -version"} message] == 0} {
  quietly set simulator_version [eval "vsim -version"]
  # puts "Version is: $simulator_version"
  if {[regexp -nocase {modelsim} $simulator_version]} {
    quietly set simulator "modelsim"
  } else {
    puts "Unknown simulator. Attempting to use Modelsim commands."
    quietly set simulator "modelsim"
  }
} else {
    puts "vsim -version failed with the following message:\n $message"
    abort all
}

#------------------------------------------------------
# Set up source_path and target_path
#------------------------------------------------------
if {$argc == 2} {
  quietly set source_path "$1"
  quietly set target_path "$2"
} elseif {$argc == -1} {
  # Called from other script
} else {
  error "Needs two arguments: source path and target path"
}

#------------------------------------------------------
# Read compile_order.txt and set lib_name
#------------------------------------------------------
quietly set fp [open "$source_path/script/compile_order.txt" r]
quietly set file_data [read $fp]
quietly set lib_name [lindex $file_data 2]
close $fp

echo "\n\n=== Re-gen lib and compile $lib_name source\n"
echo "Source path: $source_path"
echo "Target path: $target_path"

#------------------------------------------------------
# (Re-)Generate library and Compile source files
#------------------------------------------------------
if {[file exists $target_path/$lib_name]} {
  file delete -force $target_path/$lib_name
}
if {![file exists $target_path]} {
  file mkdir $target_path/$lib_name
}

quietly vlib $target_path/$lib_name
quietly vmap $lib_name $target_path/$lib_name

# These two core libraries are needed by every VIP (except the IRQC and UART demos),
# therefore we should map them in case they were compiled from different directories
# which would cause the references to be in a different file.
# First check if the libraries are in the specified target path, if not, then look
# in the default UVVM structure.
if {$lib_name != "uvvm_util" && $lib_name != "bitvis_irqc" && $lib_name != "bitvis_uart"} {
  echo "Mapping uvvm_util and uvvm_vvc_framework"
  if {[file exists $target_path/uvvm_util]} {
    quietly vmap uvvm_util $target_path/uvvm_util
  } else {
    quietly vmap uvvm_util $source_path/../uvvm_util/sim/uvvm_util
  }
  if {[file exists $target_path/uvvm_vvc_framework]} {
    quietly vmap uvvm_vvc_framework $target_path/uvvm_vvc_framework
  } else {
    quietly vmap uvvm_vvc_framework $source_path/../uvvm_vvc_framework/sim/uvvm_vvc_framework
  }
}

if { [string equal -nocase $simulator "modelsim"] } {
  quietly set compdirectives "-quiet -suppress 1346,1236,1090 -2008 -work $lib_name"
}

#------------------------------------------------------
# Compile src files
#------------------------------------------------------
echo "\nCompiling $lib_name source\n"
quietly set idx 0
foreach item $file_data {
  if {$idx > 2} {
    echo "eval vcom  $compdirectives  $source_path/script/$item"
    eval vcom  $compdirectives  $source_path/script/$item
  }
  incr idx 1
}
