library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Somador is
end tb_Somador;

architecture behavior of tb_Somador is

    -- Componente a ser testado
    component Somador
        Port (
            L_count : in  STD_LOGIC_VECTOR (8 downto 0);
            P_count : in  STD_LOGIC_VECTOR (6 downto 0);
            S       : out STD_LOGIC_VECTOR (8 downto 0)
        );
    end component;

    -- Sinais de estímulo
    signal L_count : STD_LOGIC_VECTOR (8 downto 0) := (others => '0');
    signal P_count : STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
    signal S       : STD_LOGIC_VECTOR (8 downto 0);

begin

    -- Instanciação do componente
    uut: Somador
        port map (
            L_count => L_count,
            P_count => P_count,
            S       => S
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- L = 0, P = 5 => S = 5
        L_count <= "000000000";
        P_count <= "0000101"; -- 5
        wait for 10 ns;

        -- L = 10, P = 6 => S = 16
        L_count <= "000001010";
        P_count <= "0000110"; -- 6
        wait for 10 ns;

        -- L = 255, P = 3 => S = 258
        L_count <= "011111111";
        P_count <= "0000011"; -- 3
        wait for 10 ns;

        -- L = 511, P = 10 => S = 521
        L_count <= "111111111";
        P_count <= "0001010"; -- 10
        wait for 10 ns;

        wait;
    end process;

end behavior;
