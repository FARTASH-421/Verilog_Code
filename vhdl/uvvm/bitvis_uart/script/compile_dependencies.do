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
# Call compile scripts from dependent libraries
#-----------------------------------------------------------------------
quietly set root_path "../.."
do $root_path/script/compile_src.do $root_path/uvvm_util $root_path/uvvm_util/sim
do $root_path/script/compile_src.do $root_path/uvvm_vvc_framework $root_path/uvvm_vvc_framework/sim
do $root_path/script/compile_src.do $root_path/bitvis_vip_scoreboard $root_path/bitvis_vip_scoreboard/sim
do $root_path/script/compile_src.do $root_path/xConstrRandFuncCov $root_path/xConstrRandFuncCov/sim
do $root_path/script/compile_src.do $root_path/bitvis_vip_sbi $root_path/bitvis_vip_sbi/sim
do $root_path/script/compile_src.do $root_path/bitvis_vip_uart $root_path/bitvis_vip_uart/sim
do $root_path/script/compile_src.do $root_path/bitvis_vip_clock_generator $root_path/bitvis_vip_clock_generator/sim
