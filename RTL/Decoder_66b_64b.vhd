library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.all;

entity Decoder_66b_64b is
	port (
		Clk 			: in std_logic;
		Reset 		: in std_logic;
		Data_In		: in std_logic_vector(63 downto 0);
		En_Out		: out std_logic;
		Data_H_Out	: out std_logic_vector(1 downto 0);
		Data_Out		: out std_logic_vector(63 downto 0)
	);
end entity;
architecture behavioral of Decoder_66b_64b is

signal wire_conv_data_out	: std_logic_vector(65 downto 0);
signal wire_conv_en_out		: std_logic;

signal wire_syn_syn_out		: std_logic;
signal wire_syn_en_out		: std_logic;
signal wire_syn_data_h_out	: std_logic_vector(1 downto 0);
signal wire_syn_data_out	: std_logic_vector(63 downto 0);



begin

	m_conv: entity work.Conv_64b_66b
		port map (
			Clk 				=> Clk,							--: in std_logic;
			Reset 			=> Reset,						--: in std_logic;
			Data_In			=> Data_In,						--: in std_logic_vector(63 downto 0);
			Data_Out			=> wire_conv_data_out,		--: out std_logic_vector(65 downto 0);
			En_Out			=> wire_conv_en_out			--: out std_logic
		);
		
	m_syn: entity work.Syn_66b_64b
		port map (
			Clk 				=> Clk,							--: in std_logic;
			Reset 			=> Reset,						--: in std_logic;
			En_In				=> wire_conv_en_out,			--: in std_logic;
			Data_In			=> wire_conv_data_out,		--: in std_logic_vector(65 downto 0);
			Syn_Out			=> wire_syn_syn_out,			--: out std_logic;
			En_Out			=> wire_syn_en_out,			--: out std_logic;
			Data_H_Out		=> wire_syn_data_h_out,		--: out std_logic_vector(1 downto 0);
			Data_Out			=> wire_syn_data_out			--: out std_logic_vector(63 downto 0)
		);
	
	m_descr: entity work.Descr_66b_64b
		port map (
			Clk 				=> Clk,							--: in std_logic;
			Reset 			=> Reset,						--: in std_logic;
			En_In				=> wire_syn_en_out,			--: in std_logic;
			Data_H_In		=> wire_syn_data_h_out,		--: in std_logic_vector(1 downto 0);
			Data_In			=> wire_syn_data_out,		--: in std_logic_vector(63 downto 0);
			En_Out			=> En_Out,						--: out std_logic;
			Data_H_Out		=> Data_H_Out,					--: out std_logic_vector(1 downto 0);
			Data_Out			=> Data_Out						--: out std_logic_vector(63 downto 0)
		);

end behavioral; 
