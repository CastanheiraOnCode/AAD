LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;


ENTITY m_decoder IS
  PORT (y0, y1, y2, y3, y4, y5, y6, y7: IN  STD_LOGIC;
        m_value: OUT STD_LOGIC;
		  m_valid: OUT STD_LOGIC);
END m_decoder;

ARCHITECTURE structure OF m_decoder IS

	-- signals
	SIGNAL mc: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL mAnd01, mAnd23, mOr01, mOr23: STD_LOGIC;
	SIGNAL mNAnd01, mNAnd23, mNOr01, mNOr23: STD_LOGIC;
	SIGNAL mOneC1, mOneC2, mZeroC1, mZeroC2 : STD_LOGIC;
	SIGNAL mZero, mOne : STD_LOGIC;
	
	-- gates
	COMPONENT gateXor2
		PORT (x1, x2 : IN  STD_LOGIC;
				y:			OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT gateNor2
		PORT (x1, x2 : IN  STD_LOGIC;
				y:			OUT STD_LOGIC);
	END COMPONENT;	
	COMPONENT gateNand2
		PORT (x1, x2 : IN  STD_LOGIC;
				y:			OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT gateAnd2
		PORT (x1, x2 : IN  STD_LOGIC;
				y:			OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT gateOr2
		PORT (x1, x2 : IN  STD_LOGIC;
				y:			OUT STD_LOGIC);
	END COMPONENT;
	COMPONENT gateNot
		PORT (x: IN  STD_LOGIC;
				y:	OUT STD_LOGIC);
	END COMPONENT;
	
BEGIN

	-- beginning xor operations
	mc0    : gateXor2  PORT MAP (y0, y1, mc(0));
	mc1    : gateXor2  PORT MAP (y2, y3, mc(1));
	mc2    : gateXor2  PORT MAP (y4, y5, mc(2));
	mc3    : gateXor2  PORT MAP (y6, y7, mc(3));

	-- C3-0 equations calculations for one
	m_And01 : gateAnd2  PORT MAP (mc(1), mc(0), mAnd01);
	m_And23 : gateAnd2  PORT MAP (mc(2), mc(3), mAnd23);
	m_Or01  : gateOr2	  PORT MAP (mc(1), mc(0), mOr01);
	m_Or23  : gateOr2	  PORT MAP (mc(2), mc(3), mOr23);
	
	-- C3-0 equations calculations for zero
	m_NAnd01 : gateNot PORT MAP (mAnd01, mNAnd01);
	m_NAnd23 : gateNot PORT MAP (mAnd23, mNAnd23);
	m_NOr01  : gateNot PORT MAP (mOr01,  mNOr01);
	m_NOr23  : gateNot PORT MAP (mOr23,  mNOr23);
	
	-- One calculations
	m1C1 	 : gateAnd2  PORT MAP (mAnd01, mOr23,  mOneC1);
	m1C2 	 : gateAnd2  PORT MAP (mAnd23, mOr01,  mOneC2);
	m1		 : gateOr2	 PORT MAP (mOneC1, mOneC2, mOne);
		
	-- Zero calculations
	m0C1 	 : gateAnd2  PORT MAP (mNAnd01, mNOr23,  mZeroC1);
	m0C2 	 : gateAnd2  PORT MAP (mNAnd23, mNOr01,  mZeroC2);
	m0		 : gateOr2	 PORT MAP (mZeroC1, mZeroC2, mZero);
	
	-- check validity
	mvalid : gateXor2	 PORT MAP (mZero, mOne, m_valid);
	
	-- forward one signal
	m_value <= mOne;
	
END structure;


-- complete decoder
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY hadamardDecoder IS
  PORT (y: IN STD_LOGIC_VECTOR(7 downto 0);
        msg: OUT STD_LOGIC_VECTOR(3 downto 0);
		  valid: OUT STD_LOGIC);
END hadamardDecoder;

ARCHITECTURE structure OF hadamardDecoder IS
	
	-- decoding computation bits for m0
	SIGNAL m0_value: STD_LOGIC;
	SIGNAL m0_Valid: STD_LOGIC;
	
	-- decoding computation bits for m1
	SIGNAL m1_value: STD_LOGIC;
	SIGNAL m1_Valid: STD_LOGIC;
	
	-- decoding computation bits for m2
	SIGNAL m2_value: STD_LOGIC;
	SIGNAL m2_Valid: STD_LOGIC;
	
	-- decoding computation bits for m3
	SIGNAL m3_value: STD_LOGIC;
	SIGNAL m3_Valid: STD_LOGIC;
	--auxiliary computations bits for m3
	SiGNAL c00: STD_LOGIC;
	SIGNAL aux: STD_LOGIC;
	SIGNAL d :  STD_LOGIC;
	SIGNAL d0:  STD_LOGIC;
	SIGNAL d1:	STD_LOGIC;
	SIGNAL d2:	STD_LOGIC;
	SIGNAL err: STD_LOGIC;
	SIGNAL m3aux: STD_LOGIC;
	
	-- gate component
	COMPONENT gateAnd4
		PORT (x1, x2, x3, x4: IN  STD_LOGIC;
				y				  : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateAnd2
		PORT (x1, x2: IN  STD_LOGIC;
				y				  : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateXor7 IS
		PORT (x1,x2,x3,x4,x5,x6,x7: IN  STD_LOGIC;
        y : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateXor2 IS
		PORT (x1,x2: IN  STD_LOGIC;
        y : OUT STD_LOGIC);
	END COMPONENT;
	
	
	COMPONENT gateOr3 IS
		PORT (x1,x2,x3: IN  STD_LOGIC;
        y : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateNot
		PORT (x: IN  STD_LOGIC;
				y:	OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateAnd3
		PORT (x1,x2,x3: IN  STD_LOGIC;
				y:	OUT STD_LOGIC);
	END COMPONENT;
	
	-- concat components
	COMPONENT concatenator4to1
		PORT(x1, x2, x3, x4 : IN  STD_LOGIC;
			  y				  : OUT STD_LOGIC_VECTOR(3 downto 0));
	END COMPONENT;
	
	-- mbit decoder component
	COMPONENT m_decoder
		PORT (y0, y1, y2, y3, y4, y5, y6, y7: IN  STD_LOGIC;
				m_value: OUT STD_LOGIC;
				m_valid: OUT STD_LOGIC);
	END COMPONENT;
	
BEGIN

	-- m0 computations
	m0 : m_decoder PORT MAP (y(0), y(1), y(2), y(3), y(4), y(5), y(6), y(7), m0_value, m0_valid);

	-- m1 computations
	m1	: m_decoder PORT MAP (y(0), y(2), y(1), y(3), y(4), y(6), y(5), y(7), m1_value, m1_valid);

	-- m2 computations
	m2	: m_decoder PORT MAP (y(0), y(4), y(1), y(5), y(2), y(6), y(3), y(7), m2_value, m2_valid);
	
	--m3 m3computation
	
	
	-- verifying if c#1, c#2 and m#3 are the same, and the same of the calculated value
	-- we dont use m0 because it can contain errors
	d0v : gateXor7 PORT MAP(y(2),y(3),y(4),y(5),y(6),y(7),m3_value , d0);
	d1v : gateXor7 PORT MAP(y(1),y(3),y(4),y(6),y(5),y(7),m1_value , d1);
	d2v : gateXor7 PORT MAP(y(1),y(5),y(2),y(6),y(3),y(7),m2_value , d2);
	-- if its 1 this means there were no errors, or that the y0 is wrong
	dsum: gateOr3 PORT MAP (d0,d1,d2, aux);
	dval: gateNot PORT MAP(aux,d);
	
	-- compute if exists  error in m0
	
	c00Val: gateXor2 PORT MAP(y(0),y(1),c00);
	
	errAux: gateXor2 PORT MAP(c00,m3_value, err);
	
	m3v: gateAnd2 PORT MAP(d, err, m3aux);
	
	m3: gateXor2 PORT MAP(m3aux, y(0),m3_value);
	
	
	-- final results
	message 	: concatenator4to1 PORT MAP (m3_value, m2_value, m1_value, m0_value, msg);
	v	: gateAnd3 PORT MAP(m0_valid, m1_valid, m2_valid, valid);
	
END structure;



	
	
	


