library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity decodificador is
	port(
		decod_input	    :	in	std_logic_vector(3 downto 0); -- Entrada do decodificador
		decod_output	:	out	std_logic_vector(6 downto 0)  -- Saída do decodificador
		);
end decodificador;

architecture hardware of decodificador is

signal decod_temp	:	std_logic_vector(6 downto 0);	-- Saída temporária, que será alterada dependendo
                                                        -- dos casos indicados abaixo
begin
	process(decod_input)
	begin
		case decod_input is
			when "0000" => decod_temp <= "0111111"; -- Display = 0
			when "0001" => decod_temp <= "0000110"; -- Display = 1
			when "0010" => decod_temp <= "1011011"; -- Display = 2
			when "0011" => decod_temp <= "1001111"; -- Display = 3
			when "0100" => decod_temp <= "1100110"; -- Display = 4
			when "0101" => decod_temp <= "1101101"; -- Display = 5
			when "0110" => decod_temp <= "1111101"; -- Display = 6
			when "0111" => decod_temp <= "0000111"; -- Display = 7
			when "1000" => decod_temp <= "1111111"; -- Display = 8
			when "1001" => decod_temp <= "1101111"; -- Display = 9
			when "1010" => decod_temp <= "0111101"; -- Display = G (Ganhou)
			when "1011" => decod_temp <= "1110011"; -- Display = P (Perdeu)
			when "1100" => decod_temp <= "1000000"; -- Display = - (Sem número)
			when "1101" => decod_temp <= "0000000"; -- Display apagado
			when others => decod_temp <= "1000000";
		end case; 
	end process;
	decod_output <= not decod_temp;	-- Definindo a variável definitiva negada, pois o display acende em "0"
end hardware;