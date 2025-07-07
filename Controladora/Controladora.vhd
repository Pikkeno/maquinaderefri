library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controladora is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        I         : in  STD_LOGIC;
        refri     : in  STD_LOGIC;
        btn_qtd   : in  STD_LOGIC;
        ok_qtd    : in  STD_LOGIC;
        dinheiro  : in  STD_LOGIC;
        valor_ok  : in  STD_LOGIC;

        inc_q     : out STD_LOGIC;
        coin      : out STD_LOGIC;
        venda     : out STD_LOGIC;
        sel       : out STD_LOGIC;
        ld_lucro  : out STD_LOGIC;
        ld_p      : out STD_LOGIC
    );
end Controladora;

architecture FSM_Moore_TPM of Controladora is

    type state_type is (
        Idle,
        SelecionaQtd,
        PulsoQtd,
        SelecionaRefri,
        CalculaPreco,       -- NOVO ESTADO
        AguardaPagamento,
        Espera1,
        Espera2,
        RegistraCompra,
        EsperaPcount,
        LiberaVenda
    );

    signal estado_atual, proximo_estado : state_type;

    -- sinais internos
    signal inc_q_s, coin_s, venda_s, ld_lucro_s, ld_p_s : STD_LOGIC;
    signal sel_s : STD_LOGIC;

begin

    -- Processo de transição de estado
    process(clk, reset)
    begin
        if reset = '1' then
            estado_atual <= Idle;
        elsif rising_edge(clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;

    -- Processo de decisão de próximo estado e sinais
    process(estado_atual, I, btn_qtd, refri, dinheiro, ok_qtd, valor_ok)
    begin
        -- padrões
        proximo_estado <= estado_atual;
        inc_q_s     <= '0';
        coin_s      <= '0';
        venda_s     <= '0';
        ld_lucro_s  <= '0';
        ld_p_s      <= '0';
        sel_s       <= refri;

        case estado_atual is
            when Idle =>
                if I = '1' then
                    proximo_estado <= SelecionaQtd;
                end if;

            when SelecionaQtd =>
                if btn_qtd = '1' then
                    proximo_estado <= PulsoQtd;
                elsif ok_qtd = '1' then
                    proximo_estado <= SelecionaRefri;
                end if;

            when PulsoQtd =>
                inc_q_s <= '1';
                proximo_estado <= SelecionaQtd;

            when SelecionaRefri =>
                proximo_estado <= CalculaPreco;

            when CalculaPreco =>
                ld_p_s <= '1';
                proximo_estado <= EsperaPcount;

            when EsperaPcount =>
                proximo_estado <= AguardaPagamento;

            when AguardaPagamento =>
                if dinheiro = '1' then
                    coin_s <= '1';
                elsif valor_ok = '1' then
                    proximo_estado <= Espera1;
                end if;

            when Espera1 =>
                proximo_estado <= Espera2;

            when Espera2 =>
                proximo_estado <= RegistraCompra;

            when RegistraCompra =>
                -- ld_p_s já foi ativado antes
                proximo_estado <= LiberaVenda;

            when LiberaVenda =>
                venda_s    <= '1';
                ld_lucro_s <= '1';
                proximo_estado <= Idle;

            when others =>
                proximo_estado <= Idle;
        end case;
    end process;

    -- Saídas
    inc_q    <= inc_q_s;
    coin     <= coin_s;
    venda    <= venda_s;
    sel      <= sel_s;
    ld_lucro <= ld_lucro_s;
    ld_p     <= ld_p_s;

end FSM_Moore_TPM;
