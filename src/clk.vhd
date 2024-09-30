library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity clock is
	port (
		clk_in, reset: in std_logic;
		clk_out: out std_logic
	);
end clock;
  
architecture freq_div of clock is
  
signal count, count_vel, vel : integer:=1;
signal tmp : std_logic := '0';
  
begin
	process(clk_in, reset)
	begin
		if(rising_edge(clk_in)) then
			count<=count+1;
			count_vel<=count_vel+1;
			if (count_vel = 50000000*10 and vel<=10) then
				vel<=vel+1;
				count_vel<=1;
			end if;
			if (count = 50000000/(1+vel)) then
				tmp<=NOT tmp;
				count<=1;
			end if;
			if(reset='1') then
				vel<=1;
			end if;
		end if;
		clk_out <= tmp;
	end process;

end freq_div;