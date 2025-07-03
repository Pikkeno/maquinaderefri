library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplicador is
    Port (
        preco_unitario : in STD_LOGIC_VECTOR(3 downto 0); -- P1 ou P2
        quantidade     : in STD_LOGIC_VECTOR(1 downto 0); -- Q_count
        resultado      : out STD_LOGIC_VECTOR(3 downto 0) -- P = preço total
    );
end Multiplicador;

architecture Behavioral of Multiplicador is
begin
    process(preco_unitario, quantidade)
        variable preco_int : unsigned(3 downto 0);
        variable qtd_int   : unsigned(1 downto 0);
        variable prod      : unsigned(5 downto 0);
        variable prod_sat  : unsigned(3 downto 0);
    begin
        preco_int := unsigned(preco_unitario);
        qtd_int   := unsigned(quantidade);
        prod := preco_int * qtd_int;
        if prod > 15 then
            prod_sat := to_unsigned(15, 4);
        else
            prod_sat := resize(prod, 4);
        end if;
        resultado <= std_logic_vector(prod_sat);
    end process;
end Behavioral;
