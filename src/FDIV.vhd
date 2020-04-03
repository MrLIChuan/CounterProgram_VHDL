-- FDIV.vhd
-- ---------------------------------------
--   Frequency Divider for DE0
-- ---------------------------------------
--
-- Note : Only Tick1ms is used in this exercise.
--        you can leave the other outputs unconnected.

LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

-- ---------------------------------------
    Entity FDIV is
-- ---------------------------------------
   Generic (  Fclock : positive := 50E6); -- System Clock Freq in Hertz
      Port (     CLK : In  std_logic;
                 RST : In  std_logic;
             Tick1us : Out std_logic;
             Tick4us : Out std_logic;
            Tick10us : Out std_logic;
             Tick1ms : Out std_logic;
            Tick10ms : Out std_logic  );
end FDIV;

-- ---------------------------------------
    Architecture RTL of FDIV is
-- ---------------------------------------

constant Divisor_us : positive := Fclock  / 1E6;
signal Count1     : integer range 0 to Divisor_us;
signal Count3     : integer range 0 to 9;
signal Count2     : integer range 0 to 100;
signal Count4     : integer range 0 to 9;
signal Count5     : integer range 0 to 9;
signal Tick1us_i  : std_logic;
signal Tick4us_i  : std_logic;
signal Tick10us_i : std_logic;
signal Tick1ms_i  : std_logic;
signal Tick10ms_i  : std_logic;

-- -------------------------------------

begin

Tick1us  <= Tick1us_i;
Tick4us  <= Tick4us_i;
Tick10us <= Tick10us_i;
Tick1ms  <= Tick1ms_i;
Tick10ms <= Tick10ms_i;

process (RST,CLK)
begin
  if RST='1' then
    Count1     <= 0;
    Count2     <= 0;
    Count3     <= 0;
    Count4     <= 0;
    Count5     <= 0;
    Tick1us_i  <= '0';
    Tick4us_i  <= '0';
    Tick10us_i <= '0';
    Tick1ms_i  <= '0';
    Tick10ms_i <= '0';

  elsif rising_edge (CLK) then

    Tick1us_i  <= '0';
    Tick4us_i  <= '0';
    Tick10us_i <= '0';
    Tick1ms_i  <= '0';
    Tick10ms_i <= '0';

    if Count1 < Divisor_us-1 then
      Count1 <= Count1 + 1;
    else
      Count1 <= 0;
      Tick1us_i <= '1';
    end if;

    if Tick1us_i='1' then
      if Count3 < 9 then
        Count3 <= Count3 + 1;
      else
        Count3 <= 0;
        Tick10us_i <= '1';
      end if;
    end if;

    if Tick1us_i='1' then
      if Count4 < 3 then
        Count4 <= Count4 + 1;
      else
        Count4 <= 0;
        Tick4us_i <= '1';
      end if;
    end if;

    if Tick10us_i='1' then
      if Count2 < 99  then
        Count2 <= Count2 + 1;
      else
        Count2 <= 0;
        Tick1ms_i <= '1';
        if Count5=9 then
          Tick10ms_i <= '1';
          Count5 <= 0;
        else
          Count5 <= Count5 + 1;
        end if;
      end if;
    end if;


  end if;
end process;

end RTL;

