library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Controladora is
end tb_Controladora;

architecture behavior of tb_Controladora is

    component Controladora
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            I         : in  STD_LOGIC;
            refri     : in  STD_LOGIC;
            btn_qtd   : in  STD_LOGIC;
            dinheiro  : in  STD_LOGIC;

            inc_q     : out STD_LOGIC;
            coin      : out STD_LOGIC;
            venda     : out STD_LOGIC;
            sel       : out STD_LOGIC;
            ld_lucro  : out STD_LOGIC;
            ld_p      : out STD_LOGIC
        );
    end component;

    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal I         : STD_LOGIC := '0';
    signal refri     : STD_LOGIC := '0';
    signal btn_qtd   : STD_LOGIC := '0';
    signal dinheiro  : STD_LOGIC := '0';

    signal inc_q     : STD_LOGIC;
    signal coin      : STD_LOGIC;
    signal venda     : STD_LOGIC;
    signal sel       : STD_LOGIC;
    signal ld_lucro  : STD_LOGIC;
    signal ld_p      : STD_LOGIC;

    constant clk_period : time := 10 ns;

begin

    -- Instância da Controladora
    uut: Controladora
        port map (
            clk       => clk,
            reset     => reset,
            I         => I,
            refri     => refri,
            btn_qtd   => btn_qtd,
            dinheiro  => dinheiro,
            inc_q     => inc_q,
            coin      => coin,
            venda     => venda,
            sel       => sel,
            ld_lucro  => ld_lucro,
            ld_p      => ld_p
        );

    -- Clock 10ns
    clk_process : process
    begin
        while now < 400 ns loop
            clk <= '0'; wait for clk_period / 2;
            clk <= '1'; wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Estímulo
    stim_proc: process
    begin
        -- Reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 10 ns;

        -- Mantém I = '1' durante toda a simulação (copo presente)
        I <= '1';

        -- Seleciona 2x quantidade
        btn_qtd <= '1'; wait for 10 ns; btn_qtd <= '0'; wait for 10 ns;
        btn_qtd <= '1'; wait for 10 ns; btn_qtd <= '0'; wait for 10 ns;

        -- Seleciona refri (Coca = 1)
        refri <= '1'; wait for 20 ns;

        -- Insere dinheiro
        dinheiro <= '1'; wait for 10 ns;
        dinheiro <= '0';

        -- Tempo para FSM passar por RegistraCompra → LiberaVenda
        wait for 80 ns;

        -- Report dos sinais de controle
        report "FSM - inc_q     = " & STD_LOGIC'image(inc_q);
        report "FSM - coin      = " & STD_LOGIC'image(coin);
        report "FSM - ld_p      = " & STD_LOGIC'image(ld_p);
        report "FSM - venda     = " & STD_LOGIC'image(venda);
        report "FSM - ld_lucro  = " & STD_LOGIC'image(ld_lucro);
        report "FSM - sel       = " & STD_LOGIC'image(sel);

        wait;
    end process;

end behavior;
