-- Elementos de Sistemas
-- developed by Luciano Soares
-- 1 tb_Q2_ControlUnit.vhd
-- date: 4/4/2017

Library ieee;
use ieee.std_logic_1164.all;

library vunit_lib;
context vunit_lib.vunit_context;

entity tb_Q2_ControlUnit is
  generic (runner_cfg : string);
end entity;

architecture tb of tb_Q2_ControlUnit is

  component Q2_ControlUnit is
      port(
        instruction                 : in STD_LOGIC_VECTOR(17 downto 0);  -- instrução para executar
        zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e ng(se negativo) da ALU
        muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre instrução e ALU para reg. A
        muxAM                       : out STD_LOGIC;                     -- mux que seleciona entre reg. A e Mem. RAM para ALU
        zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
        loadA, loadD, loadM, loadPC : out STD_LOGIC                      -- sinais de load do reg. A, reg. D, Mem. RAM e Program Counter
        );
  end component;

	signal clk : std_logic := '0';
  signal instruction                 : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
  signal zr,ng                       : STD_LOGIC := '0';
  signal muxAM                   : STD_LOGIC := '0';
  signal muxALUI_A                   : STD_LOGIC := '0';
  signal zx, nx, zy, ny, f, no       : STD_LOGIC := '0';
  signal loadA, loadD,  loadM, loadPC : STD_LOGIC := '0';

begin

	uCU: Q2_ControlUnit port map(instruction, zr, ng, muxALUI_A, muxAM, zx, nx, zy, ny, f, no, loadA, loadD, loadM, loadPC);

	clk <= not clk after 100 ps;

  main : process
    begin
      test_runner_setup(runner, runner_cfg);

    -----------------------------------------------
    -- Simulado
      ----------------------------------------------

    instruction <= "10" & "000" & "000010" & "0001" & "001";
    zr <= '0';  ng <= '0';
    wait until clk = '1';
    assert(loadPC  = '1')
      report "falha teste 1" severity error;

    instruction <= "11" & "000" & "000010" & "0001" & "001";
    zr <= '0';  ng <= '1';
    wait until clk = '1';
    assert(loadPC  = '0')
      report "falha teste 2" severity error;

    instruction <= "11" & "000" & "000010" & "0001" & "001";
    zr <= '0';  ng <= '0';
    wait until clk = '1';
    assert(loadPC  = '1')
      report "falha teste 3" severity error;

    instruction <= "11" & "000" & "000010" & "0001" & "001";
    zr <= '1';  ng <= '0';
    wait until clk = '1';
    assert(loadPC  = '0')
      report "falha teste 4" severity error;

    instruction <= "00" & "000" & "000010" & "0001" & "001";
    zr <= '0';  ng <= '0';
    wait until clk = '1';
    assert(loadPC  = '0')
      report "falha teste leaw" severity error;

    test_runner_cleanup(runner); -- Simulation ends here

	wait;
  end process;
end architecture;
