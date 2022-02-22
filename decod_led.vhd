library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity decod_led is
	port(
		A	    :	in	std_logic_vector(1 downto 0); -- Entrada de vidas
		output	:	out	std_logic_vector(2 downto 0)  -- Saída dos LEDs que indicam quantas vidas faltam	
		);
end decod_led;

architecture hardware of decod_led is

begin
	process(A)
	begin
		case A is
			when "00" => output <= "000"; -- zero vidas, LEDs 1 2 e 3 apagados
			when "01" => output <= "100"; -- uma vida, LED 1 aceso, 2 e 3 apagados
			when "10" => output <= "110"; -- duas vidas, LEDs 1 e 2 acesos, 3 apagado
			when "11" => output <= "111"; -- três vidas, LEDs 1 2 e 3 acesos
			when others => output <= "010"; 
		end case;
	end process;
end hardware;