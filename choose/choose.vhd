library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity choose is
port (clk_in : in  std_logic;
      sig : in std_logic;
		sig_out : out std_logic;
		clk_l : out std_logic;
		clk_h1 : out std_logic;
		clk_h2 : out std_logic;
		clk_m : out std_logic;
		clk_s : out std_logic;
		clk_hh : out std_logic;
		flag : out std_logic_vector(1 downto 0);
		led1 : out std_logic;
		led2 : out std_logic;
		led3 : out std_logic);
end choose;

architecture tt of choose is

signal t1: std_logic;
signal t2: std_logic;
signal t3: std_logic;
signal t4: std_logic;
signal t5: std_logic;
signal count: integer range 0 to 100000000;
signal count1: integer range 0 to 100000000;

begin
clk_l <= t2;
clk_h1 <= t5;
clk_h2 <= clk_in;
clk_s <= t3;
clk_m <= t4;
clk_hh <= clk_in;
sig_out <= sig;

process(clk_in)  --1MHz clock
variable cnt: integer range 0 to 50;
begin
 if(clk_in'event and clk_in = '1') then
  cnt:=cnt+1;
  if (cnt = 50) then
   cnt:=0;
  elsif (cnt <= 25) then
   t1<='1';
  else
   t1<='0';
  end if;
 end if;
end process;

process(t4)  --0.5Hz clock
variable cnt: integer range 0 to 1000;
begin
 if(t4'event and t4 = '1') then
  cnt:=cnt+1;
  if (cnt = 1000) then
   cnt:=0;
  elsif (cnt <= 500) then
   t2<='1';
  else
   t2<='0';
  end if;
 end if;
end process;

process(t1)  --10KHz clock
variable cnt: integer range 0 to 100;
begin
 if(t1'event and t1 = '1') then
  cnt:=cnt+1;
  if (cnt = 100) then
   cnt:=0;
  elsif (cnt <= 50) then
   t3<='1';
  else
   t3<='0';
  end if;
 end if;
end process;

process(clk_in)  --200KHz clock
variable cnt: integer range 0 to 250;
begin
 if(clk_in'event and clk_in = '1') then
  cnt:=cnt+1;
  if (cnt = 250) then
   cnt:=0;
  elsif (cnt <= 125) then
   t5<='1';
  else
   t5<='0';
  end if;
 end if;
end process;

process(t1)  --500Hz clock
variable cnt: integer range 0 to 2000;
begin
 if(t1'event and t1 = '1') then
  cnt:=cnt+1;
  if (cnt = 2000) then
   cnt:=0;
  elsif (cnt <= 1000) then
   t4<='1';
  else
   t4<='0';
  end if;
 end if;
end process;

process(sig,t2)
variable cnt: integer range 0 to 100000000;
	 begin
	 if(sig'event and sig='1')then
	   if(t2='0') then
       count<=count+1;
		elsif(t2='1') then
       count<=1;
     end if;
	 end if;
	end process;

process(t2,count) 
begin
 if(t2'event and t2='1') then
  count1 <= count;
 end if;
end process;

process(clk_in,count1) 
begin
if(clk_in'event and clk_in='1') then
  if(count1>=1000000) then 
   led1 <= '1';
	led2 <= '1';
	led3 <= '0';
	flag <= "11";
  elsif(count1>=1000) then
   led1 <= '1';
	led2 <= '0';
	led3 <= '1';
	flag <= "10";
  else
   led1 <= '0';
	led2 <= '1';
	led3 <= '1';
	flag <= "01";
  end if;
end if;
end process;

end tt;