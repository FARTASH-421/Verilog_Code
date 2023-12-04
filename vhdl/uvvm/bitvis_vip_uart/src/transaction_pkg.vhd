--========================================================================================================================
-- Copyright (c) 2017 by Bitvis AS.  All rights reserved.
-- You should have received a copy of the license file containing the MIT License (see LICENSE.TXT), if not,
-- contact Bitvis AS <support@bitvis.no>.
--
-- UVVM AND ANY PART THEREOF ARE PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
-- WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
-- OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
-- OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH UVVM OR THE USE OR OTHER DEALINGS IN UVVM.
--========================================================================================================================

------------------------------------------------------------------------------------------
-- Description   : See library quick reference (under 'doc') and README-file(s)
------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library uvvm_util;
context uvvm_util.uvvm_util_context;

--=================================================================================================
--=================================================================================================
--=================================================================================================
package transaction_pkg is

  --===============================================================================================
  -- t_operation
  -- - Bitvis defined operations
  --===============================================================================================
  type t_operation is (
    NO_OPERATION,
    AWAIT_COMPLETION,
    AWAIT_ANY_COMPLETION,
    ENABLE_LOG_MSG,
    DISABLE_LOG_MSG,
    FLUSH_COMMAND_QUEUE,
    FETCH_RESULT,
    INSERT_DELAY,
    TERMINATE_CURRENT_COMMAND,
    -- Transaction
    TRANSMIT, RECEIVE, EXPECT);


  constant C_CMD_DATA_MAX_LENGTH   : natural := 8;
  constant C_CMD_STRING_MAX_LENGTH : natural := 300;



  --==========================================================================================
  --
  -- DTT - Direct Transaction Transfer types, constants and global signal
  --
  --==========================================================================================

  -- Transaction status
  type t_transaction_status is (INACTIVE, IN_PROGRESS, FAILED, SUCCEEDED);

  constant C_TRANSACTION_STATUS_DEFAULT : t_transaction_status := INACTIVE;

  -- VVC Meta
  type t_vvc_meta is record
    msg     : string(1 to C_CMD_STRING_MAX_LENGTH);
    cmd_idx : integer;
  end record;

  constant C_VVC_META_DEFAULT : t_vvc_meta := (
    msg     => (others => ' '),
    cmd_idx => -1
    );

  -- Error info
  type t_error_info is record
    parity_bit_error  : boolean;
    stop_bit_error    : boolean;
  end record;

  constant C_ERROR_INFO_DEFAULT : t_error_info := (
    parity_bit_error  => false,
    stop_bit_error    => false
    );

  -- Transaction
  type t_transaction is record
    operation          : t_operation;
    data               : std_logic_vector(C_CMD_DATA_MAX_LENGTH-1 downto 0);
    vvc_meta           : t_vvc_meta;
    transaction_status : t_transaction_status;
    error_info         : t_error_info;
  end record;

  constant C_TRANSACTION_SET_DEFAULT : t_transaction := (
    operation           => NO_OPERATION,
    data                => (others => '0'),
    vvc_meta            => C_VVC_META_DEFAULT,
    transaction_status  => C_TRANSACTION_STATUS_DEFAULT,
    error_info          => C_ERROR_INFO_DEFAULT
    );

  -- Transaction info group
  type t_transaction_group is record
    bt : t_transaction;
    ct : t_transaction;
  end record;

  constant C_TRANSACTION_GROUP_DEFAULT : t_transaction_group := (
    bt => C_TRANSACTION_SET_DEFAULT,
    ct => C_TRANSACTION_SET_DEFAULT
    );


  -- Transaction groups array
  type t_uart_transaction_group_array is array (t_channel range <>, natural range <>) of t_transaction_group;


  -- Global DTT signals
  signal global_uart_transaction : t_uart_transaction_group_array(t_channel'left to t_channel'right, 0 to C_MAX_VVC_INSTANCE_NUM) :=
                                          (others => (others => C_TRANSACTION_GROUP_DEFAULT));

  signal global_uart_monitor_transaction : t_uart_transaction_group_array(t_channel'left to t_channel'right, 0 to C_MAX_VVC_INSTANCE_NUM) :=
                                          (others => (others => C_TRANSACTION_GROUP_DEFAULT));


  alias t_uart_operation   is t_operation;
  alias t_uart_transaction is t_transaction;
  alias C_UART_TRANSACTION_INFO_SET_DEFAULT is C_TRANSACTION_SET_DEFAULT;

end package transaction_pkg;
