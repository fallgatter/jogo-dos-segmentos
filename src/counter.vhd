--made by murico

library IEEE;
  use ieee.std_logic_1164.all;
  use ieee.STD_LOGIC_UNSIGNED.all;
  use ieee.NUMERIC_STD.all;

entity counter is
  generic(
    size : integer := 4;
    resetvalue: integer := 16;
    startingvalue: integer := 0
         );
  port (
    clk : in std_logic;
    reset : in std_logic := '1';
    O : out std_logic_vector (size-1 downto 0);
    enable : in std_logic := '1';
	 reset_o: out std_logic := '0'
       );
end counter;


architecture behavior of counter is
signal count : std_logic_vector (size-1 downto 0) := std_logic_vector(to_unsigned(startingvalue, size));
signal tReset: std_logic := '0';
signal tResetReach: std_logic := '0';
  begin
  tReset <= not reset;
    process(clk, count, tReset)
      begin
        if (tReset = '1' or tResetReach = '1') then
          count <= (others => '0');
          tResetReach <= '0';
        elsif (enable = '1') then
          if (rising_edge(clk)) then
            count <= count + 1;
          end if;
          if (unsigned(count) = resetvalue) then
            tResetReach <= '1';
          end if;
        end if;
    end process;
    O (size-1 downto 0) <= count (size-1 downto 0); 
	 reset_o<=tResetReach;
end behavior;
