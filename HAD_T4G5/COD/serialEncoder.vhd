LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY control;
USE control.all;

LIBRARY storeDev;
USE storeDev.all;

LIBRARY arithmetic;
USE arithmetic.all;d

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY serialEncoder IS
  PORT (nGRst: IN STD_LOGIC;
		  clk:   IN STD_LOGIC;
		  mIn:   IN STD_LOGIC;
		  code:  OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		  v:	OUT STD_LOGIC;
		  debugstate: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END serialEncoder;

ARCHITECTURE structure OF serialEncoder IS
  SIGNAL iNRst,iNSetO,clkO: STD_LOGIC;
  SIGNAL state:  STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL s_code:  STD_LOGIC_VECTOR (7 DOWNTO 0);
  
  
  SIGNAL s_and: STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL s_f,s_xorIn,s_xor: STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL s_Q: STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL s_min: STD_LOGIC;
  
  
		
    COMPONENT ParReg_8bit
	 PORT (nSet: IN STD_LOGIC;
			nRst: IN STD_LOGIC;
        clk: IN STD_LOGIC;
        D: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        Q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
  END COMPONENT;
  
  component gateAnd2 IS
		PORT (x1, x2: IN STD_LOGIC;
				y:      OUT STD_LOGIC);
	end component;
	
	component gateXor2 IS
		port (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
	end component;

  
   COMPONENT control
	  PORT (nGRst: IN STD_LOGIC;
			  clk:   IN STD_LOGIC;
           add:   IN STD_LOGIC_VECTOR (2 DOWNTO 0);
           nRst:  OUT STD_LOGIC;
           nSetO: OUT STD_LOGIC;
		     f:		OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
           clkO:  OUT STD_LOGIC);
  END COMPONENT;
  
  COMPONENT binCounter_3bit
	 PORT (nRst: IN STD_LOGIC;
			 clk:  IN STD_LOGIC;
			 c:    OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
  END COMPONENT;

	COMPONENT flipFlopDPET
	 PORT (clk, D: IN STD_LOGIC;
			 nSet, nRst: IN STD_LOGIC;
			 Q, nQ: OUT STD_LOGIC);
  END COMPONENT;

  
BEGIN
  
  ff:  flipFlopDPET PORT MAP (clk, mIn, '1', iNRst, s_min);
  bc:   binCounter_3bit PORT MAP (iNRst, clk, state);
 

  and00: gateAnd2 PORT MAP(s_min, s_f(0), s_and(0));
  and01: gateAnd2 PORT MAP(s_min, s_f(1), s_and(1));
  and02: gateAnd2 PORT MAP(s_min, s_f(2), s_and(2));
  and03: gateAnd2 PORT MAP(s_min, s_f(3), s_and(3));
  and04: gateAnd2 PORT MAP(s_min, s_f(4), s_and(4));
  and05: gateAnd2 PORT MAP(s_min, s_f(5), s_and(5));
  and06: gateAnd2 PORT MAP(s_min, s_f(6), s_and(6));
  and07: gateAnd2 PORT MAP(s_min, s_f(7), s_and(7));
  

  -- 0 xor x = x
  
  xor00: gateXor2 PORT MAP(s_and(0), s_Q(0), s_xor(0));
  xor01: gateXor2 PORT MAP(s_and(1), s_Q(1), s_xor(1));
  xor02: gateXor2 PORT MAP(s_and(2), s_Q(2), s_xor(2));
  xor03: gateXor2 PORT MAP(s_and(3), s_Q(3), s_xor(3));
  xor04: gateXor2 PORT MAP(s_and(4), s_Q(4), s_xor(4));
  xor05: gateXor2 PORT MAP(s_and(5), s_Q(5), s_xor(5));
  xor06: gateXor2 PORT MAP(s_and(6), s_Q(6), s_xor(6));
  xor07: gateXor2 PORT MAP(s_and(7), s_Q(7), s_xor(7));
  
  ff0: flipFlopDPET PORT MAP (clk, s_xor(0), '1', iNRst, s_Q(0));
  ff1: flipFlopDPET PORT MAP (clk, s_xor(1), '1', iNRst, s_Q(1));
  ff2: flipFlopDPET PORT MAP (clk, s_xor(2), '1', iNRst, s_Q(2));
  ff3: flipFlopDPET PORT MAP (clk, s_xor(3), '1', iNRst, s_Q(3));
  ff4: flipFlopDPET PORT MAP (clk, s_xor(4), '1', iNRst, s_Q(4));
  ff5: flipFlopDPET PORT MAP (clk, s_xor(5), '1', iNRst, s_Q(5));
  ff6: flipFlopDPET PORT MAP (clk, s_xor(6), '1', iNRst, s_Q(6));
  ff7: flipFlopDPET PORT MAP (clk, s_xor(7), '1', iNRst, s_Q(7));

  
  
  con:  control  PORT MAP (nGRst, clk, state, iNRst,iNSetO, s_f,clkO);

  pr8: ParReg_8bit PORT MAP (iNSetO, '1', clkO, s_Q, code);
  v <= (clkO);
  
END structure;