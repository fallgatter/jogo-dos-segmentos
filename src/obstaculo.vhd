-- Autor: Pedro Henrique Chagas Fallgatter
-- Data: 07/06/2024

Library ieee; 
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;


entity obstaculo is
	port(
		en, clk, key0, key1: in STD_LOGIC;
		a, d, g: out STD_LOGIC
	);
end obstaculo;

architecture arquitetura of obstaculo is
	type ESTADOS is (s0, s1, s2, s3);
	signal estado: ESTADOS;
	signal saida: STD_LOGIC_VECTOR(2 downto 0) :=(others=>'0');
	signal clicks, cont: integer :=0;
	signal or2 : std_logic;
	
begin
	or2 <= (key0 or key1);
	process(or2)
	begin
		if(falling_edge(or2)) then
			clicks<=clicks+1;
		end if;
	end process;
	
	process(estado)
	begin
		if(en='1') then
			case estado is --0=seg apagado, 1=seg acesso
				when s0=>
					saida<="010"; --MEIO
				when s1=>
					saida<="100"; --CIMA
				when s2=>
					saida<="001"; --BAIXO
				when s3=>
					saida<="000"; --ESPAÇO
			end case;
		end if;
	end process;
	
	process(clk)
	variable y, y_old, y_old_old : integer :=0;
	begin
		cont<=(cont+1);
		if(falling_edge(clk) and en='1') then
			y_old_old:=y_old;
			y_old:=y;
			if(y=0) then
				estado<=s3;
			elsif(y=1) then
				estado<=s0;
			elsif(y=2) then
				if(y_old/=1 and y_old_old/=3) then
					estado<=s1;
				else
					estado<=s0;
					y:=1;
				end if;
			elsif(y=3) then
				if(y_old/=1 and y_old_old/=2) then
					estado<=s2;
				else
					estado<=s0;
					y:=1;
				end if;
			end if;
			y:=(clicks+cont) mod 4;
		end if;
	end process;
	
	
	a<=saida(2);
	d<=saida(0);
	g<=saida(1);
	
end arquitetura;