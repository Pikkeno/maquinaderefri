library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Maquina is
end tb_Maquina;

architecture behavior of tb_Maquina is

    component Maquina
        Port (
            clk      : in  STD_LOGIC;
            reset    : in  STD_LOGIC;
            I        : in  STD_LOGIC;
            preco1   : in  STD_LOGIC_VECTOR(3 downto 0);
            preco2   : in  STD_LOGIC_VECTOR(3 downto 0);
            refri    : in  STD_LOGIC;
            btn_qtd  : in  STD_LOGIC;
            dinheiro : in  STD_LOGIC;
            valor    : in  STD_LOGIC_VECTOR(4 downto 0);
            troco    : out STD_LOGIC_VECTOR(8 downto 0);
            lucro    : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component;

    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal I        : STD_LOGIC := '0';
    signal preco1   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal preco2   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal refri    : STD_LOGIC := '0';
    signal btn_qtd  : STD_LOGIC := '0';
    signal dinheiro : STD_LOGIC := '0';
    signal valor    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal troco    : STD_LOGIC_VECTOR(8 downto 0);
    signal lucro    : STD_LOGIC_VECTOR(8 downto 0);

begin

    -- Clock 10ns período
    clk_process : process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;

    -- Instância da Máquina
    uut: Maquina
        port map (
            clk      => clk,
            reset    => reset,
            I        => I,
            preco1   => preco1,
            preco2   => preco2,
            refri    => refri,
            btn_qtd  => btn_qtd,
            dinheiro => dinheiro,
            valor    => valor,
            troco    => troco,
            lucro    => lucro
        );

    stim_proc: process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 10 ns;

        -- Define preços
        preco1 <= "0101"; -- Guaraná = 5
        preco2 <= "1001"; -- Coca = 9

        -- Inserir copo
        I <= '1';
        wait for 40 ns;

        -- Seleciona 1 unidade
        btn_qtd <= '1';
        wait for 10 ns;
        btn_qtd <= '0';
        wait for 20 ns;

        -- Seleciona Guaraná
        refri <= '0';
        wait for 20 ns;

        -- Insere dinheiro (5)
        dinheiro <= '1';
        valor <= "00101"; -- 5
        wait for 10 ns;
        dinheiro <= '0';
        wait for 100 ns;

        -- Verificação
        report "TROCO: " & integer'image(to_integer(unsigned(troco)));
        report "LUCRO: " & integer'image(to_integer(unsigned(lucro)));

        assert unsigned(lucro) = 5
            report "ERRO: lucro deveria ser 5 após a venda!" severity error;

        assert unsigned(troco) = 0
            report "ERRO: troco deveria ser 0!" severity error;

        wait;
    end process;

end behavior;
