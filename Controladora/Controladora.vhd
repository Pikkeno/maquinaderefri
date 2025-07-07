library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controladora is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        I         : in  STD_LOGIC; -- sensor de copo
        refri     : in  STD_LOGIC; -- 0: Guaraná, 1: Coca
        btn_qtd   : in  STD_LOGIC;
        dinheiro  : in  STD_LOGIC;

        inc_q     : out STD_LOGIC;
        coin      : out STD_LOGIC;
        venda     : out STD_LOGIC;
        sel       : out STD_LOGIC;
        ld_lucro  : out STD_LOGIC   -- novo sinal de controle
    );
end Controladora;

architecture FSM_Moore_TPM of Controladora is

    type state_type is (
        Idle,               -- Espera o copo (I=1)
        SelecionaQtd,       -- Cliente seleciona quantidade
        SelecionaRefri,     -- Cliente seleciona refri
        AguardaPagamento,   -- Espera inserir dinheiro suficiente
        LiberaVenda         -- Libera bebida e atualiza lucro
    );

    signal estado_atual, proximo_estado : state_type;

    -- sinais internos de saída
    signal inc_q_s, coin_s, venda_s, ld_lucro_s : STD_LOGIC;
    signal sel_s : STD_LOGIC;

begin

    -- PROCESSO 1: Registrador de estado
    process(clk, reset)
    begin
        if reset = '1' then
            estado_atual <= Idle;
        elsif rising_edge(clk) then
            estado_atual <= proximo_estado;
        end if;
    end process;

    -- PROCESSO 2: Lógica combinacional (próximo estado + saídas Moore)
    process(estado_atual, I, btn_qtd, refri, dinheiro)
    begin
        -- valores padrão
        proximo_estado <= estado_atual;
        inc_q_s    <= '0';
        coin_s     <= '0';
        venda_s    <= '0';
        ld_lucro_s <= '0';
        sel_s      <= refri;

        case estado_atual is
            when Idle =>
                if I = '1' then
                    proximo_estado <= SelecionaQtd;
                end if;

            when SelecionaQtd =>
                if btn_qtd = '1' then
                    inc_q_s <= '1';
                elsif refri = '0' or refri = '1' then
                    proximo_estado <= SelecionaRefri;
                end if;

            when SelecionaRefri =>
                proximo_estado <= AguardaPagamento;

            when AguardaPagamento =>
                if dinheiro = '1' then
                    coin_s <= '1';
                    proximo_estado <= LiberaVenda;
                end if;

            when LiberaVenda =>
                venda_s    <= '1';
                ld_lucro_s <= '1'; -- ATIVA O REGISTRADOR DE LUCRO
                proximo_estado <= Idle;

            when others =>
                proximo_estado <= Idle;
        end case;
    end process;

    -- atribuição das saídas
    inc_q    <= inc_q_s;
    coin     <= coin_s;
    venda    <= venda_s;
    sel      <= sel_s;
    ld_lucro <= ld_lucro_s;

end FSM_Moore_TPM;
