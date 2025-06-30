library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Q_count is
    Port (
        clk       : in  STD_LOGIC;
        reset     : in  STD_LOGIC;
        increment : in  STD_LOGIC;
        Q         : out STD_LOGIC_VECTOR(1 downto 0)
    );
end Q_count;

architecture Behavioral of Q_count is
    signal count : STD_LOGIC_VECTOR(1 downto 0) := "00";
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count <= "00";
        elsif rising_edge(clk) then
            if increment = '1' then
                count <= count + 1;
            end if;
        end if;
    end process;

    Q <= count;
end Behavioral;