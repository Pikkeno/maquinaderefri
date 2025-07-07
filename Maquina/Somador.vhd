library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Somador is
    Port (
        L_count : in  STD_LOGIC_VECTOR (8 downto 0); -- valor acumulado
        P_count : in  STD_LOGIC_VECTOR (6 downto 0); -- valor da compra atual
        S       : out STD_LOGIC_VECTOR (8 downto 0)  -- resultado da soma
    );
end Somador;

architecture Behavioral of Somador is
    signal P_ext : STD_LOGIC_VECTOR (8 downto 0);
begin
    -- Extensão de P_count para 9 bits
    P_ext <= "00" & P_count;

    -- Soma utilizando tipo unsigned e depois convertendo para STD_LOGIC_VECTOR
    S <= std_logic_vector(unsigned(L_count) + unsigned(P_ext));
end Behavioral;
