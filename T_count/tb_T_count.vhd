library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_T_count is
end tb_T_count;

architecture behavior of tb_T_count is

    -- Componente a ser testado
    component T_count
        Port (
            D_count : in  STD_LOGIC_VECTOR(8 downto 0);
            P_count : in  STD_LOGIC_VECTOR(6 downto 0);
            T       : out STD_LOGIC_VECTOR(8 downto 0)
        );
    end component;

    -- Sinais
    signal D_count : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
    signal P_count : STD_LOGIC_VECTOR(6 downto 0) := (others => '0');
    signal T       : STD_LOGIC_VECTOR(8 downto 0);

begin

    -- Instanciação do componente
    uut: T_count
        port map (
            D_count => D_count,
            P_count => P_count,
            T       => T
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- D = 20, P = 6 → T = 14
        D_count <= "000010100";  -- 20
        P_count <= "0000110";    -- 6
        wait for 10 ns;

        -- D = 50, P = 50 → T = 0
        D_count <= "000110010";  -- 50
        P_count <= "0110010";    -- 50
        wait for 10 ns;

        -- D = 100, P = 25 → T = 75
        D_count <= "001100100";  -- 100
        P_count <= "0011001";    -- 25
        wait for 10 ns;

        -- D = 127, P = 0 → T = 127
        D_count <= "011111111";
        P_count <= "0000000";
        wait for 10 ns;

        -- D = 0, P = 0 → T = 0
        D_count <= "000000000";
        P_count <= "0000000";
        wait for 10 ns;

        wait;
    end process;

end behavior;
