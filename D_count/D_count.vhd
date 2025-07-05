library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity D_count is
    Port (
        clk   : in  STD_LOGIC;
        reset : in  STD_LOGIC;
        coin  : in  STD_LOGIC; -- pulso indicando inserção de dinheiro
        valor : in  STD_LOGIC_VECTOR(4 downto 0); -- valor da nota/moeda
        D     : out STD_LOGIC_VECTOR(8 downto 0)
    );
end D_count;

architecture Behavioral of D_count is
    signal count : unsigned(8 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= (others => '0');
        elsif rising_edge(clk) then
            if coin = '1' then
                count <= count + resize(unsigned(valor), count'length);
            end if;
        end if;
    end process;

    D <= std_logic_vector(count);
end Behavioral;
