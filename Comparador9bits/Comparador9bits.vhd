library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparador9bits is
    Port (
        A          : in  STD_LOGIC_VECTOR(8 downto 0); -- valor inserido
        B          : in  STD_LOGIC_VECTOR(8 downto 0); -- preço total
        MaiorIgual : out STD_LOGIC                    -- 1 se A >= B
    );
end Comparador9bits;

architecture Behavioral of Comparador9bits is
begin
    process(A, B)
    begin
        if unsigned(A) >= unsigned(B) then
            MaiorIgual <= '1';
        else
            MaiorIgual <= '0';
        end if;
    end process;
end Behavioral;
