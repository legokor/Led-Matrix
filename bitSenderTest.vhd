--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:05:09 04/08/2024
-- Design Name:   
-- Module Name:   C:/codes/ledmatrix_vhdl/bitSenderTest.vhd
-- Project Name:  ledmatrix_vhdl
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bitSender
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY bitSenderTest IS
END bitSenderTest;
 
ARCHITECTURE behavior OF bitSenderTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bitSender
    PORT(
         clk : IN  std_logic;
         en : IN  std_logic;
         reset : IN  std_logic;
         wr : IN  std_logic;
         input : IN  std_logic;
         rdyOut : OUT  std_logic;
         output : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en : std_logic := '0';
   signal reset : std_logic := '0';
   signal wr : std_logic := '0';
   signal input : std_logic := '0';

 	--Outputs
   signal rdyOut : std_logic;
   signal output : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bitSender PORT MAP (
          clk => clk,
          en => en,
          reset => reset,
          wr => wr,
          input => input,
          rdyOut => rdyOut,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		en <= '1';
		wr <= '1';
		input <= '1';
		wait for clk_period*80;
		input <= '0';
		
      wait;
   end process;

END;
