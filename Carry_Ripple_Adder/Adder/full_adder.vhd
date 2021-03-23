-- Curso de VHDL #17
-- Full Adder em VHDL
-- Autor: Jo�o Vitor D. P. Gois
-- Data: 26/11/2020

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (
    A, B     : in std_logic;
    CARRY_IN : in std_logic;
    SUM      : out std_logic;
    CARRY    : out std_logic
  );
end entity;

architecture rtl of full_adder is

  -- Declara��o do componente half_adder
  component half_adder is
  port (
    A, B  : in std_logic;
    SUM   : out std_logic;
    CARRY : out std_logic
  );
  end component half_adder;

  -- Sinais Internos
  signal x, y, z : std_logic;

begin
  CARRY <= z or y;

  -- Instancia��o do componente (nominal):
  -- ha1: label do half_adder
  ha1: half_adder
    port map(
      -- A (meio somador) => A (somador completo)
      A     => A,
      B     => B,
      SUM   => x,
      CARRY => y
    );

    -- Instancia��o Posicional
    -- Atribui��o direta na ordem dos elementos do port
    -- Mesma coisa que a atribui��o de fun��es na linguagem C
    -- Ordem que aparece no port map: A, B, SUM, CARRY
    -- Ou seja, equivalente a: A => x, B => CARRY_IN, SUM => SUM, CARRY => Z
    ha2: half_adder
      port map(x, CARRY_IN, SUM, Z);

end architecture;
