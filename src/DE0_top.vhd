

LIBRARY ieee;
USE ieee.std_logic_1164.all; 



ENTITY DE0_top is
	PORT
	(
		CLOCK_50 	:  IN  STD_LOGIC;
		KEY			 	:  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		SW 				:  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
		HEX0 			:  OUT  STD_LOGIC_VECTOR(0 TO 6);
		HEX1 			:  OUT  STD_LOGIC_VECTOR(0 TO 6);
		HEX2 			:  OUT  STD_LOGIC_VECTOR(0 TO 6);
		HEX3 			:  OUT  STD_LOGIC_VECTOR(0 TO 6)
	);
END entity;

ARCHITECTURE RTL OF DE0_top IS 

	signal 	rst,clk, pol  : std_logic;
	signal FDIV_BCD_TICK1ms : std_logic;
  signal TOP_unit : std_logic_vector(3 downto 0);
  signal TOP_ten : std_logic_vector(3 downto 0);
  signal TOP_hun : std_logic_vector(3 downto 0);
  signal TOP_thous : std_logic_vector(3 downto 0);
	

BEGIN 

rst <= not KEY(0);
clk <= CLOCK_50; 
pol <= SW(9);

F : entity WORK.FDIV(RTL) port map (
 Tick1ms => FDIV_BCD_TICK1ms,
 CLK => clk,
 RST => rst
);



C : entity WORK.BCD_COUNTER(RTL) port map (

UNITIES => TOP_unit,
TENS => TOP_ten,
HUNDREDS => TOP_hun,
THOUSNDS => TOP_thous,
TICK1MS => FDIV_BCD_TICK1ms,
CLK => clk,
RST => rst

);

SEG_U : entity WORK.SEVEN_SEG(COMB) port map (
Pol=> pol,
Data=> TOP_unit,
Segout => HEX0

);

SEG_TEN : entity WORK.SEVEN_SEG(COMB) port map (
Pol=> pol,
Data=>TOP_ten,
Segout => HEX1

);

SEG_HUN : entity WORK.SEVEN_SEG(COMB) port map (
Pol=> pol,
Data=>TOP_hun,
Segout => HEX2
);

SEG_THOUS : entity WORK.SEVEN_SEG(COMB) port map (
Pol=> pol,
Data=>TOP_thous,
Segout => HEX3
);


END architecture;