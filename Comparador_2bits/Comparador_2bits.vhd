library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparador_2bits is
    Port (
        A          : in  STD_LOGIC_VECTOR(1 downto 0);
        B          : in  STD_LOGIC_VECTOR(1 downto 0);
        A_maior_B  : out STD_LOGIC;
        A_igual_B  : out STD_LOGIC;
        A_menor_B  : out STD_LOGIC
    );
end Comparador_2bits;

architecture Behavioral of Comparador_2bits is
begin
    process(A, B)
    begin
        if unsigned(A) > unsigned(B) then
            A_maior_B <= '1';
            A_igual_B <= '0';
            A_menor_B <= '0';
        elsif unsigned(A) = unsigned(B) then
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