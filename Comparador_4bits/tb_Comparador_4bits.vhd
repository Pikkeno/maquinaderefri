library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Comparador_4bits is
end tb_Comparador_4bits;

architecture behavior of tb_Comparador_4bits is

    -- Declaração do componente a ser testado
    component Comparador_4bits
        Port (
            A : in STD_LOGIC_VECTOR(3 downto 0);
            B : in STD_LOGIC_VECTOR(3 downto 0);
            A_maior_B : out STD_LOGIC;
            A_igual_B : out STD_LOGIC;
            A_menor_B : out STD_LOGIC
        );
    end component;

    -- Sinais de estímulo e observação
    signal A : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal B : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal A_maior_B : STD_LOGIC;
    signal A_igual_B : STD_LOGIC;
    signal A_menor_B : STD_LOGIC;

begin

    -- Instanciação da UUT (Unidade em Teste)
    uut: Comparador_4bits
        port map (
            A => A,
            B => B,
            A_maior_B => A_maior_B,
            A_igual_B => A_igual_B,
            A_menor_B => A_menor_B
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- A < B
        A <= "0001"; B <= "0010"; wait for 10 ns;
        -- A = B
        A <= "0101"; B <= "0101"; wait for 10 ns;
        -- A > B
        A <= "1000"; B <= "0011"; wait for 10 ns;
        -- Casos extras
        A <= "0000"; B <= "0000"; wait for 10 ns;
        A <= "1111"; B <= "1110"; wait for 10 ns;
        A <= "0011"; B <= "1010"; wait for 10 ns;

        wait;
    end process;

end behavior;
