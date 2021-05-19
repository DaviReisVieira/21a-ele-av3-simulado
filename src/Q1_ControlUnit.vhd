-- Elementos de Sistemas
-- developed by Luciano Soares
-- file: Q1_ControlUnit.vhd
-- date: 4/4/2017
-- Modificação:
--   - Rafael Corsi : nova versão: adicionado reg S
--
-- Unidade que controla os componentes da CPU

library ieee;
use ieee.std_logic_1164.all;

entity Q1_ControlUnit is
    port(
		instruction                 : in STD_LOGIC_VECTOR(17 downto 0);  -- instrução para executar
		zr,ng                       : in STD_LOGIC;                      -- valores zr(se zero) e
                                                                     -- ng (se negativo) da ALU
		muxALUI_A                   : out STD_LOGIC;                     -- mux que seleciona entre
                                                                     -- instrução  e ALU para reg. A
		muxAM                       : out STD_LOGIC;                     -- mux que seleciona entre
                                                                     -- reg. A e Mem. RAM para ALU
    muxY                        : out std_logic;                     -- NOVO
                                                                     -- A  e Mem. RAM para ALU
		zx, nx, zy, ny, f, no       : out STD_LOGIC;                     -- sinais de controle da ALU
		loadA, loadD, loadM, loadPC : out STD_LOGIC               -- sinais de load do reg. A,
                                                                     -- reg. D, Mem. RAM e Program Counter
    );
end entity;

architecture arch of Q1_ControlUnit is


  signal r0,r1,r2 : std_logic := '0';
  signal d0,d1,d2,d3 : std_logic := '0';
  signal cType    : std_logic := '0';


begin

  --=================================--
  -- implementar somente o sinal muxY
  --=================================--

  --muxY <= ????????????;

  --=================================--
  -- ja esta pronto, nao precisa mexer!
  --=================================--
  cType <= instruction(17);
  r0    <= instruction(13);
  r1    <= instruction(14);
  r2    <= instruction(15);

  d0    <= instruction(3);
  d1    <= instruction(4);
  d2    <= instruction(5);
  d3    <= instruction(6);

  -- REG & MEM
  loadA   <= (not cType);-- or (d0 and cType);
  LoadM   <= d2 and cType;
  loadD   <= d1 and cType;
  loadPC  <= ((instruction(0) and ((not ng) and (not zr))) or (instruction(1) and zr) or (instruction(2) and ng)) and cType;

  -- MUX
  muxALUI_A   <= not cType;
  muxAM       <= r0;

  -- ALU
  zx <= instruction(12);
  nx <= instruction(11);
  zy <= instruction(10);
  ny <= instruction(9);
  f  <= instruction(8);
  no <= instruction(7);

end architecture;
