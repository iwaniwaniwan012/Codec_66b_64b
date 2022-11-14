library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.all;

entity Encoder_66b_64b is
	port (
		Clk 			: in std_logic;
		Reset 		: in std_logic;
		Data_H_In	: in std_logic_vector(1 downto 0);
		Data_In		: in std_logic_vector(63 downto 0);
		Busy_Out		: out std_logic;
		Data_Out		: out std_logic_vector(63 downto 0)
	);
end entity;
architecture behavioral of Encoder_66b_64b is

signal wire_conv_nbusy_out : std_logic;
signal wire_conv_busy_out	: std_logic;
signal wire_scr_data_out	: std_logic_vector(65 downto 0);

begin

Busy_Out <= wire_conv_busy_out;
wire_conv_nbusy_out <= not wire_conv_busy_out;

	m_scr: entity work.Scr_66b_64b
		port map (
			Clk 			=> Clk,								--: in std_logic;
			Reset 		=> Reset,							--: in std_logic;
			En_In			=> wire_conv_nbusy_out,			--: in std_logic;
			Data_H_In	=> Data_H_In,						--: in std_logic_vector(1 downto 0);
			Data_In		=>	Data_In,							--: in std_logic_vector(63 downto 0);
			Data_Out		=>	wire_scr_data_out				--: out std_logic_vector(65 downto 0)
		);
	
	m_conv: entity work.Conv_66b_64b
		port map (
			Clk 			=> Clk,								--: in std_logic;
			Reset 		=> Reset,							--: in std_logic;
			Data_In		=> wire_scr_data_out,			--: in std_logic_vector(65 downto 0);
			Data_Out		=> Data_Out,						--: out std_logic_vector(63 downto 0);
			Busy_Out		=> wire_conv_busy_out			--: out std_logic
	);

end behavioral; 
