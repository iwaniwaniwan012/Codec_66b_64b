library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.ALL;

entity Descr_66b_64b is
	port (
		Clk 			: in std_logic;
		Reset 		: in std_logic;
		En_In			: in std_logic;
		Data_H_In	: in std_logic_vector(1 downto 0);
		Data_In		: in std_logic_vector(63 downto 0);
		En_Out		: out std_logic;
		Data_H_Out	: out std_logic_vector(1 downto 0);
		Data_Out		: out std_logic_vector(63 downto 0)
	);
end entity;
architecture behavioral of Descr_66b_64b is

begin
	process(Clk)
	variable ScrReg	: std_logic_vector(57 downto 0);
	variable Xorbit	: std_logic;
	variable DataReg	: std_logic_vector(63 downto 0);
		begin
			if Rising_Edge(Clk) then
				if Reset = '1' then
					ScrReg 	:= (others => '0');
					XorBit 	:= '0';
				else
					if En_In = '1' then
						for i in 0 to 63 loop
							XorBit 		:= Data_In(i) xor ScrReg(38) xor ScrReg(57);
							ScrReg 		:= ScrReg(56 downto 0) & Data_In(i);
							DataReg(i)  := XorBit; 
						end loop;
						En_Out 		<= '1';
						Data_H_Out 	<= Data_H_In;
						Data_Out 	<= DataReg;
					else
						En_Out <= '0';
					end if;
				end if;	
			end if;
	end process;
end behavioral; 
