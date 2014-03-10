--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:32:12 03/10/2014
-- Design Name:   
-- Module Name:   C:/Users/C16Ian.Goodbody/Documents/Classes/ECE281/CE3_Goodbody/Moore_testbench_Goodbody.vhd
-- Project Name:  CE3_Goodbody
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MooreElevatorController
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
 
ENTITY Moore_testbench_Goodbody IS
END Moore_testbench_Goodbody;
 
ARCHITECTURE behavior OF Moore_testbench_Goodbody IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MooreElevatorController
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         stop : IN  std_logic;
         up_down : IN  std_logic;
         floor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal stop : std_logic := '0';
   signal up_down : std_logic := '0';

 	--Outputs
   signal floor : std_logic_vector(3 downto 0);

   -- Clock period definitions 
   constant clk_period : time := 10 ns;
	-- In case I forget, 100 MHz frequency, a 20 ns clock should yield a 50 MHz Frequency 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MooreElevatorController PORT MAP (
          clk => clk,
          reset => reset,
          stop => stop,
          up_down => up_down,
          floor => floor
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

		--Reset the system, place it at floor1
      reset <= '1'; 
		wait for clk_period*5;
		--Wait five clock cycles then turn off reset signal and set initial inputs so the elevator is moving up but is stopped
		stop <= '1';
		up_down <= '1';
      reset <= '0'; 
		wait for clk_period*5;
		--Start testing at 200 ns;
		--Turn off stop signal
		stop <= '0';
		--Wait for a cycle then turn stop on
		wait for clk_period*1;
		stop <= '1';
		--keep stopped on for two clock cycles;
		wait for clk_period*2;
		assert floor = "0010" report "F 1 to 2 failed" severity error;
		
		--Repeat above process two more times to go to floor 3 then floor 4;
		
		--Turn off stop signal
		stop <= '0';
		--Wait for a cycle then turn stop on
		wait for clk_period*1;
		stop <= '1';
		--keep stopped on for two clock cycles;
		wait for clk_period*2;
		assert floor = "0011" report "F 2 to 3 failed" severity error;
		--Turn off stop signal
		stop <= '0';
		--Wait for a cycle then turn stop on
		wait for clk_period*1;
		stop <= '1';
		--keep stopped on for two clock cycles;
		wait for clk_period*2;
		assert floor = "0100" report "F 3 to 4 failed" severity error;
		
		--Return to floor 4 without stopping, requires 3 "jumps"/clock cycles
		up_down <= '0'; --Go down
		stop <= '0';
		wait for clk_period*3;
		assert floor = "0001" report "F 4 to 1 failed" severity error;
		--Stop the elevator, it shouldn't make a differene with the state machine but my OCD feels better
		stop <= '1';
		

      wait;
   end process;

END;
