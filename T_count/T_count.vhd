library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity T_count is
    Port (
        D_count : in STD_LOGIC_VECTOR(8 downto 0); -- valor inserido
        P_count : in STD_LOGIC_VECTOR(6 downto 0); -- preço total
        T       : out STD_LOGIC_VECTOR(8 downto 0) -- troco calculado
    );
end T_count;

architecture Behavioral of T_count is
    signal P_ext : STD_LOGIC_VECTOR(8 downto 0);
begin
    -- Extensão de P_count (7 bits) para 9 bits
    P_ext <= "00" & P_count;

    -- Troco é a diferença entre o valor inserido e o preço
    T <= D_count - P_ext;
end Behavioral;