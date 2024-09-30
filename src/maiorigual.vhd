-- Autor: Pedro Henrique Chagas Fallgatter
-- Data: 14/06/2024

library IEEE;
  use ieee.std_logic_1164.all;
  use ieee.STD_LOGIC_UNSIGNED.all;
  use ieee.NUMERIC_STD.all;

entity maiorigual is
  port (
    num1: in std_logic_vector (4 downto 0);
    num2: in std_logic_vector (4 downto 0);
	 num1_maiorigualque_num2: out std_logic := '0'
       );
end maiorigual;


architecture behavior of maiorigual is
	signal maior_ou_igual: std_logic :='0';
begin
	process(num1, num2)
	begin
		if(num1(4)>=num2(4) and num1(3)>=num2(3) and num1(2)>=num2(2) and num1(1)>=num2(1) and num1(0)>=num2(0)) then
			maior_ou_igual<='1';
		else
			maior_ou_igual<='0';
		end if;
	end process;

	num1_maiorigualque_num2<=maior_ou_igual;
end behavior;
