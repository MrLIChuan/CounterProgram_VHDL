-- SevenSeg.vhd
-- ------------------------------
--   squelette de l'encodeur sept segment
-- ------------------------------

--
-- Notes :
--  * We don't ask for an hexadecimal decoder, only 0..9
--  * outputs are active high if Pol='1'
--    else active low (Pol='0')
--  * Order is : Segout(0)=Seg_A, ... Segout(6)=Seg_G
--
--  * Display Layout :
--
--       A=Seg(0)
--      -----
--    F|     |B=Seg(1)
--     |  G  |
--      -----
--     |     |C=Seg(2)
--    E|     |
--      -----
--        D=Seg(3)


library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

-- ------------------------------
Entity SEVEN_SEG is
-- ------------------------------
  port ( Data   : in  std_logic_vector(3 downto 0); -- Expected within 0 .. 9
         Pol    : in  std_logic;                    -- '0' if active LOW
         Segout : out std_logic_vector(0 to 6) );   -- Segments A, B, C, D, E, F, G
end entity;

-- -----------------------------------------------
Architecture COMB of SEVEN_SEG is
-- ------------------------------------------------

begin
	process(Data, Pol)
begin
if Pol = '0' then 
   if Data = "0000" then
   Segout <= "0000001"; ---0
   elsif Data = "0001" then
   Segout <= "1001111"; ---1
   elsif Data = "0010" then
   Segout <= "0010010"; ---2
   elsif Data = "0011" then
   Segout <= "0000110"; ---3
   elsif Data = "0100" then
   Segout <= "1001100"; ---4
   elsif Data = "0101" then
   Segout <= "0100100"; ---5
   elsif Data = "0110" then
   Segout <= "0100000"; ---6
   elsif Data = "0111" then
   Segout <= "0001111"; ---7
   elsif Data = "1000" then
   Segout <= "0000000"; ---8
   else 
   Segout <= "0000100"; ---9
   end if;
else
   if Data = "0000" then
   Segout <= "1111110"; ---0
   elsif Data = "0001" then
   Segout <= "0110000"; ---1
   elsif Data = "0010" then
   Segout <= "1101101"; ---2
   elsif Data = "0011" then
   Segout <= "1111001"; ---3
   elsif Data = "0100" then
   Segout <= "0110011"; ---4
   elsif Data = "0101" then
   Segout <= "1011011"; ---5
   elsif Data = "0110" then
   Segout <= "1011111"; ---6
   elsif Data = "0111" then
   Segout <= "1110000"; ---7
   elsif Data = "1000" then
   Segout <= "1111111"; ---8
   else
   Segout <= "1111011"; ---9
   end if;

end if;
end process;
			 

end architecture;

