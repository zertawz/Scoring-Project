----------------------------------------------------------------------------------
-- 
-- Engineer:       Renaud DAVIOT
-- 
-- Create Date:    2016 
--
-- Module Name:    chronoscore_phase3 - Behavioral 
-- Project Name:   chronoscore_phase3
--
-- Target Devices: XC3S200 (Spartan 3 - 200K)
-- 
-- Description: 
--
--
-- Revision 0.01 - File Created
--
----------------------------------------------------------------------------------

library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;

entity chronoscore is
    port (  GCLK      : in  std_logic;
            TEST_HSLS : in  std_logic;
            START     : in  std_logic;
            WAIT_t    : in  std_logic;
            RESET     : in  std_logic;
            BPU 		 : in  STD_LOGIC;
            BPR 		 : in  STD_LOGIC;
			   BPD 		 : in  STD_LOGIC;
            BPL 		 : in  STD_LOGIC;
			   BPC 		 : in  STD_LOGIC;
            --BPreset   : in  std_logic;
            TEST      : in  std_logic;
            TESTVGA   : in  std_logic;
            VGAONOFF  : in  std_logic;
				SELXMS  	 : in  std_logic;
				SELXS  	 : in  std_logic;
            ----------------------------------------------
            RED       : out std_logic;  
            GREEN     : out std_logic;   
            BLUE      : out std_logic;  
            HSYNCH    : out std_logic;   
            VSYNCH    : out std_logic;  
				----------------------------------------------
				TONE      : out std_logic; 
				----------------------------------------------
				RGBL      : out std_logic_vector (2 downto 0);
				RGBR      : out std_logic_vector (2 downto 0);
				----------------------------------------------
            AN        : out std_logic_vector (7 downto 0);
            LEDS      : out std_logic_vector (7 downto 0));
end chronoscore ;

