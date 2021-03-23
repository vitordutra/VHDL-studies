library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
  port (
    load_data    :   in std_logic_vector(3 downto 0);
    load_enablen   :   in std_logic; -- loadn ativo nivel baixo -> load_enable
    clock     :   in std_logic; -- clock ativo na borda de subida
    clearn    :   in std_logic; -- clear ativo BAIXO
    enable      :   in std_logic; -- enable ativo nivel BAIXO
    sec_ones:   out std_logic_vector(3 downto 0);
    sec_tens:   out std_logic_vector(3 downto 0);
    mins:   out std_logic_vector(3 downto 0);
    zero    :   out std_logic -- zero = 1 se count = 0
  );
end;

architecture main of timer is
  component countermod10 is
    port (
      data    :   in std_logic_vector(3 downto 0);
      loadn   :   in std_logic;
      clk     :   in std_logic;
      clrn    :   in std_logic;
      en      :   in std_logic;
      ones    :   out std_logic_vector(3 downto 0);
      tc      :   out std_logic;
      zero    :   out std_logic
    );
  end component;

  component countermod6 is
    port (
      data    :   in std_logic_vector(3 downto 0);
      loadn   :   in std_logic;
      clk     :   in std_logic;
      clrn    :   in std_logic;
      en      :   in std_logic;
      tens    :   out std_logic_vector(3 downto 0);
      tc      :   out std_logic;
      zero    :   out std_logic
    );
  end component;

  -- Sinais intermedi�rios (an�logos a fios)
  signal fiotc1, fiotc2 : std_logic;
  signal fiozero1, fiozero2, fiozero3 : std_logic;
  signal fio_ones : std_logic_vector(3 downto 0);
  signal fio_tens : std_logic_vector(3 downto 0);

begin
  mod10:countermod10
    port map(
      -- porta componente => porta entidade
      -- Entradas
      clk => clock,
      data => load_data,
      loadn => load_enablen,
      en => enable,
		  clrn => clearn,
      -- Saidas
		  ones => fio_ones,
      tc => fiotc1,
      zero => fiozero1
    );

	 sec_ones <= fio_ones;

  mod6:countermod6
    port map(
      -- porta componente => porta entidade
      -- Entradas
      clk => clock,
      data => fio_ones,
      loadn => load_enablen,
      en => fiotc1,
		  clrn => clearn,
      -- Saidas
      tens => fio_tens,
      tc => fiotc2,
      zero => fiozero2
    );

    sec_tens <= fio_tens;

    minutes:countermod10
    port map(
      -- porta componente => porta entidade
      -- Entradas
      clk => clock,
      data => fio_tens,
      loadn => load_enablen,
      en => fiotc2,
		  clrn => clearn,
      -- Saidas
		  ones => mins,
      tc => open,
      zero => fiozero3
    );

    zero <= fiozero1 and fiozero2 and fiozero3;

end main;
