library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity T_count is
    Port (
        D_count : in STD_LOGIC_VECTOR(8 downto 0); -- valor inserido
        P_count : in STD_LOGIC_VECTOR(8 downto 0); -- preço total (agora 9 bits!)
        T       : out STD_LOGIC_VECTOR(8 downto 0) -- troco calculado
    );
end T_count;

architecture Behavioral of T_count is
begin
    process(D_count, P_count)
        variable D_u : unsigned(8 downto 0);
        variable P_u : unsigned(8 downto 0);
        variable T_u : unsigned(8 downto 0);
    begin
        D_u := unsigned(D_count);
        P_u := unsigned(P_count); -- ✅ sem extensão agora
        T_u := D_u - P_u;
        T   <= std_logic_vector(T_u);
    end process;
end Behavioral;
