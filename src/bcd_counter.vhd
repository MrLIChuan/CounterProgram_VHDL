-- BCD_COUNTER.vhd
-- ---------------------------------------
--   Squelette du compteur BCD
-- ---------------------------------------
--
-- Compter de 0000 � 9999 et repartir de 0000
-- Le comptage doit se faire a chaque N ms, 
-- pour cela, on utilise le signal TICK1MS


library IEEE;
  use IEEE.std_logic_1164.ALL;
  use IEEE.numeric_std.ALL;


---------------------------------------
entity BCD_COUNTER is
---------------------------------------
generic ( N  : positive := 8 );  -- facteur de division de Tick1ms
  port ( CLK        : in  std_logic;
         RST        : in  std_logic;
         TICK1MS    : in  std_logic;
         UNITIES    : out std_logic_vector(3 downto 0);
         TENS       : out std_logic_vector(3 downto 0);
         HUNDREDS   : out std_logic_vector(3 downto 0);
         THOUSNDS   : out std_logic_vector(3 downto 0));
end entity;


---------------------------------------
architecture RTL of BCD_COUNTER is
---------------------------------------

-- On d�clare les signaux internes ici

  signal cpt : integer;
  signal unit : std_logic_vector(3 downto 0);
  signal ten : std_logic_vector(3 downto 0);
  signal hun : std_logic_vector(3 downto 0);
  signal thous : std_logic_vector(3 downto 0);

begin

-- Vous pouvez faire les assignements concurrents ici

process(RST,CLK)

begin
  if RST = '1' then

    -- initialiser tout vos signaux ici
    cpt <= 0;
    UNITIES  <= "0000";
    TENS     <= "0000";
    HUNDREDS <= "0000";
    THOUSNDS <= "0000";

  elsif rising_edge(CLK) then
    
    -- Faites toutes vos actions synchrones ici
    if TICK1MS = '1' then 
        cpt <= cpt + 1;
      if cpt = N then
         cpt <= 0;    
        if (unit /= "1001") then
            unit <= std_logic_vector(unsigned(unit) +1);
        else
              unit <= "0000";
              ten <= std_logic_vector(unsigned(ten) +1);
              if (ten = "1001" ) then
                  ten <= "0000";
                  hun <= std_logic_vector(unsigned(hun) +1);
                  if (hun = "1001" ) then
                    hun<="0000";
                    thous <= std_logic_vector(unsigned(thous) +1);
                                 if (thous = "1001") then
                                  unit <= "0000";
                                  ten <= "0000";
                                  hun <= "0000";
                                  thous <= "0000";        
                                end if;
                  end if;
              end if;
      end if;
    end if;
   end if;
     

UNITIES <= unit;
TENS <= ten;
HUNDREDS <= hun;
THOUSNDS <= thous;

end if;
end process;

end architecture;

