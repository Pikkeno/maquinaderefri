library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_L_count is
end tb_L_count;

architecture behavior of tb_L_count is

    -- Componente a ser testado
    component L_count
        Port (
            clk    : in  STD_LOGIC;
            reset  : in  STD_LOGIC;
            enable : in  STD_LOGIC;
            valor  : in  STD_LOGIC_VECTOR(6 downto 0);
            total  : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component;

    -- Sinais de estímulo
    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal enable : STD_LOGIC := '0';
    signal valor  : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal total  : STD_LOGIC_VECTOR(8 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instanciação da unidade sob teste
    uut: L_count
        port map (
            clk    => clk,
            reset  => reset,
            enable => enable,
            valor  => valor,
            total  => total
        );

    -- Processo de clock
    clk_process : process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Estímulo de teste
    stim_proc: process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Primeiro valor (5)
        valor <= "0000101";  -- 5
        enable <= '1';
        wait for 10 ns;
        enable <= '0';
        wait for 10 ns;

        -- Segundo valor (10)
        valor <= "0001010";  -- 10
        enable <= '1';
        wait for 10 ns;
        enable <= '0';
        wait for 10 ns;

        -- Terceiro valor (15)
        valor <= "0001111";  -- 15
        enable <= '1';
        wait for 10 ns;
        enable <= '0';
        wait for 10 ns;

        -- Reset e novo valor
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        valor <= "0000011";  -- 3
        enable <= '1';
        wait for 10 ns;
        enable <= '0';

        wait;
    end process;

end behavior;
