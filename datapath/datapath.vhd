library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        coin   : in  STD_LOGIC;
        sel    : in  STD_LOGIC; -- seleciona P1 ou P2
        preco1 : in  STD_LOGIC_VECTOR(3 downto 0);
        preco2 : in  STD_LOGIC_VECTOR(3 downto 0);
        inc_q  : in  STD_LOGIC; -- incrementa quantidade
        venda  : in  STD_LOGIC; -- finaliza venda
        troco  : out STD_LOGIC_VECTOR(3 downto 0);
        lucro  : out STD_LOGIC_VECTOR(8 downto 0)
    );
end Datapath;

architecture Structural of Datapath is
    signal D_val   : STD_LOGIC_VECTOR(3 downto 0);
    signal Q_val   : STD_LOGIC_VECTOR(1 downto 0);
    signal preco_s : STD_LOGIC_VECTOR(3 downto 0);
    signal P_temp  : STD_LOGIC_VECTOR(3 downto 0);
    signal P_cnt   : STD_LOGIC_VECTOR(6 downto 0);
    signal D_ext   : STD_LOGIC_VECTOR(3 downto 0);
    signal troco_s : STD_LOGIC_VECTOR(3 downto 0);
    signal lucro_s : STD_LOGIC_VECTOR(8 downto 0);
begin
    D_counter: entity work.D_count
        port map(
            clk   => clk,
            reset => reset,
            coin  => coin,
            D     => D_val
        );

    Q_counter: entity work.Q_count
        port map(
            clk       => clk,
            reset     => reset,
            increment => inc_q,
            Q         => Q_val
        );

    SelecionaPreco: entity work.Mux
        port map(
            sel => sel,
            a   => preco1,
            b   => preco2,
            y   => preco_s
        );

    CalculaPreco: entity work.Multiplicador
        port map(
            preco_unitario => preco_s,
            quantidade     => Q_val,
            resultado      => P_temp
        );

    P_cnt <= "000" & P_temp; -- extensao para 7 bits
    D_ext <= D_val; -- sem extensao, 4 bits

    CalculaTroco: entity work.T_count
        port map(
            D_count => D_ext,
            P_count => P_temp,
            T       => troco_s
        );

    AcumLucro: entity work.L_count
        port map(
            clk    => clk,
            reset  => reset,
            enable => venda,
            valor  => P_cnt,
            total  => lucro_s
        );

    troco <= troco_s;
    lucro <= lucro_s;
end Structural;