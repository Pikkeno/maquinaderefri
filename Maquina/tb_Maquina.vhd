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
            ok_qtd   : in  STD_LOGIC;
            dinheiro : in  STD_LOGIC;
            valor    : in  STD_LOGIC_VECTOR(4 downto 0);
            troco    : out STD_LOGIC_VECTOR(8 downto 0);
            lucro    : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component;

    signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal I        : STD_LOGIC := '0';
    signal preco1   : STD_LOGIC_VECTOR(3 downto 0) := "0101"; -- 5
    signal preco2   : STD_LOGIC_VECTOR(3 downto 0) := "1001"; -- 9
    signal refri    : STD_LOGIC := '0';
    signal btn_qtd  : STD_LOGIC := '0';
    signal ok_qtd   : STD_LOGIC := '0';
    signal dinheiro : STD_LOGIC := '0';
    signal valor    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal troco    : STD_LOGIC_VECTOR(8 downto 0);
    signal lucro    : STD_LOGIC_VECTOR(8 downto 0);

    constant clk_period : time := 10 ns;

begin

    clk_process : process
    begin
        while now < 1000 ns loop
            clk <= '0'; wait for clk_period/2;
            clk <= '1'; wait for clk_period/2;
        end loop;
        wait;
    end process;

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

    stim_proc: process
    begin
        reset <= '1'; wait for 20 ns; reset <= '0'; wait for 10 ns;

        I <= '1'; -- inserção do copo
        wait for 10 ns;

        -- selecionar quantidade = 1
        btn_qtd <= '1'; wait for 10 ns; btn_qtd <= '0'; wait for 10 ns;
        
        -- confirmar quantidade
        ok_qtd <= '1'; wait for 10 ns; ok_qtd <= '0'; wait for 10 ns;

        -- selecionar Guaraná
        refri <= '0'; wait for 20 ns;

        -- inserir nota de 5 reais
        valor <= "00101"; dinheiro <= '1'; wait for 10 ns;
        dinheiro <= '0'; wait for 100 ns;

        -- verificar
        report "TROCO: " & integer'image(to_integer(unsigned(troco)));
        report "LUCRO: " & integer'image(to_integer(unsigned(lucro)));

        assert unsigned(troco) = 0
            report "ERRO: troco deveria ser 0!" severity error;

        assert unsigned(lucro) = 5
            report "ERRO: lucro deveria ser 5 após a venda!" severity error;

        wait;
    end process;

end behavior;
