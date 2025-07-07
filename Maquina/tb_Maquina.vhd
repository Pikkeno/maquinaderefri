library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Maquina is
end tb_Maquina;

architecture behavior of tb_Maquina is

    -- Componente a ser testado
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

    -- Sinais
    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal I        : STD_LOGIC := '0';
    signal preco1   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- R$3,00 por 300 mL (Coca)
    signal preco2   : STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- R$2,00 por 300 mL (Guaraná)
    signal refri    : STD_LOGIC := '0'; -- sem seleção inicial
    signal btn_qtd  : STD_LOGIC := '0';
    signal dinheiro : STD_LOGIC := '0';
    signal valor    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal troco    : STD_LOGIC_VECTOR(8 downto 0);
    signal lucro    : STD_LOGIC_VECTOR(8 downto 0);

    constant clk_period : time := 10 ns;

begin

    -- Instanciação da UUT
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

    -- Clock process
    clk_process : process
    begin
        while now < 500 ns loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
        wait;
    end process;

    -- Estímulo principal
    stim_proc: process
    begin
        -- Inicialização
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Inserção do copo (ativa o sensor I)
        I <= '1';
        wait for 20 ns;

        -- Seleciona quantidade (2x incrementa => 600 mL)
        btn_qtd <= '1'; wait for 10 ns;
        btn_qtd <= '0'; wait for 10 ns;
        btn_qtd <= '1'; wait for 10 ns;
        btn_qtd <= '0'; wait for 10 ns;

        -- Seleciona refrigerante Coca-Cola
        refri <= '1'; wait for 10 ns;

        -- Insere nota de R$10
        valor <= "01010";
        dinheiro <= '1'; wait for 10 ns;
        dinheiro <= '0'; wait for 10 ns;

        -- Aguarda processamento da venda e troco
        wait for 100 ns;

        -- Próxima compra: Guaraná, 900 mL, insere R$10
        I <= '0'; wait for 20 ns;
        I <= '1'; wait for 20 ns;

        btn_qtd <= '1'; wait for 10 ns;
        btn_qtd <= '0'; wait for 10 ns;
        btn_qtd <= '1'; wait for 10 ns;
        btn_qtd <= '0'; wait for 10 ns;
        btn_qtd <= '1'; wait for 10 ns;
        btn_qtd <= '0'; wait for 10 ns;

        -- Seleciona refrigerante Guaraná
        refri <= '0'; wait for 10 ns;

        valor <= "01010";
        dinheiro <= '1'; wait for 10 ns;
        dinheiro <= '0'; wait for 10 ns;

        -- Espera final
        wait;

    end process;

end behavior;
