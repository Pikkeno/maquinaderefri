library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity L_count is
    Port (
        clk    : in  STD_LOGIC;
        reset  : in  STD_LOGIC;
        enable : in  STD_LOGIC;
        valor  : in  STD_LOGIC_VECTOR(6 downto 0); -- lucro da venda atual
        total  : out STD_LOGIC_VECTOR(8 downto 0)  -- lucro acumulado
    );
end L_count;

architecture Behavioral of L_count is
    signal acum : unsigned(8 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            acum <= (others => '0');
        elsif rising_edge(clk) then
            if enable = '1' then
                acum <= acum + ("00" & unsigned(valor));
            end if;
        end if;
    end process;
    total <= std_logic_vector(acum);
end Behavioral;