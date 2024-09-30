-- Autor: Pedro Henrique Chagas Fallgatter
-- Data: 06/06/2024

Library ieee; 
use ieee.std_logic_1164.all; 

entity personagem is
	port(
		en, key0, key1: in STD_LOGIC;
		a, d, g: out STD_LOGIC
	);
end personagem;

architecture arquitetura of personagem is
	signal or2 : std_logic;
	type ESTADOS is (s0, s1, s2);
	signal estado: ESTADOS;
	signal saida: STD_LOGIC_VECTOR(2 downto 0);
	
begin
	or2 <= (key0 or key1);
	process(estado)
	begin
		if(en='1') then
			case estado is --1=seg apagado, 0=seg acesso
				when s0=>
					saida<="101"; --MEIO
				when s1=>
					saida<="011"; --CIMA
				when s2=>
					saida<="110"; --BAIXO
			end case;
		end if;
	end process;
	
	process(or2)
	begin
		if(falling_edge(or2) and en='1') then 
			if(key0='1') then --CIMA --isso aqui não faz sentido, como que key0 é 1
				case estado is
					when s0=>estado<=s1;
					when s1=>estado<=s1;
					when s2=>estado<=s0;
				end case;
			elsif(key1='0') then --BAIXO
				case estado is
					when s0=>estado<=s2;
					when s2=>estado<=s2;
					when s1=>estado<=s0;
				end case;
			end if;
		end if;
	end process;
	
	
	a<=saida(2);
	d<=saida(0);
	g<=saida(1);
	
end arquitetura;