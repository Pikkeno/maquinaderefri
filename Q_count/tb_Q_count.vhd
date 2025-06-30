library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Q_count is
end tb_Q_count;

architecture behavior of tb_Q_count is

    -- Componente a ser testado
    component Q_count
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            increment : in  STD_LOGIC;
            Q         : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    -- Sinais
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal increment : STD_LOGIC := '0';
    signal Q         : STD_LOGIC_VECTOR(1 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instanciação do componente
    uut: Q_count
        port map (
            clk       => clk,
            reset     => reset,
            increment => increment,
            Q         => Q
        );

    -- Processo de clock
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0'; wait for clk_period / 2;
            clk <= '1'; wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Processo de estímulo
    stim_proc: process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 10 ns;

        -- Incrementa 3 vezes (deverá ir para 11)
        increment <= '1';
        wait for 10 ns;
        increment <= '0';
        wait for 10 ns;

        increment <= '1';
        wait for 10 ns;
        increment <= '0';
        wait for 10 ns;

        increment <= '1';
        wait for 10 ns;
        increment <= '0';
        wait for 10 ns;

        -- Reset após atingir o máximo
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        -- Incrementa mais uma vez (deverá ir para 01)
        increment <= '1';
        wait for 10 ns;
        increment <= '0';

        wait;
    end process;

end behavior;
