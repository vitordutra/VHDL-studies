library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity countermod6 is
  port (
    data    :   in std_logic_vector(3 downto 0);
    loadn   :   in std_logic; -- loadn ativo nivel baixo -> load_enable
    clk     :   in std_logic; -- clock ativo na borda de subida
    clrn    :   in std_logic; -- clear ativo BAIXO
    en      :   in std_logic; -- enable ativo nivel BAIXO
    tens:   out std_logic_vector(3 downto 0);
    tc      :   out std_logic; -- tc = 1 se count = 0 e enable = 1
    zero    :   out std_logic -- zero = 1 se count = 0
  );
end;

architecture rtl of countermod6 is
    signal count: unsigned(3 downto 0);
begin
    process (clk, clrn) begin
        if clrn = '0' then
            count <= (others => '0'); -- clear assincrono, ativo nivel baixo
        elsif rising_edge(clk) then
            if en = '1' then  -- Se enable = 0, o contador nao conta. Se enable = 1 o contador conta.
                if loadn = '0' then -- se loadn ativo o dado eh carregado dentro de count
                    count <= unsigned(data);
                else
                    if count = 0 then
                    count <= to_unsigned(5, count'length); -- truncagem do contador de 4 bits para mod-10
                    else
                        count <= count - 1;
                    end if;
                end if;
            end if;
        end if;

        -- funcao do tc eh ativar o enable do proximo modulo contador para ele comecar a contar
        if (count = 0) and (en = '1') then
            tc <= '1'; -- tc = 1 se a contagem acabar e enable = 1
        else
            tc <= '0'; -- senao tc = 0
        end if;

        if count = 0 then
            zero <= '1';
        else
            zero <= '0';
        end if;

        tens <= std_logic_vector(count); -- atualizacao da saida
    end process;
end;
