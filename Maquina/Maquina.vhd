library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Maquina is
    Port (
        clk     : in  STD_LOGIC;
        reset   : in  STD_LOGIC;
        I       : in  STD_LOGIC; -- sensor de copo
        preco1  : in  STD_LOGIC_VECTOR(3 downto 0);
        preco2  : in  STD_LOGIC_VECTOR(3 downto 0);
        refri   : in  STD_LOGIC; -- 0: Guaraná, 1: Coca-Cola
        btn_qtd : in  STD_LOGIC; -- botão que incrementa quantidade
        dinheiro: in  STD_LOGIC; -- pulso simulando nota inserida
        valor   : in  STD_LOGIC_VECTOR(4 downto 0); -- valor da nota/moeda
        troco   : out STD_LOGIC_VECTOR(8 downto 0);
        lucro   : out STD_LOGIC_VECTOR(8 downto 0)
    );
end Maquina;

architecture Structural of Maquina is
    -- sinais de controle da FSM para o Datapath
    signal inc_q_s, coin_s, venda_s, sel_s : STD_LOGIC;
begin

    -- Unidade de Controle (FSM)
    FSM: entity work.Controladora
        port map (
            clk     => clk,
            reset   => reset,
            I       => I,
            refri   => refri,
            btn_qtd => btn_qtd,
            dinheiro=> dinheiro,
            inc_q   => inc_q_s,
            coin    => coin_s,
            venda   => venda_s,
            sel     => sel_s
        );

    -- Caminho de Dados
    DP: entity work.Datapath
        port map (
            clk     => clk,
            reset   => reset,
            coin    => coin_s,
            valor   => valor,
            sel     => sel_s,
            preco1  => preco1,
            preco2  => preco2,
            inc_q   => inc_q_s,
            venda   => venda_s,
            troco   => troco,
            lucro   => lucro
        );
end Structural;
