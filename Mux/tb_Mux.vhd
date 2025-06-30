library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Mux is
end tb_Mux;

architecture behavior of tb_Mux is

    -- Componente a ser testado
    component Mux
        Port (
            sel : in  STD_LOGIC;
            a   : in  STD_LOGIC_VECTOR(3 downto 0);
            b   : in  STD_LOGIC_VECTOR(3 downto 0);
            y   : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Sinais de estímulo
    signal sel : STD_LOGIC := '0';
    signal a   : STD_LOGIC_VECTOR(3 downto 0) := "0011"; -- R$3,00 (P1)
    signal b   : STD_LOGIC_VECTOR(3 downto 0) := "0010"; -- R$2,00 (P2)
    signal y   : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instanciação da UUT
    uut: Mux
        port map (
            sel => sel,
            a   => a,
            b   => b,
            y   => y
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- Seleciona 'a' (P1)
        sel <= '0';
        wait for 10 ns;

        -- Seleciona 'b' (P2)
        sel <= '1';
        wait for 10 ns;

        -- Troca valores de entrada e testa novamente
        a <= "0100"; -- R$4,00
        b <= "0101"; -- R$5,00
        sel <= '0';
        wait for 10 ns;

        sel <= '1';
        wait for 10 ns;

        wait;
    end process;

end behavior;
