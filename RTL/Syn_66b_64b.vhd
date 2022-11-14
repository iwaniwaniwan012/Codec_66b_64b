library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Syn_66b_64b is
	port (
		Clk 				: in std_logic;
		Reset 			: in std_logic;
		En_In				: in std_logic;
		Data_In			: in std_logic_vector(65 downto 0);
		Syn_Out			: out std_logic;
		En_Out			: out std_logic;
		Data_H_Out		: out std_logic_vector(1 downto 0);
		Data_Out			: out std_logic_vector(63 downto 0)
	);
end entity;
architecture behavioral of Syn_66b_64b is

signal FindSync	: std_logic;
signal ShiftReg 	: std_logic_vector(66+65 downto 0) := (others => '0');
signal Shift		: std_logic_vector(5 downto 0);
signal ShiftAdd	: std_logic_vector(1 downto 0);
signal FrameCount	: std_logic_vector(9 downto 0);
signal HdrErr		: std_logic_vector(5 downto 0);

signal Data_H_Tmp	: std_logic_vector(1 downto 0);
signal Data_Tmp	: std_logic_vector(63 downto 0);

begin
	process(Clk)
		begin
			if Rising_Edge(Clk) then
				if Reset = '1' then
					FindSync <= '0';
					En_Out 	<= '0';
					Syn_Out	<= '0';
					Shift			<= (others => '0');
					ShiftAdd		<= (others => '0');
					FrameCount	<= (others => '0');
					HdrErr		<= (others => '0');
				else
					if En_In = '1' then
						ShiftReg <= Data_In & ShiftReg(131 downto 66);
						if FindSync = '0' then
							Syn_Out <= '0';
							if FrameCount(6 downto 0) = "1111111" then
								FrameCount 	<= (others => '0');
								HdrErr		<= (others => '0');
								if HdrErr /= "00000" then
									if Shift = "111111" then
										case ShiftAdd is
											when "00" =>
												ShiftAdd <= "10";
											when "10" =>
												ShiftAdd <= "11";
											when "11" =>
												ShiftAdd <= "00";
												Shift 	<= (others => '0');
											when others => NULL;
										end case;
									else
										Shift <= Shift + '1';
									end if;
								else
									FindSync <= '1';
								end if;
							else
								FrameCount <= FrameCount + '1';
								if Data_H_Tmp = "11" or Data_H_Tmp = "00" then
									if HdrErr /= "11111" then
										HdrErr <= HdrErr + '1';
									end if;
								end if;
							end if;
						else
							Syn_Out <= '1';
							if FrameCount = "1111111111" then
								FrameCount <= (others => '0');
								if HdrErr = "11111" then
									FindSync <= '0';
								end if;
								HdrErr <= (others => '0');
							else
								FrameCount <= FrameCount + '1';
								if Data_H_Tmp = "11" or Data_H_Tmp = "00" then
									if HdrErr /= "11111" then
										HdrErr <= HdrErr + '1';
									end if;
								end if;
							end if;
							En_Out 		<= '1';
						end if;
						Data_H_Out	<= Data_H_Tmp;
						Data_Out 	<= Data_Tmp;
						if ShiftAdd(1) = '1' then
							if ShiftAdd(0) = '0' then
								Data_Tmp		<= ShiftReg(63+66 downto 66);
								Data_H_Tmp	<= ShiftReg(65 downto 64);
							else
								Data_Tmp		<= ShiftReg(63+67 downto 67);
								Data_H_Tmp	<= ShiftReg(66 downto 65);
							end if;
						else
							Data_Tmp		<= ShiftReg(63+2+conv_integer(Shift) downto 2+conv_integer(Shift));
							Data_H_Tmp	<= ShiftReg(1+conv_integer(Shift) downto 0+conv_integer(Shift));
						end if;
					else
						En_Out <= '0';
					end if;
				end if;	
			end if;
	end process;
end behavioral;