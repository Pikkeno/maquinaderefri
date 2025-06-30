library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Subtrator is
    Port (
        D : in STD_LOGIC_VECTOR(4 downto 0); -- Dinheiro inserido (5 bits)
        P : in STD_LOGIC_VECTOR(4 downto 0); -- Preço (ajustado para 5 bits para compatibilidade)
        T : out STD_LOGIC_VECTOR(4 downto 0) -- Troco
    );
end Subtrator;

architecture Behavioral of Subtrator is
begin
    T <= D - P;
end Behavioral;
