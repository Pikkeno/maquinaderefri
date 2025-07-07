library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Subtrator is
    Port (
        D : in STD_LOGIC_VECTOR(8 downto 0); -- Dinheiro inserido (9 bits)
        P : in STD_LOGIC_VECTOR(8 downto 0); -- Preço (9 bits)
        T : out STD_LOGIC_VECTOR(8 downto 0) -- Troco
    );
end Subtrator;

architecture Behavioral of Subtrator is
begin
    T <= std_logic_vector(unsigned(D) - unsigned(P));
end Behavioral;
