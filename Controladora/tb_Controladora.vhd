library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Controladora is
end tb_Controladora;

architecture behavior of tb_Controladora is

    -- Componente a ser testado
    component Controladora
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            I        : in  STD_LOGIC;
            refri    : in  STD_LOGIC;
            btn_qtd  : in  STD_LOGIC;
            dinheiro : in  STD_LOGIC;

            inc_q    : out STD_LOGIC;
            coin     : out STD_LOGIC;
            venda    : out STD_LOGIC;
            sel      : out STD_LOGIC
        );
    end component;

    -- Sinais
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal I        : STD_LOGIC := '0';
    signal refri    : STD_LOGIC := '0';
    signal btn_qtd  : STD_LOGIC := '0';
    signal dinheiro : STD_LOGIC := '0';

    signal inc_q    : STD_LOGIC;
    signal coin     : STD_LOGIC;
    signal venda    : STD_LOGIC;
    signal sel      : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin

    -- Instanciação do componente
    uut: Controladora
        port map (
            clk      => clk,
            reset    => reset,
            I        => I,
            refri    => refri,
            btn_qtd  => btn_qtd,
            dinheiro => dinheiro,
            inc_q    => inc_q,
            coin     => coin,
            venda    => venda,
            sel      => sel
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

    -- Processo de estímulo
    stim_proc: process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 10 ns;

        -- Etapa 1: inserção do copo
        I <= '1'; wait for 10 ns;

        -- Etapa 2: seleção da quantidade
        btn_qtd <= '1'; wait for 10 ns;
        btn_qtd <= '0'; wait for 10 ns;

        -- Etapa 3: seleção do refrigerante (0 = Guaraná, 1 = Coca)
        refri <= '1'; wait for 10 ns;

        -- Etapa 4: inserção do dinheiro
        dinheiro <= '1'; wait for 10 ns;
        dinheiro <= '0'; wait for 10 ns;

        -- Espera para retorno ao estado inicial
        wait for 20 ns;

        wait;
    end process;

end behavior;
