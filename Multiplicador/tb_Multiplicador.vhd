library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Multiplicador is
end tb_Multiplicador;

architecture behavior of tb_Multiplicador is

    -- Componente a ser testado
    component Multiplicador
        Port (
            preco_unitario : in  STD_LOGIC_VECTOR(3 downto 0);
            quantidade     : in  STD_LOGIC_VECTOR(1 downto 0);
            resultado      : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    -- Sinais de estímulo
    signal preco_unitario : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal quantidade     : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal resultado      : STD_LOGIC_VECTOR(5 downto 0);

begin

    -- Instanciação da unidade sob teste
    uut: Multiplicador
        port map (
            preco_unitario => preco_unitario,
            quantidade     => quantidade,
            resultado      => resultado
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- P = 3, Q = 1 (300 mL)
        preco_unitario <= "0011"; -- R$3
        quantidade <= "01";
        wait for 10 ns;

        -- P = 3, Q = 2 (600 mL)
        quantidade <= "10";
        wait for 10 ns;

        -- P = 3, Q = 3 (900 mL)
        quantidade <= "11";
        wait for 10 ns;

        -- P = 2, Q = 3
        preco_unitario <= "0010";
        quantidade <= "11";
        wait for 10 ns;

        -- P = 4, Q = 0 (invalido, preço = 0)
        preco_unitario <= "0100";
        quantidade <= "00";
        wait for 10 ns;

        -- P = 0, Q = 2
        preco_unitario <= "0000";
        quantidade <= "10";
        wait for 10 ns;

        wait;
    end process;

end behavior;
