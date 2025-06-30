library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Comparador_2bits is
end tb_Comparador_2bits;

architecture behavior of tb_Comparador_2bits is

    -- Component declaration
    component Comparador_2bits
        Port (
            A          : in  STD_LOGIC_VECTOR(1 downto 0);
            B          : in  STD_LOGIC_VECTOR(1 downto 0);
            A_maior_B  : out STD_LOGIC;
            A_igual_B  : out STD_LOGIC;
            A_menor_B  : out STD_LOGIC
        );
    end component;

    -- Signals for connection
    signal A         : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal B         : STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
    signal A_maior_B : STD_LOGIC;
    signal A_igual_B : STD_LOGIC;
    signal A_menor_B : STD_LOGIC;

begin

    -- Unit under test
    uut: Comparador_2bits
        Port map (
            A => A,
            B => B,
            A_maior_B => A_maior_B,
            A_igual_B => A_igual_B,
            A_menor_B => A_menor_B
        );

    -- Test process
    stim_proc: process
    begin
        -- Test A < B
        A <= "00"; B <= "01"; wait for 10 ns;
        A <= "01"; B <= "10"; wait for 10 ns;

        -- Test A = B
        A <= "10"; B <= "10"; wait for 10 ns;

        -- Test A > B
        A <= "11"; B <= "01"; wait for 10 ns;
        A <= "10"; B <= "00"; wait for 10 ns;

        wait;
    end process;

end behavior;
