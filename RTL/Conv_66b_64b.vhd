library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Conv_66b_64b is
	port (
		Clk 		: in std_logic;
		Reset 	: in std_logic;
		Data_In	: in std_logic_vector(65 downto 0);
		Data_Out	: out std_logic_vector(63 downto 0);
		Busy_Out	: out std_logic
	);
end entity;
architecture behavioral of Conv_66b_64b is

signal Counter		: std_logic_vector(4 downto 0);
signal ShiftReg 	: std_logic_vector(63 downto 0);
signal Last			: std_logic;

begin
	process(Clk)
	variable i : integer range 0 to 31;
		begin
			if Rising_Edge(Clk) then
				if Reset = '1' then
					Counter 	<= (others => '0');
					Last		<= '0';
				else
					if Last = '1' then
						Last <= '0';
						Data_Out <= ShiftReg(63 downto 0);
					else
						case Counter is
							when "00000" =>
								ShiftReg(1 downto 0) 	<= Data_In(65 downto 64);
								Data_Out 					<= Data_In(63 downto 0);
							when "00001" =>
								ShiftReg(3 downto 0)	<= Data_In(65 downto 62);
								Data_Out	<= Data_In(61 downto 0) & ShiftReg(1 downto 0);
							when "00010" =>
								ShiftReg(5 downto 0)	<= Data_In(65 downto 60);
								Data_Out	<= Data_In(59 downto 0) & ShiftReg(3 downto 0);
							when "00011" =>
								ShiftReg(7 downto 0)	<= Data_In(65 downto 58);
								Data_Out	<= Data_In(57 downto 0) & ShiftReg(5 downto 0);
							when "00100" =>
								ShiftReg(9 downto 0)	<= Data_In(65 downto 56);
								Data_Out	<= Data_In(55 downto 0) & ShiftReg(7 downto 0);
							when "00101" =>
								ShiftReg(11 downto 0)	<= Data_In(65 downto 54);
								Data_Out	<= Data_In(53 downto 0) & ShiftReg(9 downto 0);
							when "00110" =>
								ShiftReg(13 downto 0)	<= Data_In(65 downto 52);
								Data_Out	<= Data_In(51 downto 0) & ShiftReg(11 downto 0);
							when "00111" =>
								ShiftReg(15 downto 0)	<= Data_In(65 downto 50);
								Data_Out	<= Data_In(49 downto 0) & ShiftReg(13 downto 0);
							when "01000" =>
								ShiftReg(17 downto 0)	<= Data_In(65 downto 48);
								Data_Out	<= Data_In(47 downto 0) & ShiftReg(15 downto 0);
							when "01001" =>
								ShiftReg(19 downto 0)	<= Data_In(65 downto 46);
								Data_Out	<= Data_In(45 downto 0) & ShiftReg(17 downto 0);
							when "01010" =>
								ShiftReg(21 downto 0)	<= Data_In(65 downto 44);
								Data_Out	<= Data_In(43 downto 0) & ShiftReg(19 downto 0);
							when "01011" =>
								ShiftReg(23 downto 0)	<= Data_In(65 downto 42);
								Data_Out	<= Data_In(41 downto 0) & ShiftReg(21 downto 0);
							when "01100" =>
								ShiftReg(25 downto 0)	<= Data_In(65 downto 40);
								Data_Out	<= Data_In(39 downto 0) & ShiftReg(23 downto 0);
							when "01101" =>
								ShiftReg(27 downto 0)	<= Data_In(65 downto 38);
								Data_Out	<= Data_In(37 downto 0) & ShiftReg(25 downto 0);
							when "01110" =>
								ShiftReg(29 downto 0)	<= Data_In(65 downto 36);
								Data_Out	<= Data_In(35 downto 0) & ShiftReg(27 downto 0);
							when "01111" =>
								ShiftReg(31 downto 0)	<= Data_In(65 downto 34);
								Data_Out	<= Data_In(33 downto 0) & ShiftReg(29 downto 0);
							when "10000" =>
								ShiftReg(33 downto 0)	<= Data_In(65 downto 32);
								Data_Out	<= Data_In(31 downto 0) & ShiftReg(31 downto 0);
							when "10001" =>
								ShiftReg(35 downto 0)	<= Data_In(65 downto 30);
								Data_Out	<= Data_In(29 downto 0) & ShiftReg(33 downto 0);
							when "10010" =>
								ShiftReg(37 downto 0)	<= Data_In(65 downto 28);
								Data_Out	<= Data_In(27 downto 0) & ShiftReg(35 downto 0);
							when "10011" =>
								ShiftReg(39 downto 0)	<= Data_In(65 downto 26);
								Data_Out	<= Data_In(25 downto 0) & ShiftReg(37 downto 0);
							when "10100" =>
								ShiftReg(41 downto 0)	<= Data_In(65 downto 24);
								Data_Out	<= Data_In(23 downto 0) & ShiftReg(39 downto 0);
							when "10101" =>
								ShiftReg(43 downto 0)	<= Data_In(65 downto 22);
								Data_Out	<= Data_In(21 downto 0) & ShiftReg(41 downto 0);
							when "10110" =>
								ShiftReg(45 downto 0)	<= Data_In(65 downto 20);
								Data_Out	<= Data_In(19 downto 0) & ShiftReg(43 downto 0);
							when "10111" =>
								ShiftReg(47 downto 0)	<= Data_In(65 downto 18);
								Data_Out	<= Data_In(17 downto 0) & ShiftReg(45 downto 0);
							when "11000" =>
								ShiftReg(49 downto 0)	<= Data_In(65 downto 16);
								Data_Out	<= Data_In(15 downto 0) & ShiftReg(47 downto 0);
							when "11001" =>
								ShiftReg(51 downto 0)	<= Data_In(65 downto 14);
								Data_Out	<= Data_In(13 downto 0) & ShiftReg(49 downto 0);
							when "11010" =>
								ShiftReg(53 downto 0)	<= Data_In(65 downto 12);
								Data_Out	<= Data_In(11 downto 0) & ShiftReg(51 downto 0);
							when "11011" =>
								ShiftReg(55 downto 0)	<= Data_In(65 downto 10);
								Data_Out	<= Data_In(9 downto 0) & ShiftReg(53 downto 0);
							when "11100" =>
								ShiftReg(57 downto 0)	<= Data_In(65 downto 8);
								Data_Out	<= Data_In(7 downto 0) & ShiftReg(55 downto 0);
							when "11101" =>
								ShiftReg(59 downto 0)	<= Data_In(65 downto 6);
								Data_Out	<= Data_In(5 downto 0) & ShiftReg(57 downto 0);
							when "11110" =>
								ShiftReg(61 downto 0)	<= Data_In(65 downto 4);
								Data_Out	<= Data_In(3 downto 0) & ShiftReg(59 downto 0);
								Busy_Out <= '1';
							when "11111" =>
								ShiftReg(63 downto 0)	<= Data_In(65 downto 2);
								Data_Out	<= Data_In(1 downto 0) & ShiftReg(61 downto 0);
								Busy_Out <= '0';
							when others =>
								NULL;
						end case;
						if Counter = "11111" then
							Counter 	<= (others => '0');
							Last 		<= '1';
						else
							Counter 	<= Counter + '1';
							Last 		<= '0';
						end if;
					end if;
				end if;	
			end if;
	end process;
end behavioral;