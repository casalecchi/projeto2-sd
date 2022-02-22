library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;


entity forca is
	port(
		V_SW	:	in	std_logic_vector(9 downto 0); -- Entrada para os switches		
		HEX5    :   out std_logic_vector(6 downto 0); -- Displays 7 segmentos
		HEX4	:	out	std_logic_vector(6 downto 0);		
		HEX3	:	out	std_logic_vector(6 downto 0);		
		HEX2	:	out	std_logic_vector(6 downto 0);		
		HEX1	:	out	std_logic_vector(6 downto 0);		
		HEX0	:	out	std_logic_vector(6 downto 0);
		LEDR    :   out std_logic_vector(17 downto 15)
		);
		
end forca;

architecture behavior of forca is

	signal x0_decod    : std_logic_vector(3 downto 0); -- Entradas e Saídas
	signal y0_decod	   : std_logic_vector(6 downto 0); -- Da forca, sendo as
	signal x1_decod    : std_logic_vector(3 downto 0); -- Entradas os switches
	signal y1_decod	   : std_logic_vector(6 downto 0); -- E as saídas os displays
	signal x2_decod    : std_logic_vector(3 downto 0);
	signal y2_decod	   : std_logic_vector(6 downto 0);
	signal x3_decod    : std_logic_vector(3 downto 0);
	signal y3_decod	   : std_logic_vector(6 downto 0);
	signal x4_decod    : std_logic_vector(3 downto 0);	
	signal y4_decod    : std_logic_vector(6 downto 0);
	signal x5_decod    : std_logic_vector(3 downto 0);
	signal y5_decod    : std_logic_vector(6 downto 0);
	signal x_erro      : std_logic_vector(1 downto 0); -- Entrada e saída de erro
	signal y_erro      : std_logic_vector(2 downto 0); -- Para a representação em LEDs
	
--Usando as componentes definidas e implementadas nos outros arquivos

	component acertos_e_erros is
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
	end component;
	
	component decodificador is
	port(
		decod_input	    :	in	std_logic_vector(3 downto 0); -- Entrada do decodificador
		decod_output	:	out	std_logic_vector(6 downto 0)  -- Saída do decodificador
		);
	end component;
	
	component decod_led is
	port(
		A	    :	in	std_logic_vector(1 downto 0); -- Entrada de vidas
		output	:	out	std_logic_vector(2 downto 0) -- Saída dos LEDs que indicam quantas vidas faltam
		);
	end component;

begin
    -- Começo da verificação da forca
    verificacao_acertos_erros	   :   acertos_e_erros port map (V_SW(9 downto 0), x0_decod, x1_decod, x2_decod, x3_decod, x4_decod, x5_decod, x_erro);
	display_0	                   :   decodificador port map (x0_decod, y0_decod);			
	display_1	                   :   decodificador port map (x1_decod, y1_decod);			
	display_2	                   :   decodificador port map (x2_decod, y2_decod);			
	display_3	                   :   decodificador port map (x3_decod, y3_decod);			
	display_4	                   :   decodificador port map (x4_decod, y4_decod);	        
	display_5                      :   decodificador port map (x5_decod, y5_decod);
	LEDs_erro                      :   decod_led port map (x_erro, y_erro); 
	
	HEX5(6 downto 0)   <= y0_decod; -- Display mais à esquerda
	HEX4(6 downto 0)   <= y1_decod;
	HEX3(6 downto 0)   <= y2_decod;			
	HEX2(6 downto 0)   <= y3_decod;			
	HEX1(6 downto 0)   <= y4_decod;			
	HEX0(6 downto 0)   <= y5_decod; -- Display mais à direita
    LEDR(17 downto 15) <= y_erro;   -- LEDs de erros

end behavior;