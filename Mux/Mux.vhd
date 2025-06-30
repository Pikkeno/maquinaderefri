library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux is
    Port (
        sel : in STD_LOGIC;
        a   : in STD_LOGIC_VECTOR(3 downto 0); -- P1
        b   : in STD_LOGIC_VECTOR(3 downto 0); -- P2
        y   : out STD_LOGIC_VECTOR(3 downto 0) -- preço selecionado
    );
end Mux;

architecture Behavioral of Mux is
begin
    process(sel, a, b)
    begin
        if sel = '0' then
            y <= a;
        else
            y <= b;
        end if;
    end process;
end Behavioral;
