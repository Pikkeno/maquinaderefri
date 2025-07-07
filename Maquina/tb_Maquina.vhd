library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Maquina is
end tb_Maquina;

architecture behavior of tb_Maquina is

    -- Componente sob teste
    component Maquina
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            I        : in  STD_LOGIC;
            preco1   : in  STD_LOGIC_VECTOR(3 downto 0);
            preco2   : in  STD_LOGIC_VECTOR(3 downto 0);
            refri    : in  STD_LOGIC;
            btn_qtd  : in  STD_LOGIC;
            ok_qtd   : in  STD_LOGIC;
            dinheiro : in  STD_LOGIC;
            valor    : in  STD_LOGIC_VECTOR(4 downto 0);
            troco    : out STD_LOGIC_VECTOR(8 downto 0);
            lucro    : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component;

    -- Sinais de teste
    signal clk, reset         : STD_LOGIC := '0';
    signal I, refri           : STD_LOGIC := '0';
    signal btn_qtd, ok_qtd    : STD_LOGIC := '0';
    signal dinheiro           : STD_LOGIC := '0';
    signal valor              : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal preco1, preco2     : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal troco, lucro       : STD_LOGIC_VECTOR(8 downto 0);

    -- Clock de 10 ns
    constant clk_period : time := 10 ns;

begin

    -- Instância da DUT
    uut: Maquina
        port map (
            clk      => clk,
            reset    => reset,
            I        => I,
            preco1   => preco1,
            preco2   => preco2,
            refri    => refri,
            btn_qtd  => btn_qtd,
            ok_qtd   => ok_qtd,
            dinheiro => dinheiro,
            valor    => valor,
            troco    => troco,
            lucro    => lucro
        );

    -- Geração do clock
    clk_process : process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Estímulos de teste
    stim_proc: process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- 1. Copo inserido
        I <= '1';
        wait for 20 ns;
        I <= '0';

        -- 2. Seleciona quantidade (duas unidades)
        btn_qtd <= '1';
        wait for 10 ns;
        btn_qtd <= '0';
        wait for 20 ns;

        btn_qtd <= '1';
        wait for 10 ns;
        btn_qtd <= '0';
        wait for 20 ns;

        -- 3. Confirma quantidade
        ok_qtd <= '1';
        wait for 10 ns;
        ok_qtd <= '0';

        -- 4. Seleciona refrigerante (refri = 1 → Coca → preco2)
        refri <= '1';
        preco1 <= "0100";  -- Guaraná: R$4
        preco2 <= "0011";  -- Coca:    R$3

        wait for 30 ns;

        -- 5. Inserção de dinheiro (R$10 = 01010)
        dinheiro <= '1';
        valor <= "01010";
        wait for 10 ns;
        dinheiro <= '0';

        -- Espera até final da venda
        wait for 200 ns;

        -- Fim da simulação
        wait;
    end process;

end behavior;
