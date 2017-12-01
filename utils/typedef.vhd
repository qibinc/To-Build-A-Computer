library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package utils is

    type type_ram_pin is record
        address: std_logic_vector(17 downto 0);
        oe, we, en: std_logic;
    end record type_ram_pin;
    type type_mem_state is (mem_st1, mem_st2);


    type type_control_ex is record
        branch_op: std_logic_vector(2 downto 0);
        rx_src: std_logic_vector(2 downto 0);
        ry_src: std_logic;
        reg_dst: std_logic_vector(2 downto 0);
        alu_op: std_logic_vector(3 downto 0);
        branch: std_logic;
    end record type_control_ex;
    constant type_control_ex_zero : type_control_ex := (
        branch_op => "000",
        rx_src => "000",
        ry_src => '0',
        reg_dst => "000",
        alu_op => "0000",
        branch => '0'
    );


    type type_control_mem is record
        mem_read: std_logic;
        mem_write: std_logic;
    end record type_control_mem;
    constant type_control_mem_zero : type_control_mem := (
        mem_read => '0',
        mem_write => '0'
    );


    type type_control_wb is record
        mem_to_reg: std_logic;
        reg_write: std_logic;
    end record type_control_wb;
    constant type_control_wb_zero : type_control_wb := (
        mem_to_reg => '1',
        reg_write => '0'
    );

end package utils;
