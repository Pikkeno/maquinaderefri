library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
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
        ld_p    : in  STD_LOGIC;

        troco   : out STD_LOGIC_VECTOR(8 downto 0);
        lucro   : out STD_LOGIC_VECTOR(8 downto 0)
    );
end Datapath;

architecture Structural of Datapath is

    -- Sinais internos
    signal D_val     : STD_LOGIC_VECTOR(8 downto 0);
    signal Q_val     : STD_LOGIC_VECTOR(1 downto 0);
    signal preco_s   : STD_LOGIC_VECTOR(3 downto 0);
    signal preco_reg : STD_LOGIC_VECTOR(3 downto 0);
    signal qtd_reg   : STD_LOGIC_VECTOR(1 downto 0);
    signal P_temp    : STD_LOGIC_VECTOR(5 downto 0);
    signal P_ext     : STD_LOGIC_VECTOR(8 downto 0);
    signal P_count   : STD_LOGIC_VECTOR(8 downto 0);
    signal D_ext     : STD_LOGIC_VECTOR(8 downto 0);
    signal troco_s   : STD_LOGIC_VECTOR(8 downto 0);
    signal lucro_s   : STD_LOGIC_VECTOR(8 downto 0);
    signal troco_r   : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');

    -- Sincronizadores
    signal ld_p_sync1, ld_p_sync2 : STD_LOGIC := '0';

begin

    -- Atraso de 2 ciclos para ld_p
    process(clk, reset)
    begin
        if reset = '1' then
            ld_p_sync1 <= '0';
            ld_p_sync2 <= '0';
        elsif rising_edge(clk) then
            ld_p_sync1 <= ld_p;
            ld_p_sync2 <= ld_p_sync1;
        end if;
    end process;

    -- Registrador de dinheiro
    D_counter: entity work.D_count
        port map (
            clk   => clk,
            reset => reset,
            coin  => coin,
            valor => valor,
            D     => D_val
        );

    -- Registrador de quantidade
    Q_counter: entity work.Q_count
        port map (
            clk       => clk,
            reset     => reset,
            increment => inc_q,
            Q         => Q_val
        );

    -- MUX para seleção de preço
    SelecionaPreco: entity work.Mux
        port map (
            sel => sel,
            a   => preco1,
            b   => preco2,
            y   => preco_s
        );

    -- Registro das entradas do multiplicador
    process(clk, reset)
    begin
        if reset = '1' then
            preco_reg <= (others => '0');
            qtd_reg   <= (others => '0');
        elsif rising_edge(clk) then
            preco_reg <= preco_s;
            qtd_reg   <= Q_val;
        end if;
    end process;

    -- Multiplicador preco × quantidade
    CalculaPreco: entity work.Multiplicador
        port map (
            preco_unitario => preco_reg,
            quantidade     => qtd_reg,
            resultado      => P_temp
        );

    P_ext <= "000" & P_temp;
    D_ext <= D_val;

    -- Registro do valor da compra
    RegistraPreco: entity work.P_count
        port map (
            clk   => clk,
            reset => reset,
            ld    => ld_p_sync2,
            D     => P_ext,
            Q     => P_count
        );

    -- Subtrator: troco = D_ext - P_count
    CalculaTroco: entity work.Subtrator
        port map (
            D => D_ext,
            P => P_count,
            T => troco_s
        );

    -- Acumulador de lucro
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

                -- Debug
                report "VALOR P_EXT = " & integer'image(to_integer(unsigned(P_ext)));
                report "VALOR P_COUNT = " & integer'image(to_integer(unsigned(P_count)));
                report "VALOR D_EXT = " & integer'image(to_integer(unsigned(D_ext)));
					 report "preco_reg  = " & integer'image(to_integer(unsigned(preco_reg)));
					 report "qtd_reg    = " & integer'image(to_integer(unsigned(qtd_reg)));
            end if;
        end if;
    end process;

    -- Saídas finais
    troco <= troco_r;
    lucro <= lucro_s;

end Structural;
