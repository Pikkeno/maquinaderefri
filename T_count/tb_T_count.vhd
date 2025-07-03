library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_T_count is
end tb_T_count;

architecture behavior of tb_T_count is

    -- Componente a ser testado
    component T_count
        Port (
            D_count : in  STD_LOGIC_VECTOR(3 downto 0);
            P_count : in  STD_LOGIC_VECTOR(3 downto 0);
            T       : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Sinais
    signal D_count : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal P_count : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal T       : STD_LOGIC_VECTOR(3 downto 0);

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
        -- D = 10, P = 6 → T = 4
        D_count <= "1010";  -- 10
        P_count <= "0110";  -- 6
        wait for 10 ns;

        -- D = 15, P = 15 → T = 0
        D_count <= "1111";
        P_count <= "1111";
        wait for 10 ns;

        -- D = 8, P = 3 → T = 5
        D_count <= "1000";
        P_count <= "0011";
        wait for 10 ns;

        -- D = 0, P = 0 → T = 0
        D_count <= "0000";
        P_count <= "0000";
        wait for 10 ns;

        wait;
    end process;

end behavior;
