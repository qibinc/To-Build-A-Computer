library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Registers is
    generic (
        delay: time
    );
    port (
        clk: in std_logic;
        
    -- IN
        rx, ry: in std_logic_vector(3 downto 0);
        register_from_write_back: in std_logic_vector(3 downto 0);
        data_from_write_back: in std_logic_vector(15 downto 0);

        control_reg_write: in std_logic;

    -- OUT
        rx_val: out std_logic_vector(15 downto 0);
        ry_val: out std_logic_vector(15 downto 0);
        reg_t_val: out std_logic_vector(15 downto 0);
        reg_sp_val: out std_logic_vector(15 downto 0);
        reg_ih_val: out std_logic_vector(15 downto 0)
    );
end Registers;

architecture Registers_bhv of Registers is
    type RegisterArray is array (15 downto 0) of std_logic_vector(15 downto 0);
    signal elements: RegisterArray;

    signal index_rx: integer := 0;
    signal index_ry: integer := 0;
    signal index_write_back: integer := 0;

    function toIndex(rank: std_logic_vector(3 downto 0)) return integer is
    begin
        case rank is
            when "0000" => return 0;
            when "0001" => return 1;
            when "0010" => return 2;
            when "0011" => return 3;
            when "0100" => return 4;
            when "0101" => return 5;
            when "0110" => return 6;
            when "0111" => return 7;
            when "1000" => return 8;
            when "1001" => return 9;
            when "1010" => return 10;
            when "1011" => return 11;
            when "1100" => return 12;
            when "1101" => return 13;
            when "1110" => return 14;
            when "1111" => return 15;
            when others => return 0;
        end case;
        return 0;
    end toIndex;

begin
    index_rx <= toIndex(rx);
    index_ry <= toIndex(ry);
    index_write_back <= toIndex(register_from_write_back);

    process (clk)
    begin
        if clk'event and clk = '1' then
            if (control_reg_write = '1') then
                elements(index_write_back) <= data_from_write_back after delay;
            end if;
            rx_val <= elements(index_rx) after delay + delay;
            ry_val <= elements(index_ry) after delay + delay;
            reg_t_val <= elements(8);
            reg_sp_val <= elements(9);
            reg_ih_val <= elements(10);
        end if;
    end process;

end Registers_bhv;