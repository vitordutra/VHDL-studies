-- Curso de VHDL #17
-- Full Adder em VHDL
-- Autor: Joao Vitor D. P. Gois
-- Data: 26/11/2020

library ieee;
use ieee.std_logic_1164.all;

entity counter is
  port (
    clk, rst  : in std_logic;
    q         : out std_logic_vector(3 downto 0)
  );
end counter;

architecture top of counter is

  -- std_logic_vector(3 downto 0) significa que eh um vetor de 3 bits
  signal x, q_temp : std_logic_vector(3 downto 0);

begin

  q <= q_temp;
  -- Chamada direta de componente -> Label: entity work.nome_do_componente(nome_arquitetura)
  -- Somador
  U1: entity work.carry_ripple_4bit_adder(main)
    port map (
      A         => q_temp,
      B         => X"1", -- ou x"1 -> hexadecimal de 4 bits
      CARRY_IN  => '0', -- aspas simples por ser std_logic
      S         => x,
      CARRY_OUT => open -- sinal aberto, sem estar conectado com nada
    );

  U2: entity work.reg (behavioral)
  generic map (4) -- Generic map posicional para registrador de 4 bits
  port map (
    clk   => clk,
    rst   => rst,
    data  => x,
    q     => q_temp
  );

end architecture;
