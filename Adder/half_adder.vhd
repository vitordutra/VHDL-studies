-- Curso de VHDL #17
-- Half-Adder em VHDL
-- Autor: Jo�o Vitor D. P. Gois
-- Data: 26/11/2020

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
  port (
    A, B  : in  std_logic;
    SUM   : out std_logic;
    CARRY : out std_logic
  );
end entity;

architecture data_flow of half_adder is
begin
  SUM   <= A XOR B;
  CARRY <= A AND B;

end architecture;
