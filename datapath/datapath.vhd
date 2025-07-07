library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        coin    : in  STD_LOGIC;
        valor   : in  STD_LOGIC_VECTOR(4 downto 0); -- dinheiro inserido
        sel     : in  STD_LOGIC; -- 0: Guaraná, 1: Coca
        preco1  : in  STD_LOGIC_VECTOR(3 downto 0);
        preco2  : in  STD_LOGIC_VECTOR(3 downto 0);
        inc_q   : in  STD_LOGIC;
        venda   : in  STD_LOGIC;
        ld_p    : in  STD_LOGIC; -- novo sinal para carregar o preço total
        troco   : out STD_LOGIC_VECTOR(8 downto 0);
        lucro   : out STD_LOGIC_VECTOR(8 downto 0)
    );
end Datapath;

architecture Structural of Datapath is

    -- Sinais internos
    signal D_val     : STD_LOGIC_VECTOR(8 downto 0); -- dinheiro inserido
    signal Q_val     : STD_LOGIC_VECTOR(1 downto 0); -- quantidade
    signal preco_s   : STD_LOGIC_VECTOR(3 downto 0); -- preço unitário
    signal P_temp    : STD_LOGIC_VECTOR(5 downto 0); -- preço total (6 bits)
    signal P_ext     : STD_LOGIC_VECTOR(8 downto 0); -- extensão de P_temp
    signal P_count   : STD_LOGIC_VECTOR(8 downto 0); -- valor registrado da compra
    signal D_ext     : STD_LOGIC_VECTOR(8 downto 0); -- dinheiro estendido
    signal troco_s   : STD_LOGIC_VECTOR(8 downto 0); -- troco calculado
    signal lucro_s   : STD_LOGIC_VECTOR(8 downto 0); -- lucro acumulado
    signal troco_r   : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');

begin

    -- Dinheiro inserido
    D_counter: entity work.D_count
        port map (
            clk   => clk,
            reset => reset,
            coin  => coin,
            valor => valor,
            D     => D_val
        );

    -- Quantidade selecionada
    Q_counter: entity work.Q_count
        port map (
            clk       => clk,
            reset     => reset,
            increment => inc_q,
            Q         => Q_val
        );

    -- MUX seleciona o preço com base em 'sel'
    SelecionaPreco: entity work.Mux
    port map (
        sel => sel,
        a   => preco1,  -- Guaraná
        b   => preco2,  -- Coca
        y   => preco_s
    );

    -- Multiplicador calcula o preço total da compra
    CalculaPreco: entity work.Multiplicador
        port map (
            preco_unitario => preco_s,
            quantidade     => Q_val,
            resultado      => P_temp
        );

    -- Extensão para 9 bits
    P_ext <= "000" & P_temp;
    D_ext <= D_val;

    -- Registrador P_count armazena o valor total da compra
    RegistraPreco: entity work.P_count
        port map (
            clk   => clk,
            reset => reset,
            ld    => ld_p,
            D     => P_ext,
            Q     => P_count
        );

    -- Subtrator calcula o troco: troco = dinheiro - preço
    CalculaTroco: entity work.Subtrator
        port map (
            D => D_ext,
            P => P_count,
            T => troco_s
        );

    -- Somador acumula o lucro
    AcumulaLucro: entity work.L_count
        port map (
            clk    => clk,
            reset  => reset,
            enable => venda,
            valor  => P_count,
            total  => lucro_s
        );

    -- Registrador de troco
    process(clk, reset)
    begin
        if reset = '1' then
            troco_r <= (others => '0');
        elsif rising_edge(clk) then
            if venda = '1' then
                troco_r <= troco_s;
            end if;
        end if;
    end process;

    -- Saídas
    troco <= troco_r;
    lucro <= lucro_s;

end Structural;