architecture Behavioral of chronoscore is

    component timeGenerator
        Port ( RESET      : in  std_logic;
					GCLK       : in  std_logic;
               TEST_HSLS  : in  std_logic;
               ----------------------- 
               CE_1ms     : out std_logic;
					CE_10ms    : out std_logic;
					CE_100ms   : out std_logic;
               CE_1s      : out std_logic;
               CLK        : out std_logic);
    end component timeGenerator;

    component chronometer
        Port (  CLK       : in  std_logic;
                CE_1s     : in  std_logic;
                START     : in  std_logic;
                WAIT_t    : in  std_logic;
                RESET     : in  std_logic;
                ----------------------------------------------
                sec_unit  : out std_logic_vector (3 downto 0);
                sec_dec   : out std_logic_vector (3 downto 0);
                min_unit  : out std_logic_vector (3 downto 0);
                min_dec   : out std_logic_vector (3 downto 0));
    end component chronometer;

    component score
        Port ( CLK        : in  std_logic;
               CE_1ms     : in  std_logic;
					CE_1s 	  : in  STD_LOGIC; 
				   BPU 		  : in  STD_LOGIC;
				   BPR 		  : in  STD_LOGIC;
				   BPD 		  : in  STD_LOGIC;
				   BPL 		  : in  STD_LOGIC;
				   BPC 		  : in  STD_LOGIC;
               BPreset    : in  std_logic;
               -----------------------------------------------
				   --LSINC 	  : out  STD_LOGIC;
			      --VSINC 	  : out  STD_LOGIC;
					RGBL 		  : out  STD_LOGIC_VECTOR (2 downto 0);
					RGBR 		  : out  STD_LOGIC_VECTOR (2 downto 0);
               vis_unit   : out std_logic_vector (3 downto 0);
               vis_dec    : out std_logic_vector (3 downto 0);
               OL_unit    : out std_logic_vector (3 downto 0);
               OL_dec     : out std_logic_vector (3 downto 0));
    end component score;
    
    component display
        Port (  CLK       : in  std_logic;
                CE_1ms    : in  std_logic;
                CE_1s     : in  std_logic;
				    data_disp1_R0 : in  STD_LOGIC_VECTOR (3 downto 0);
				    data_disp1_R1 : in  STD_LOGIC_VECTOR (3 downto 0);
				    data_disp1_L0 : in  STD_LOGIC_VECTOR (3 downto 0);
				    data_disp1_L1 : in  STD_LOGIC_VECTOR (3 downto 0);
				    data_disp2_R0 : in  STD_LOGIC_VECTOR (3 downto 0);
				    data_disp2_R1 : in  STD_LOGIC_VECTOR (3 downto 0);
				    data_disp2_L0 : in  STD_LOGIC_VECTOR (3 downto 0);
				    data_disp2_L1 : in  STD_LOGIC_VECTOR (3 downto 0);	
                ----------------------------------------------
                AN        : out std_logic_vector (7 downto 0);
                LEDS      : out std_logic_vector (7 downto 0));
    end component display;
    
    component vgaDisplay  
        port (  CLK       : in  std_logic;
                VGAONOFF  : in  std_logic;
                TESTVGA   : in  std_logic;
                CE_1s     : in  std_logic;
                sec_unit  : in  std_logic_vector(3 downto 0);
                sec_dec   : in  std_logic_vector(3 downto 0);
                min_unit  : in  std_logic_vector(3 downto 0);
                min_dec   : in  std_logic_vector(3 downto 0);
                vis_unit  : in  std_logic_vector(3 downto 0);
                vis_dec   : in  std_logic_vector(3 downto 0);
                OL_unit   : in  std_logic_vector(3 downto 0);
                OL_dec    : in  std_logic_vector(3 downto 0);
                ---------------------------------------------
                HSYNCH    : out std_logic;
                VSYNCH    : out std_logic;
                RED       : out std_logic;
                BLUE      : out std_logic;
                GREEN     : out std_logic            
                );
    end component vgaDisplay;
   
	component rgb
		 Port ( clk : in  STD_LOGIC;
				  CE : in  STD_LOGIC;
				  D : in  STD_LOGIC_VECTOR (2 downto 0);
				  Q : out  STD_LOGIC_VECTOR (2 downto 0));
	end component;

	component buzzer is
		 Port (  RESET 		: in  STD_LOGIC;
					CLK 			: in  STD_LOGIC;
					CE_1s 		: in  STD_LOGIC;
					CE_100ms 	: in  STD_LOGIC;
					SW0 			: in  STD_LOGIC;
					ToneSel 		: std_logic_vector (2 downto 0);
					TONE 			: out  STD_LOGIC);
	end component buzzer;	
    
    -----------------------------------------------

    signal CE_1ms_int  		: std_logic;
	 signal CE_10ms_int  	: std_logic;
	 signal CE_100ms_int  	: std_logic;
	 signal CE_Xms_int  		: std_logic;
	 signal CE_Xs_int  		: std_logic;
    signal CE_1s_int   		: std_logic;	
    signal CLK_int     		: std_logic;
	 
	 --signal LSINC_int     	: std_logic;
	 --signal VSINC_int     	: std_logic;
	 
	 signal NRESET     		: std_logic;
	 
	 signal rgbl_int  		: std_logic_vector (2 downto 0);
	 signal rgbr_int  		: std_logic_vector (2 downto 0);
	 
	 signal tones_int  		: std_logic_vector (2 downto 0);
    	
    signal SU  : std_logic_vector (3 downto 0);
    signal SD  : std_logic_vector (3 downto 0);
    signal MU  : std_logic_vector (3 downto 0);
    signal MD  : std_logic_vector (3 downto 0);
    
    signal VU  : std_logic_vector (3 downto 0);
    signal VD  : std_logic_vector (3 downto 0);
    signal OU  : std_logic_vector (3 downto 0);
    signal OD  : std_logic_vector (3 downto 0);
    
    signal DR0 : std_logic_vector (3 downto 0);
    signal DR1 : std_logic_vector (3 downto 0);
    signal DL0 : std_logic_vector (3 downto 0);
    signal DL1 : std_logic_vector (3 downto 0);
    
    -----------------------------------------------

