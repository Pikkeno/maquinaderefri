library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controladora is
    Port (
        clk      : in  STD_LOGIC;
        reset    : in  STD_LOGIC;
        I        : in  STD_LOGIC; -- sensor de copo
        refri    : in  STD_LOGIC; -- 0: Guaraná, 1: Coca
        btn_qtd  : in  STD_LOGIC;
        dinheiro : in  STD_LOGIC;

        inc_q    : out STD_LOGIC;
        coin     : out STD_LOGIC;
        venda    : out STD_LOGIC;
        sel      : out STD_LOGIC
    );
end Controladora;

architecture Behavioral of Controladora is
    type state_type is (
        Inicio,
        EscolheQtd,
        EscolheRefri,
        EsperaDinheiro,
        FinalizaVenda
    );
    signal state : state_type := Inicio;
begin
    process(clk, reset)
    begin
        if reset = '1' then
            state <= Inicio;
        elsif rising_edge(clk) then
            case state is
                when Inicio =>
                    if I = '1' then
                        state <= EscolheQtd;
                    end if;

                when EscolheQtd =>
                    if btn_qtd = '1' then
                        state <= EscolheRefri;
                    end if;

                when EscolheRefri =>
                    if refri = '0' or refri = '1' then
                        state <= EsperaDinheiro;
                    end if;

                when EsperaDinheiro =>
                    if dinheiro = '1' then
                        state <= FinalizaVenda;
                    end if;

                when FinalizaVenda =>
                    state <= Inicio;
            end case;
        end if;
    end process;

    -- sinais de controle
    inc_q <= '1' when state = EscolheQtd and btn_qtd = '1' else '0';
    sel   <= refri;
    coin  <= '1' when state = EsperaDinheiro and dinheiro = '1' else '0';
    venda <= '1' when state = FinalizaVenda else '0';
end Behavioral;
