library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_Subtrator is
end tb_Subtrator;

architecture behavior of tb_Subtrator is

    -- Componente a ser testado
    component Subtrator
        Port (
            D : in  STD_LOGIC_VECTOR(4 downto 0); -- Dinheiro inserido
            P : in  STD_LOGIC_VECTOR(4 downto 0); -- Preço
            T : out STD_LOGIC_VECTOR(4 downto 0)  -- Troco
        );
    end component;

    -- Sinais
    signal D : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal P : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal T : STD_LOGIC_VECTOR(4 downto 0);

begin

    -- Instanciação da unidade sob teste
    uut: Subtrator
        port map (
            D => D,
            P => P,
            T => T
        );

    -- Processo de estímulo
    stim_proc: process
    begin
        -- D = 10, P = 6 → T = 4
        D <= "01010"; -- 10
        P <= "00110"; -- 6
        wait for 10 ns;

        -- D = 8, P = 8 → T = 0
        D <= "01000"; -- 8
        P <= "01000"; -- 8
        wait for 10 ns;

        -- D = 5, P = 2 → T = 3
        D <= "00101"; -- 5
        P <= "00010"; -- 2
        wait for 10 ns;

        -- D = 31, P = 1 → T = 30 (máximo valor)
        D <= "11111"; -- 31
        P <= "00001"; -- 1
        wait for 10 ns;

        -- D = 0, P = 0 → T = 0
        D <= "00000";
        P <= "00000";
        wait for 10 ns;

        wait;
    end process;

end behavior;