begin

NRESET <= NOT RESET;

CE_Xms_int <=  CE_1ms_int when SELXMS = '0' else
					CE_100ms_int;

CE_Xs_int <=  CE_1s_int when SELXS = '0' else
					CE_100ms_int;					

tones_int <= rgbl_int OR rgbr_int;
					
  U0 : timeGenerator 
        port map (  RESET     => NRESET,
						  GCLK      => GCLK,
                    TEST_HSLS => TEST_HSLS,    
                    -------------------------
                    CE_1ms    => CE_1ms_int,
						  CE_10ms   => CE_10ms_int,
						  CE_100ms  => CE_100ms_int,
                    CE_1s     => CE_1s_int,
                    CLK       => CLK_int);                

  U1 : chronometer 
        port map (  CLK       => CLK_int,
                    CE_1s     => CE_1s_int,
                    START     => START,
                    WAIT_t    => WAIT_t,
                    RESET     => NRESET,	-- PB/RESET Active Low
                    -------------------------
                    sec_unit  => SU,
                    sec_dec   => SD,
                    min_unit  => MU,
                    min_dec   => MD);
                    
  U2 : score 
        port map (  CLK      => CLK_int,
						  CE_1s	  => CE_1s_int,
                    CE_1ms   => CE_Xms_int,
                    BPU      => BPU AND (NOT WAIT_t),
                    BPR      => BPR AND (NOT WAIT_t),
						  BPD      => BPD AND (NOT WAIT_t),
                    BPL      => BPL AND (NOT WAIT_t),
						  BPC      => BPC AND (NOT WAIT_t),
                    BPreset  => NRESET,
                    -------------------------
						  --LSINC	  => LSINC_int,
						  --VSINC	  => VSINC_int,
						  RGBL 	  => rgbl_int,
						  RGBR 	  => rgbr_int,
                    vis_unit => VU,
                    vis_dec  => VD,
                    OL_unit  => OU,
                    OL_dec   => OD);
                    
  U4 : display 
        port map (  CLK     => CLK_int,
                    CE_1ms  => CE_Xms_int,
                    CE_1s   => CE_1s_int,
                    data_disp1_R0 => SU,
                    data_disp1_R1 => SD,
                    data_disp1_L0 => MU,
                    data_disp1_L1 => MD,
                    data_disp2_R0 => VU,
                    data_disp2_R1 => VD,
                    data_disp2_L0 => OU,
                    data_disp2_L1 => OD,
                    -------------------------
                    AN      => AN,
                    LEDS    => LEDS);	
    
                    
   U5 : vgaDisplay 
       port map (  CLK      => CLK_int,
                   VGAONOFF => VGAONOFF,
                   TESTVGA  => TESTVGA,
                   CE_1s    => CE_1s_int,
                   sec_unit => SU,
                   sec_dec  => SD,
                   min_unit => MU,
                   min_dec  => MD,
                   vis_unit => VU,
                   vis_dec  => VD,
                   OL_unit  => OU,
                   OL_dec   => OD,
                    -------------------------
                   RED      => RED,
                   GREEN    => GREEN,
                   BLUE     => BLUE,
                   HSYNCH   => HSYNCH,
                   VSYNCH   => VSYNCH);                     

	U6 : rgb
		 PORT MAP(  clk 	=> CLK_int,
						CE  	=> CE_100ms_int,
						D   	=> rgbl_int,
						Q   	=> RGBL);

	U7 : rgb
		 PORT MAP(  clk 	=> CLK_int,
						CE  	=> CE_100ms_int,
						D   	=> rgbr_int,
						Q   	=> RGBR);
 
	 U8 : buzzer
		  PORT MAP(	RESET 	=> NRESET,
						CLK 		=> CLK_int,
						CE_1s 	=> CE_1s_int,
						CE_100ms => CE_100ms_int,
						SW0 		=> SELXS,
						ToneSel	=> tones_int,
						TONE 		=> TONE);
 
end Behavioral;

