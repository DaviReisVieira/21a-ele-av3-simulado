-- Elementos de Sistemas
-- developed by Luciano Soares
-- 1 tb_q1_CPU.vhd
-- date: 4/4/2017

Library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_q1_CPU is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_q1_CPU is

  component Q1_CPU is port(
      clock:       in  STD_LOGIC;
      Reset:       in  STD_LOGIC;
      inM:         in  STD_LOGIC_VECTOR(15 downto 0);
      instruction: in  STD_LOGIC_VECTOR(17 downto 0);
      outM:        out STD_LOGIC_VECTOR(15 downto 0);
      writeM:      out STD_LOGIC;
      addressM:    out STD_LOGIC_VECTOR(14 downto 0);
      pcout:       out STD_LOGIC_VECTOR(14 downto 0)
      );
    end component;

  signal clk:         STD_LOGIC := '0';
  signal Reset:       STD_LOGIC := '0';
  signal inM:         STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
  signal instruction: STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
  signal outM:        STD_LOGIC_VECTOR(15 downto 0);
  signal writeM:      STD_LOGIC;
  signal addressM:    STD_LOGIC_VECTOR(14 downto 0);
  signal pcout:       STD_LOGIC_VECTOR(14 downto 0);

begin

	ucpu: Q1_CPU port map(clk, reset, inM, instruction, outM, writeM, addressM, pcout);

	clk <= not clk after 100 ps;

  main : process
    begin
      test_runner_setup(runner, runner_cfg);

    -----------------------------------------------
    -- Simulado
      ----------------------------------------------
      reset <= '1'; wait for 200 ps; reset <= '0';

      -- leaw 2
      instruction <= "00" & "000" & "000000" & "0000" & "010";
      wait until clk = '1';
      wait for 20 ps;

      -- movw %a, %d
      instruction <= "1" & "000" & '0' & "110000" & "0010" & "000";
      wait until clk = '1';
      wait for 20 ps;

      -- leaw 0
      instruction <= "00" & "000" & "000000" & "0000" & "000";
      wait until clk = '1';
      wait for 20 ps;

      -- add %d, %d, %a
      instruction <= "10" & "01" & '0' & "000010" & "0001" & "000";
      wait until clk = '1';
      wait for 20 ps;

    assert(outM = x"0004")
    report " **Falha** Teste 1" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;
