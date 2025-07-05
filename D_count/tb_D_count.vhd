library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_D_count is
end tb_D_count;

architecture behavior of tb_D_count is

    -- Componente a ser testado
    component D_count
        Port (
            clk   : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            coin  : in  STD_LOGIC;
            valor : in  STD_LOGIC_VECTOR(4 downto 0);
            D     : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component;

    -- Sinais
    signal clk   : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal coin  : STD_LOGIC := '0';
    signal valor : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal D     : STD_LOGIC_VECTOR(8 downto 0);

    -- Clock de 10 ns (100 MHz)
    constant clk_period : time := 10 ns;

begin

    -- Instanciação da unidade sob teste
    uut: D_count
        port map (
            clk   => clk,
            reset => reset,
            coin  => coin,
            valor => valor,
            D     => D
        );

    -- Geração do clock
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
        wait for 10 ns;

        -- Inserindo dinheiro
        valor <= "00001"; -- 1 real
        coin  <= '1';
        wait for 10 ns;
        coin  <= '0';
        wait for 10 ns;

        valor <= "00010"; -- 2 reais
        coin  <= '1';
        wait for 10 ns;
        coin  <= '0';
        wait for 10 ns;

        valor <= "00101"; -- 5 reais
        coin  <= '1';
        wait for 10 ns;
        coin  <= '0';
        wait for 10 ns;

        -- Inserir nota de 10
        valor <= "01010"; -- 10 reais
        coin  <= '1';
        wait for 10 ns;
        coin  <= '0';
        wait for 10 ns;

        -- Inserir nota de 20
        valor <= "10100"; -- 20 reais
        coin  <= '1';
        wait for 10 ns;
        coin  <= '0';

        -- Espera sem inserção
        wait for 20 ns;

        -- Reset novamente
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        wait;
    end process;

end behavior;
