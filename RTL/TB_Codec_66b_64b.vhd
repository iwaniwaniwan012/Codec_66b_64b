library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity TB_Codec_66b_64b is
end entity;

architecture behavioral of TB_Codec_66b_64b is

constant T : time := 10 ns;

signal Clk 		: std_logic := '0';
signal Reset	: std_logic;
signal Reset_Test : std_logic := '0';

signal wire_enc_data_h_in		: std_logic_vector(1 downto 0) := (others => '0');
signal wire_enc_data_in			: std_logic_vector(63 downto 0) := (others => '0');
signal wire_enc_busy_out		: std_logic;
signal wire_enc_data_out		: std_logic_vector(63 downto 0);

signal wire_dec_en_out			: std_logic;
signal wire_dec_data_h_out		: std_logic_vector(1 downto 0);
signal wire_dec_data_out		: std_logic_vector(63 downto 0);

signal Counter 					: std_logic_vector(3 downto 0) := x"0";
signal Counter_As_Data 			: std_logic_vector(63 downto 0) := (others => '0');

signal Data_Test 					: std_logic_vector(63 downto 0);
signal Data_Test_Ok				: std_logic;

begin

Clk 	<= not Clk after T/2;
Reset <= '1', '0' after T*10;

	m_enc: entity work.Encoder_66b_64b
		port map (
			Clk 			=>	Clk,									--: in std_logic;
			Reset 		=>	Reset,								--: in std_logic;
			Data_H_In	=>	wire_enc_data_h_in,				--: in std_logic_vector(1 downto 0);
			Data_In		=>	wire_enc_data_in,					--: in std_logic_vector(63 downto 0);
			Busy_Out		=>	wire_enc_busy_out,				--: out std_logic;
			Data_Out		=>	wire_enc_data_out					--: out std_logic_vector(63 downto 0)
		);
	
	m_dec: entity work.Decoder_66b_64b
		port map (
			Clk 			=>	Clk,									--: in std_logic;
			Reset 		=>	Reset,								--: in std_logic;
			Data_In		=>	wire_enc_data_out,				--: in std_logic_vector(63 downto 0);
			En_Out		=>	wire_dec_en_out,					--: out std_logic;
			Data_H_Out	=>	wire_dec_data_h_out,				--: out std_logic_vector(1 downto 0);
			Data_Out		=>	wire_dec_data_out					--: out std_logic_vector(63 downto 0)
		);

	DUT_TX: process(Clk)
		begin
			if Rising_Edge(Clk) then
				if Reset = '1' then
					Counter <= (others => '0');
					Counter_As_Data <= (others => '0');
				else
					if wire_enc_busy_out = '0' then
						Counter_As_Data <= Counter_As_Data + '1';
						if Counter = x"F" then
							Counter <= x"0";
							wire_enc_data_h_in <= "01";
						else
							wire_enc_data_h_in <= "10";
							Counter <= Counter + '1';
						end if;
						wire_enc_data_in 		<= Counter_As_Data;
					end if;
				end if;
			end if;
	end process;
	
	DUT_RX: process(Clk)
		begin
			if Rising_Edge(Clk) then
				if Reset = '1' then
					Data_Test <= (others => '0');
				else
					if wire_dec_en_out = '1' then
						Data_Test <= wire_dec_data_out;
						if (wire_dec_data_out - '1') = Data_Test then
							Data_Test_Ok <= '1';
						else
							Data_Test_Ok <= '0';
						end if;
					end if;
				end if;
			end if;
	end process;
	
	
end behavioral;