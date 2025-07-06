library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        coin    : in  STD_LOGIC;
        valor   : in  STD_LOGIC_VECTOR(4 downto 0);
        sel     : in  STD_LOGIC; -- 0: Guaraná, 1: Coca
        preco1  : in  STD_LOGIC_VECTOR(3 downto 0);
        preco2  : in  STD_LOGIC_VECTOR(3 downto 0);
        inc_q   : in  STD_LOGIC;
        venda   : in  STD_LOGIC;
        troco   : out STD_LOGIC_VECTOR(8 downto 0);
        lucro   : out STD_LOGIC_VECTOR(8 downto 0)
    );
end Datapath;

architecture Structural of Datapath is

    -- Sinais internos
    signal D_val     : STD_LOGIC_VECTOR(8 downto 0); -- valor de dinheiro inserido
    signal Q_val     : STD_LOGIC_VECTOR(1 downto 0); -- quantidade escolhida
    signal preco_s   : STD_LOGIC_VECTOR(3 downto 0); -- preço unitário selecionado
    signal P_temp    : STD_LOGIC_VECTOR(3 downto 0); -- preço total (antes de extensão)
    signal P_ext     : STD_LOGIC_VECTOR(6 downto 0); -- preço estendido para somador
    signal D_ext     : STD_LOGIC_VECTOR(8 downto 0); -- valor de entrada estendido
    signal troco_s   : STD_LOGIC_VECTOR(8 downto 0); -- valor do troco calculado
    signal lucro_s   : STD_LOGIC_VECTOR(8 downto 0); -- valor acumulado
    signal troco_r   : STD_LOGIC_VECTOR(8 downto 0) := (others => '0'); -- registrador de troco

begin

    -- Registrador de dinheiro (D_count)
    D_counter: entity work.D_count
        port map (
            clk   => clk,
            reset => reset,
            coin  => coin,
            valor => valor,
            D     => D_val
        );

    -- Registrador de quantidade (Q_count)
    Q_counter: entity work.Q_count
        port map (
            clk       => clk,
            reset     => reset,
            increment => inc_q,
            Q         => Q_val
        );

    -- Multiplexador para selecionar preço
    SelecionaPreco: entity work.Mux
        port map (
            sel => sel,
            a   => preco1,
            b   => preco2,
            y   => preco_s
        );

    -- Multiplicador: preco_unitario * quantidade
    CalculaPreco: entity work.Multiplicador
        port map (
            preco_unitario => preco_s,
            quantidade     => Q_val,
            resultado      => P_temp
        );

    -- Extensão para compatibilidade com somador (7 bits)
    P_ext <= "000" & P_temp;
    D_ext <= D_val;

    -- Subtrator para cálculo do troco
    CalculaTroco: entity work.T_count
        port map (
            D_count => D_ext,
            P_count => P_temp,
            T       => troco_s
        );

    -- Somador para acumular lucro
    AcumulaLucro: entity work.L_count
        port map (
            clk    => clk,
            reset  => reset,
            enable => venda,
            valor  => P_ext,
            total  => lucro_s
        );

    -- Registrador para armazenar o troco calculado
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

    -- Saídas finais
    troco <= troco_r;
    lucro <= lucro_s;

end Structural;
