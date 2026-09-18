library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity show is
port(flag : in std_logic_vector(1 downto 0);
     clk_s : in std_logic;
	  clk_h : in std_logic;
     in1,in2,in3,in4,in5,in6 : in integer range 0 to 15;
	  q : out std_logic_vector(7 downto 0);
	  p : out std_logic_vector(5 downto 0));
	  
end show;

architecture tt of show is

signal out1,out2,out3,out4,out5 : integer range 0 to 15;
signal out_dot : std_logic_vector(3 downto 0);
signal bcd : integer range 0 to 15;
--signal in1,in2,in3,in4,in5,in6 : std_logic_vector(3 downto 0);

begin

--in6<="0000";
--in5<="0000";
--in4<="0110";
--in3<="0011";
--in2<="0010";
--in1<="0000";

process(clk_h,flag) --in1 - in6 -> out1 - out5  dot
begin
if(clk_h'event and clk_h='1') then
  if(in6>0) then out5<=in6; out4<=in5; out3<=in4; out2<=in3; out1<=in2; out_dot<="0010";
  elsif(in5>0) then out5<=in5; out4<=in4; out3<=in3; out2<=in2; out1<=in1; out_dot<="0100";
  elsif(in4>0) then out5<=in4; out4<=in3; out3<=in2; out2<=in1; out1<=0; out_dot<="1000";
  else out5<=15; out4<=15; out3<=15; out2<=15; out1<=15; out_dot<="0000";
  end if;
end if;
end process;

process(clk_s) --dynamic show
variable cnt: integer range 0 to 5;
begin
 if(clk_s'event and clk_s='1') then
  if (cnt = 0) then
	bcd <= out5; 
	p <= "011111";
   if out_dot="1000" then 
	 q(0)<='0';
   else 
	 q(0)<='1';
   end if;
  elsif(cnt = 1) then
   bcd <= out4; 
	p <= "101111";
   if out_dot="0100" then 
	 q(0)<='0';
   else 
	 q(0)<='1';
   end if;
  elsif(cnt = 2) then
   bcd <= out3; 
	p <= "110111";
   if out_dot="0010" then 
	 q(0)<='0';
   else 
	 q(0)<='1';
   end if;
  elsif(cnt = 3) then
   bcd <= out2; 
	p <= "111011";
   if out_dot="0001" then 
	 q(0)<='0';
   else 
	 q(0)<='1';
   end if;
 end if;
 cnt:=cnt+1;
 if(cnt = 4) then
  cnt:=0;
 end if;
end if;
end process;

process (bcd) --decode
begin
 case bcd is
  when 0=>q(7 downto 1)<="0000001";
  when 1=>q(7 downto 1)<="1001111";
  when 2=>q(7 downto 1)<="0010010";
  when 3=>q(7 downto 1)<="0000110";
  when 4=>q(7 downto 1)<="1001100";
  when 5=>q(7 downto 1)<="0100100";
  when 6=>q(7 downto 1)<="0100000";
  when 7=>q(7 downto 1)<="0001111";
  when 8=>q(7 downto 1)<="0000000";
  when 9=>q(7 downto 1)<="0000100";
  when 10=>q(7 downto 1)<="1001000";  --h
  when 11=>q(7 downto 1)<="0110001";  --k
  when others=>q(7 downto 1)<="1111111";
 end case;
end process;

end tt;