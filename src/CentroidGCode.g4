/*
 * MIT License
 * 
 * Copyright (c) 2019 Daniel Berlin
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
 * associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
 * NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
grammar CentroidGCode;

// This is a parser that supports Centroid CNC's GCode variant. Unfortunately G-Code differs greatly
// even in things like "allowed comment style". So this will likely be mostly correct but.

// Programs are made up of blocks
program: EOF | block+ EOF;
// Blocks are groups of gcode, either named or unnamed
block: oBlock | word+;
oBlock: O_BLOCK_NUMBER word* M99;
word:
	gWord
	| mWord
	| axisWord
	| feedWord
	| separateWord
	| assignment
	| LINE_NUMBER
	| ERROR
	| ifStatement
	| gotoExpression;

nonControlWord:
	gWord
	| mWord
	| axisWord
	| feedWord
	| separateWord
	| assignment
	| ERROR
	| LINE_NUMBER;

ifStatement:
	IF singleExpression THEN? (nonControlWord+ | gotoExpression) (
		ELSE (nonControlWord+ | gotoExpression)
	)?;
assignment: singleExpression '=' singleExpression;
gotoExpression: GOTO singleExpression;

axisWord: (A | B | C | I | J | K | R | U | V | W | X | Y | Z) singleExpression;
feedWord: F singleExpression;

gWord:
	groupA
	| groupC
	| groupD
	| groupE
	| groupF
	| groupG
	| groupH
	| groupI
	| groupJ
	| groupK
	| groupL
	| groupM
	| groupN
	| groupO
	| groupP
	| gnonmodal;
// Modal gcode groups from the manual. Group B is not modal.
groupA: G0 | G1 | G2 | G3;
gnonmodal: G4 | G9 | G10 | G28 | G29 | G30 | G52 | G53 | G92;
groupC: G17 | G18 | G19 | G117 | G118 | G119;
groupD: G40 | G41 | G42;
groupE: G43 | G44 | G49 | G43_3 | G43_4;
groupF: G61 | G64;
groupG:
	G73
	| G74
	| G76
	| G80
	| G81
	| G82
	| G83
	| G84
	| G85
	| G89
	| G173
	| G174
	| G176
	| G180
	| G181
	| G182
	| G183
	| G184
	| G185
	| G189;
groupH: G90 | G91;
groupI: G98 | G99;
groupJ: G65;
groupK: G20 | G21;
groupL: G54 | G55 | G56 | G57 | G58 | G59;
groupM: G50 | G51;
groupN: G68 | G69 | G68_1;
groupO: G22 | G23;
groupP: G93 | G94 | G93_1;

mWord:
	mgroup4
	| mgroup6
	| mgroup7
	| mgroup8
	| mgroup10
	| mgroup11
	| mgroup12
	| mgroup13a
	| mgroup13b
	| mgroup14
	| mgroup15
	| mgroup16
	| mgroup17
	| mprobe
	| mnonmodal;

//The modal groups for M codes are:
mgroup4: M0 | M1 | M2 | M30 | M60;
mgroup6: M6;
mgroup7: M3 | M4 | M5;
mgroup8: M7 | M8 | M9;
mgroup10: M10 | M11;
mgroup11: M17 | M19 | M25 | M26 | M30 | M39;
mgroup12: M41 | M42 | M43;
mgroup13a: (M91 | M92 | M93) slashAxis;
mgroup13b: (M105 | M106) slashAxis m105106Arg+;
m105106Arg: feedWord | (P singleExpression);
mgroup14: M98 m98Arg m98Arg;
m98Arg: ((L | P) singleExpression) | String;
mgroup15: (M94 | M95 | M100 | M101) slashExpression+;
mgroup16: (M108 | M109) slashExpression+;
mgroup17: (M103 slashExpression) | M104;
mprobe: (M115 | M116 | M125 | M126) slashAxis mprobeArg+;
mprobeArg:
	singleExpression
	| axisWord
	| P singleExpression
	| feedWord
	| (L | Q) Number;
mnonmodal:
	M102
	| M107
	| (M120 | M121) String
	| (M122 | M124) slashAxis* m122124Arg+
	| M123 m123Arg* // m123 is used with some broken arguments in some cases
	| M127
	| M128 slashAxis L singleExpression
	| M129
	| M130 String
	| M150
	| (M200 | M201 | M223) formattedString
	| M224 slashExpression? singleExpression formattedString
	| M225 slashExpression? singleExpression formattedString
	| M290
	| M300 slashExpression+
	| M333
	| M1000
	| M1001
	| M1002
	| M1003
	| M1004
	| M1005
	| M1006
	| M1007
	| M1008
	| M1009
	| M1010
	| M1011
	| M1012
	| M1013
	| M1014
	| M1015;
m122124Arg: (L | P | Q) singleExpression;
m123Arg: (L | P | R | Q) singleExpression;
slashAxis:
	'/' (A | B | C | I | J | K | R | U | V | W | X | Y | Z);
slashExpression: '/' singleExpression;
// String followed by variable references
formattedString: String singleExpression*;

separateWord: (D | H | L | M | P | Q | S | T) singleExpression;

singleExpression:
	'#' singleExpression									# VariableExpression
	| '+' singleExpression									# UnaryPlusExpression
	| '-' singleExpression									# UnaryMinusExpression
	| NOT singleExpression									# NotExpression
	| singleExpression ('*' | '/' | MOD) singleExpression	# MultiplicativeExpression
	| singleExpression ('+' | '-') singleExpression			# AdditiveExpression
	| singleExpression (LT | GT | LE | GE) singleExpression	# RelationalExpression
	| singleExpression (EQ | NE) singleExpression			# EqualityExpression
	| singleExpression '&' singleExpression					# BitAndExpression
	| singleExpression XOR singleExpression					# BitXOrExpression
	| singleExpression '|' singleExpression					# BitOrExpression
	| singleExpression AND singleExpression					# LogicalAndExpression
	| singleExpression OR singleExpression					# LogicalOrExpression
	| callExpression										# MathCallExpression
	| '(' singleExpression ')'								# ParenExpression
	| '[' singleExpression ']'								# BracketExpression
	| (Identifier | singleLetter)							# IdentifierExperssion
	| (Number | String)										# ConstantExpression;

callExpression:
	(
		ABS
		| ACOS
		| ASIN
		| ATAN
		| SIN
		| COS
		| TAN
		| EXP
		| FIX
		| FUP
		| ROUND
		| SQRT
	) ('(' | '[') singleExpression (',' singleExpression)* (
		')'
		| ']'
	);

singleLetter:
	A
	| B
	| C
	| D
	| E
	| G
	| H
	| I
	| J
	| K
	| L
	| M
	| N
	| O
	| P
	| Q
	| R
	| S
	| T
	| U
	| V
	| W
	| X
	| Y
	| Z;
Whitespace: [ \t\r\n\u000C]+ -> skip;
Comment: (';' | ':') ~[\r\n]* -> channel(HIDDEN);
Number: ( DigitSequence | Digit* ('.' DigitSequence?));

G0: G '0'* '0';
G1: G '0'* '1';
G2: G '0'* '2';
G3: G '0'* '3';
G4: G '0'* '4';
G9: G '0'* '9';
G10: G '0'* '10';
G17: G '0'* '17';
G18: G '0'* '18';
G19: G '0'* '19';
G20: G '0'* '20';
G21: G '0'* '21';
G22: G '0'* '22';
G23: G '0'* '23';
G28: G '0'* '28';
G29: G '0'* '29';
G30: G '0'* '30';
G40: G '0'* '40';
G41: G '0'* '41';
G42: G '0'* '42';
G43: G '0'* '43';
G43_3: G '0'* '43.3';
G43_4: G '0'* '43.4';
G44: G '0'* '44';
G49: G '0'* '49';
G50: G '0'* '50';
G51: G '0'* '51';
G52: G '0'* '52';
G53: G '0'* '53';
G54: G '0'* '54';
G55: G '0'* '55';
G56: G '0'* '56';
G57: G '0'* '57';
G58: G '0'* '58';
G59: G '0'* '59';
G61: G '0'* '61';
G64: G '0'* '64';
G65: G '0'* '65';
G68: G '0'* '68';
G68_1: G '0'* '68.1';
G69: G '0'* '69';
G73: G '0'* '73';
G74: G '0'* '74';
G76: G '0'* '76';
G80: G '0'* '80';
G81: G '0'* '81';
G82: G '0'* '82';
G83: G '0'* '83';
G84: G '0'* '84';
G85: G '0'* '85';
G88: G '0'* '88';
G89: G '0'* '89';
G90: G '0'* '90';
G91: G '0'* '91';
G92: G '0'* '92';
G93: G '0'* '93';
G93_1: G '0'* '93.1';
G94: G '0'* '94';
G98: G '0'* '98';
G99: G '0'* '99';
G117: G '0'* '117';
G118: G '0'* '118';
G119: G '0'* '119';
G173: G '0'* '173';
G174: G '0'* '174';
G176: G '0'* '176';
G180: G '0'* '180';
G181: G '0'* '181';
G182: G '0'* '182';
G183: G '0'* '183';
G184: G '0'* '184';
G185: G '0'* '185';
G189: G '0'* '189';

M0: M '0'* '0';
M1: M '0'* '1';
M2: M '0'* '2';
M3: M '0'* '3';
M4: M '0'* '4';
M5: M '0'* '5';
M6: M '0'* '6';
M7: M '0'* '7';
M8: M '0'* '8';
M9: M '0'* '9';
M10: M '0'* '10';
M11: M '0'* '11';
M17: M '0'* '17';
M19: M '0'* '19';
M25: M '0'* '25';
M26: M '0'* '26';
M30: M '0'* '30';
M39: M '0'* '39';
M41: M '0'* '41';
M42: M '0'* '42';
M43: M '0'* '43';
M48: M '0'* '48';
M49: M '0'* '49';
M60: M '0'* '60';
M91: M '0'* '91';
M92: M '0'* '92';
M93: M '0'* '93';
M94: M '0'* '94';
M95: M '0'* '95';
M98: M '0'* '98';
M99: M '0'* '99';
M100: M '0'* '100';
M101: M '0'* '101';
M102: M '0'* '102';
M103: M '0'* '103';
M104: M '0'* '104';
M105: M '0'* '105';
M106: M '0'* '106';
M107: M '0'* '107';
M108: M '0'* '108';
M109: M '0'* '109';
M115: M '0'* '115';
M116: M '0'* '116';
M120: M '0'* '120';
M121: M '0'* '121';
M122: M '0'* '122';
M123: M '0'* '123';
M124: M '0'* '124';
M125: M '0'* '125';
M126: M '0'* '126';
M127: M '0'* '127';
M128: M '0'* '128';
M129: M '0'* '129';
M130: M '0'* '130';
M150: M '0'* '150';
M200: M '0'* '200';
M201: M '0'* '201';
M223: M '0'* '223';
M224: M '0'* '224';
M225: M '0'* '225';
M290: M '0'* '290';
M300: M '0'* '300';
M333: M '0'* '333';
M1000: M '0'* '1000';
M1001: M '0'* '1001';
M1002: M '0'* '1002';
M1003: M '0'* '1003';
M1004: M '0'* '1004';
M1005: M '0'* '1005';
M1006: M '0'* '1006';
M1007: M '0'* '1007';
M1008: M '0'* '1008';
M1009: M '0'* '1009';
M1010: M '0'* '1010';
M1011: M '0'* '1011';
M1012: M '0'* '1012';
M1013: M '0'* '1013';
M1014: M '0'* '1014';
M1015: M '0'* '1015';
LINE_NUMBER: N DigitSequence;
O_BLOCK_NUMBER: O DigitSequence;
IF: I F;
THEN: T H E N;
ELSE: E L S E;
GOTO: G O T O;
INPUT: I N P U T;
DEFINE: D E F I N E;
ABS: A B S;
ACOS: A C O S;
ASIN: A S I N;
ATAN: A T A N;
SIN: S I N;
COS: C O S;
TAN: T A N;
AND: A N D | '&&';
OR: O R | '||';
XOR: X O R | '^';
EXP: E X P;
FIX: F I X;
FUP: F U P;
ROUND: R O U N D;
SQRT: S Q R T;
MOD: M O D | '%';
PLUS: '+';
MINUS: '-';
STAR: '*';
SLASH: '/';
NOT: N O T | '!';
AMPERSAND: '&';
VERTBAR: '|';
EQ: E Q | '==';
NE: N E | '!=';
GT: G T | '>=';
GE: G E | '>';
LT: L T | '<';
LE: L E | '<=';
TILDE: '~';
HASH: '#';
LPAREN: '(';
RPAREN: ')';
LBRACKET: '[';
// -> mode(BRACKET);
RBRACKET: ']';
String: '"' SCharSequence? '"';
EQUALS: '=';
fragment SCharSequence: SChar+;
// Centroid's definition of escape sequence is very limited and we don't bother processing it here.
fragment SChar: ~["\r\n];
fragment Digit: [0-9];
fragment DigitSequence: Digit+;
fragment NonDigit: [a-zA-Z_];

// For case insensitive matching
A: ('a' | 'A');
B: ('b' | 'B');
C: ('c' | 'C');
D: ('d' | 'D');
E: ('e' | 'E');
F: ('f' | 'F');
G: ('g' | 'G');
H: ('h' | 'H');
I: ('i' | 'I');
J: ('j' | 'J');
K: ('k' | 'K');
L: ('l' | 'L');
M: ('m' | 'M');
N: ('n' | 'N');
O: ('o' | 'O');
P: ('p' | 'P');
Q: ('q' | 'Q');
R: ('r' | 'R');
S: ('s' | 'S');
T: ('t' | 'T');
U: ('u' | 'U');
V: ('v' | 'V');
W: ('w' | 'W');
X: ('x' | 'X');
Y: ('y' | 'Y');
Z: ('z' | 'Z');

Identifier: NonDigit (NonDigit | Digit)*?;

ERROR: HASH E R R O R ~[\r\n]*;