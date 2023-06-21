LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateAnd2;

ARCHITECTURE logicFunction OF gateAnd2 IS
BEGIN
  y <= x1 AND x2;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNand2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateNand2;

ARCHITECTURE logicFunction OF gateNand2 IS
BEGIN
  y <= NOT (x1 AND x2);
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNor2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateNor2;

ARCHITECTURE logicFunction OF gateNor2 IS
BEGIN
  y <= NOT (x1 OR x2);
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXor2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateXor2;

ARCHITECTURE logicFunction OF gateXor2 IS
BEGIN
  y <= x1 XOR x2;
END logicFunction;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOr2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateOr2;

ARCHITECTURE logicFunction OF gateOr2 IS
BEGIN
  y <= x1 OR x2;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY concatenator4to1 IS
  PORT (x1, x2, x3, x4: IN STD_LOGIC;
        y:      OUT STD_LOGIC_VECTOR(3 downto 0));
END concatenator4to1;

ARCHITECTURE logicFunction OF concatenator4to1 IS
BEGIN
  y <= x1 & x2 & x3 & x4;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY concatenator8to1 IS
  PORT (x1, x2, x3, x4, x5, x6, x7, x8: IN STD_LOGIC;
        y:      OUT STD_LOGIC_VECTOR(8 downto 0));
END concatenator8to1;

ARCHITECTURE logicFunction OF concatenator8to1 IS
BEGIN
  y <= x1 & x2 & x3 & x4 & x5 & x6 & x7 & x8;
END logicFunction;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd4 IS
  PORT (x1, x2, x3, x4: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateAnd4;

ARCHITECTURE logicFunction OF gateAnd4 IS
BEGIN
	y <= x1 AND x2 AND x3 AND x4;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNot IS
  PORT (x: IN  STD_LOGIC;
        y : OUT STD_LOGIC);
END gateNot;

ARCHITECTURE logicFunction OF gateNot IS
BEGIN
	y <= NOT x;
END logicFunction;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOr3 IS
  PORT (x1,x2,x3: IN  STD_LOGIC;
        y : OUT STD_LOGIC);
END gateOr3;

ARCHITECTURE logicFunction OF gateOr3 IS
BEGIN
	y <= x1 or x2 or x3;
END logicFunction;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXor7 IS
  PORT (x1,x2,x3,x4,x5,x6,x7: IN  STD_LOGIC;
        y : OUT STD_LOGIC);
END gateXor7;

ARCHITECTURE logicFunction OF gateXor7 IS
BEGIN
	y <= (x1 xor x2) xor (x3 xor x4) xor (x5 xor x6) xor x7;
END logicFunction;



LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd3 IS
  PORT (x1,x2,x3: IN  STD_LOGIC;
        y : OUT STD_LOGIC);
END gateAnd3;

ARCHITECTURE logicFunction OF gateAnd3 IS
BEGIN
	y <= x1 and x2 and x3;
END logicFunction;




