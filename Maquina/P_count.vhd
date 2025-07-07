library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity P_count is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        ld    : in  STD_LOGIC;
        D     : in  STD_LOGIC_VECTOR(8 downto 0); -- dado de entrada (preço total)
        Q     : out STD_LOGIC_VECTOR(8 downto 0)  -- dado armazenado
    );
end P_count;

architecture Behavioral of P_count is
    signal reg : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if ld = '1' then
                reg <= D;
            end if;
        end if;
    end process;

    Q <= reg;
end Behavioral;
