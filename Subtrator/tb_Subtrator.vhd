library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Subtrator is
end tb_Subtrator;

architecture behavior of tb_Subtrator is

    -- Componente a ser testado
    component Subtrator
        Port (
            D : in  STD_LOGIC_VECTOR(8 downto 0); -- Dinheiro inserido
            P : in  STD_LOGIC_VECTOR(8 downto 0); -- Preço
            T : out STD_LOGIC_VECTOR(8 downto 0)  -- Troco
        );
    end component;

    -- Sinais
    signal D : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
    signal P : STD_LOGIC_VECTOR(8 downto 0) := (others => '0');
    signal T : STD_LOGIC_VECTOR(8 downto 0);

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
        -- D = 20, P = 6 → T = 14
        D <= "000010100"; -- 20
        P <= "000000110"; -- 6
        wait for 10 ns;

        -- D = 50, P = 50 → T = 0
        D <= "000110010"; -- 50
        P <= "000110010"; -- 50
        wait for 10 ns;

        -- D = 100, P = 25 → T = 75
        D <= "001100100"; -- 100
        P <= "000011001"; -- 25
        wait for 10 ns;

        -- D = 127, P = 0 → T = 127
        D <= "011111111"; -- 127
        P <= "000000000"; -- 0
        wait for 10 ns;

        -- D = 0, P = 0 → T = 0
        D <= "000000000";
        P <= "000000000";
        wait for 10 ns;

        wait;
    end process;

end behavior;
