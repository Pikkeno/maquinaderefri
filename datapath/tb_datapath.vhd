library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Datapath is
end tb_Datapath;

architecture behavior of tb_Datapath is

    -- Componente a ser testado
    component Datapath
        Port (
            clk     : in  STD_LOGIC;
            reset   : in  STD_LOGIC;
            coin    : in  STD_LOGIC;
            valor   : in  STD_LOGIC_VECTOR(4 downto 0);
            sel     : in  STD_LOGIC;
            preco1  : in  STD_LOGIC_VECTOR(3 downto 0);
            preco2  : in  STD_LOGIC_VECTOR(3 downto 0);
            inc_q   : in  STD_LOGIC;
            venda   : in  STD_LOGIC;
            troco   : out STD_LOGIC_VECTOR(8 downto 0);
            lucro   : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component;

    -- Sinais
    signal clk     : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '0';
    signal coin    : STD_LOGIC := '0';
    signal valor   : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal sel     : STD_LOGIC := '0'; -- Guaraná inicialmente
    signal preco1  : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- R$3,00
    signal preco2  : STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- R$2,00
    signal inc_q   : STD_LOGIC := '0';
    signal venda   : STD_LOGIC := '0';
    signal troco   : STD_LOGIC_VECTOR(8 downto 0);
    signal lucro   : STD_LOGIC_VECTOR(8 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instância da unidade sob teste
    uut: Datapath
        port map (
            clk     => clk,
            reset   => reset,
            coin    => coin,
            valor   => valor,
            sel     => sel,
            preco1  => preco1,
            preco2  => preco2,
            inc_q   => inc_q,
            venda   => venda,
            troco   => troco,
            lucro   => lucro
        );

    -- Geração do clock
    clk_process : process
    begin
        while now < 300 ns loop
            clk <= '0'; wait for clk_period / 2;
            clk <= '1'; wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Estímulo
    stim_proc: process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 10 ns;

        -- Incrementa quantidade: 2 vezes (600 mL)
        inc_q <= '1'; wait for 10 ns;
        inc_q <= '0'; wait for 10 ns;
        inc_q <= '1'; wait for 10 ns;
        inc_q <= '0'; wait for 10 ns;

        -- Seleciona Coca-Cola (sel = '1')
        sel <= '1';

        -- Insere notas variadas
        valor <= "00001"; coin <= '1'; wait for 10 ns; coin <= '0'; wait for 10 ns;
        valor <= "00010"; coin <= '1'; wait for 10 ns; coin <= '0'; wait for 10 ns;
        valor <= "00101"; coin <= '1'; wait for 10 ns; coin <= '0'; wait for 10 ns;
        valor <= "01010"; coin <= '1'; wait for 10 ns; coin <= '0'; wait for 10 ns;

        -- Finaliza venda
        venda <= '1';
        wait for 10 ns;
        venda <= '0';

        -- Espera resultado
        wait for 50 ns;

        wait;
    end process;

end behavior;
