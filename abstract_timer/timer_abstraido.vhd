library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer_abstraido is
-- um generic eh uma constante. No caso seta a frequencia do clock para 10 Hz
generic(ClockFrequenciaHz : integer := 10);
port (
    Clk         : in std_logic;
    Resetn      : in std_logic; -- Clear ativado no BAIXO
    Segundos    : inout integer;
    Minutos     : inout integer);
end entity;

architecture rtl of timer_abstraido is
    -- Sinal para contar os periodos do Clock
    signal Count : integer;
begin
    process(Clk) is
    begin
        if rising_edge(Clk) then
            -- O reset seta na ultima configuracao desejada pelo usuario
            if Resetn = '0' then
                Count   <= 0;
                Segundos <= 0;
                Minutos <= 5;
            elsif (Minutos /= 0) or (Segundos /= 0) then
                -- Verdadeiro a cada segundo contado
                if Count = ClockFrequenciaHz - 1 then
                    Count <= 0;
                    -- Verdadeiro a cada minuto contado
                    if Segundos = 0 then
                        Segundos <= 59;
                        if Minutos = 0 then
                            Minutos <= 59;
                        else
                            Minutos <= Minutos - 1;
                        end if;
                    else
                        Segundos <= Segundos - 1;
                    end if;
                else
                    Count <= Count + 1;
                end if;
            end if;
        end if;
    end process;
end architecture;
