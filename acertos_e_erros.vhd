library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;

entity acertos_e_erros is
	port(
		entrada	    :	 in std_logic_vector(9 downto 0); -- Switches FPGA
		saida_0	    :	out	std_logic_vector(3 downto 0); -- Displays FPGA
		saida_1	    :	out	std_logic_vector(3 downto 0);		
		saida_2	    :	out	std_logic_vector(3 downto 0);		
		saida_3	    :	out	std_logic_vector(3 downto 0);		
		saida_4	    :	out	std_logic_vector(3 downto 0);
		saida_5     :   out std_logic_vector(3 downto 0);
		erro        :   out std_logic_vector(1 downto 0)  -- LEDs FPGA
		);
end acertos_e_erros;

architecture hardware of acertos_e_erros is

begin

process(entrada)

	variable saida_0_temp	:	std_logic_vector(3 downto 0);	-- Variáveis para serem utilizadas
	variable saida_1_temp	:	std_logic_vector(3 downto 0);	-- De forma temporária e serem modificadas
	variable saida_2_temp	:	std_logic_vector(3 downto 0);	-- A cada erro ou acerto do jogo
	variable saida_3_temp	:	std_logic_vector(3 downto 0);	
	variable saida_4_temp   :   std_logic_vector(3 downto 0);
	variable saida_5_temp   :   std_logic_vector(3 downto 0);
	variable vidas	        :	integer range 3 downto 0;					
	
begin
	saida_0_temp := "1100";	-- Deixando todos os displays com traço, a princípio
	saida_1_temp := "1100";	-- Dependendo das condições do circuito, eles serão
	saida_2_temp := "1100";	-- Alterados através da alteração destas variáveis
	saida_3_temp := "1100";
	saida_4_temp := "1100";
	saida_5_temp := "1100";
    
    -- Condições para se perder vidas
    
	vidas := 3; -- 3 tentativas antes de perder a forca
	
	if (entrada(0) = '1') then -- Primeiro possível erro		
		vidas := vidas - 1;
	end if;
	
	if (entrada(5) = '1') then	-- Segundo possível erro	
		vidas := vidas - 1;
	end if;
	
	if (entrada(8) = '1') then	-- Terceiro possível erro	
		vidas := vidas - 1;
	end if;
	
	if (entrada(9) = '1') then	-- Quarto possível erro
		vidas := vidas - 1;
	end if;
	
    -- Condições de acerto
	
	if (entrada(4) = '1') then -- Dígito 4 na primeira posição da forca
		saida_0_temp := "0100";
	end if;

	if (entrada(1) = '1') then	-- Dígito 1 na segunda posição da forca	
		saida_1_temp := "0001";
	end if;
	
	if (entrada(7) = '1') then	-- Dígito 7 na terceira posição da forca	
	    saida_2_temp := "0111";
	end if;
	
	if (entrada(2) = '1') then	-- Dígito 2 na quarta posição da forca	
		saida_3_temp := "0010";
	end if;
	
	if (entrada(6) = '1') then  -- Dígito 6 na quinta posição da forca
	    saida_4_temp := "0110";
	end if;
	
	if (entrada(3) = '1') then  -- Dígito 3 na sexta posição da forca
	    saida_5_temp := "0011";
	end if;

    
    -- Condição de vitória (Aparecer "G" no primeiro display)
	if ((entrada(4) and entrada(1) and entrada(7) and entrada(2) and entrada(6) and entrada(3)) = '1') and vidas > 0 then
		saida_0_temp := "1010"; -- Aparece G no primeiro e deixa os outros apagados
		saida_1_temp := "1101";
		saida_2_temp := "1101";	
		saida_3_temp := "1101";
		saida_4_temp := "1101";
		saida_5_temp := "1101";
	end if;
    
    -- Condição de Derrota (Aparecer "P" no primeiro display)
	if vidas = 0 then				
		saida_0_temp := "1011"; -- Aparece P no primeiro e deixa os outros apagados
		saida_1_temp := "1101";
		saida_2_temp := "1101";
		saida_3_temp := "1101";
		saida_4_temp := "1101";
		saida_5_temp := "1101";
	end if;

	saida_0 <= saida_0_temp; -- Finalizando o código definindo as variáveis
	saida_1 <= saida_1_temp; -- Temporárias às variáveis definitivas
	saida_2 <= saida_2_temp;		
	saida_3 <= saida_3_temp;
	saida_4 <= saida_4_temp;
	saida_5 <= saida_5_temp;
	erro    <= conv_std_logic_vector(vidas, 2); -- Faz a conversão do inteiro
	                                            -- Para o std_logic_vector de
	                                            -- Tamanho 2
end process;

end hardware;