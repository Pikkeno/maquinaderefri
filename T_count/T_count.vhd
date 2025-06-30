library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T_count is
    Port (
        D_count : in STD_LOGIC_VECTOR(8 downto 0); -- valor inserido
        P_count : in STD_LOGIC_VECTOR(6 downto 0); -- preço total
        T       : out STD_LOGIC_VECTOR(8 downto 0) -- troco calculado
    );
end T_count;

architecture Behavioral of T_count is
    signal D_u  : unsigned(8 downto 0);
    signal P_u  : unsigned(8 downto 0);
    signal T_u  : unsigned(8 downto 0);
begin
    D_u <= unsigned(D_count);
    P_u <= ("00" & unsigned(P_count)); -- extensão para 9 bits
    T_u <= D_u - P_u;

    T <= std_logic_vector(T_u);
end Behavioral;
