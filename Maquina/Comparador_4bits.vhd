library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Comparador_4bits is
    Port (
        A : in STD_LOGIC_VECTOR(3 downto 0);
        B : in STD_LOGIC_VECTOR(3 downto 0);
        A_maior_B : out STD_LOGIC;
        A_igual_B : out STD_LOGIC;
        A_menor_B : out STD_LOGIC
    );
end Comparador_4bits;

architecture Behavioral of Comparador_4bits is
begin
    process(A, B)
    begin
        if A > B then
            A_maior_B <= '1';
            A_igual_B <= '0';
            A_menor_B <= '0';
        elsif A = B then
            A_maior_B <= '0';
            A_igual_B <= '1';
            A_menor_B <= '0';
        else
            A_maior_B <= '0';
            A_igual_B <= '0';
            A_menor_B <= '1';
        end if;
    end process;
end Behavioral;