library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entidade vazia do testbench
entity timer_abstraido_tb is
end entity;

architecture sim of timer_abstraido_tb is
    constant ClockFrequenciaHz : integer := 10; -- 10 Hz
    constant ClockPeriodo      : time := 1000 ms / ClockFrequenciaHz;

    -- Sinais para o teste
    signal Clk       : std_logic := '1';
    signal Resetn    : std_logic := '0';
    signal Segundos  : integer;
    signal Minutos   : integer;

begin
    -- chamada direta do componente que será simulado no ModelSim
    i_Timer : entity work.timer_abstraido(rtl)
    -- mapeia-se o generic do arquivo principal para o testbench
    generic map(ClockFrequenciaHz => ClockFrequenciaHz)
    port map (
        Clk         => Clk,
        Resetn      => Resetn,
        Segundos    => Segundos,
        Minutos     => Minutos);

    -- Processo para gerar o Clock
    Clk <= not Clk after ClockPeriodo / 2;

    -- Sequencia do testbench
    process is
    begin
        -- Espera-se até a borda de subida do clock
        wait until rising_edge(Clk);
        wait until rising_edge(Clk);
        -- Então o timer é resetado
        Resetn <= '1';
        -- Por fim o wait indica que a contagem será feita ate o final da simulacao
        wait;
    end process;

end architecture;
