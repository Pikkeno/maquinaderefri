library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Somador is
    Port (
        L_count : in  STD_LOGIC_VECTOR (8 downto 0); -- valor acumulado (9 bits)
        P_count : in  STD_LOGIC_VECTOR (6 downto 0); -- valor da compra atual (7 bits)
        S       : out STD_LOGIC_VECTOR (8 downto 0)  -- resultado da soma (9 bits)
    );
end Somador;

architecture Behavioral of Somador is
    signal P_ext : STD_LOGIC_VECTOR (8 downto 0); -- P_count estendido para 9 bits
begin
    -- Extensão de P_count (7 bits) para 9 bits (preenchendo os 2 bits mais significativos com zeros)
    P_ext <= "00" & P_count;

    -- Soma L_count + P_ext
    S <= L_count + P_ext;
end Behavioral;
