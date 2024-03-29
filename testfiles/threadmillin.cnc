; ICN_PATH = c:\intercon\threadmillin.icn
; --- Header ---
N0001 ; CNC code generated by Intercon v4.09 Dev Test, Rev 7
; Description: Threadmilling canned cycl
; Programmer: thc
; Date: 20-Dec-2017
  M25 G49 ; Goto Z home, cancel tool length offset 
  G17 G40 ; Setup for XY plane, no cutter comp 
  G20 ; inch measurements 
  G80 ; Cancel canned cycles 
  G90 ; absolute positioning 
  G98 ; canned cycle initial point return 
; --- Tool #3 ---
;Tool Diameter =    0.5000  Spindle Speed = 3200
;1/2" end mill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0002 T3 M6
  S3200 M3
  G4 P3.00 ; pause for dwell
  G43 D3
; --- Thread Mill ---
N0003 X0.8839 Y0.8839 Z0.1 H3
  G42 G17 ; Cutter Comp Right
  X0.8839 Y0.8839 Z-1.4
  G1 X0.8839 Y0.8839 Z-1.5 F30.0
  G2 X0.3536 Y0.3536 Z-1.5 I-0.2652 J-0.2652 F60.0
  G3 X0.3536 Y0.3536 Z-1.4231 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.3462 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.2692 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.1923 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.1154 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.0385 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.9615 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.8846 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.8077 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.7308 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.6538 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.5769 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.5 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.4231 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.3462 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.2692 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.1923 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.1154 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.0385 I-0.3536 J-0.3536
  X-0.3536 Y-0.3536 Z-0.0 I-0.3536 J-0.3536
  G2 X-0.8839 Y-0.8839 Z-0.0 I-0.2651 J-0.2651
  G40 G17 ; Cutter Comp Off
  G0 X-0.8839 Y-0.8839 Z-0.0
  X-0.8839 Y-0.8839 Z0.1
  G1 X-0.8839 Y-0.8839 Z0.1
  G0 X0.8839 Y0.8839 Z0.1
  G42 G17 ; Cutter Comp Right
  X0.8839 Y0.8839 Z-1.4
  G1 X0.8839 Y0.8839 Z-1.5 F30.0
  G2 X0.3536 Y0.3536 Z-1.5 I-0.2652 J-0.2652 F60.0
  G3 X0.3536 Y0.3536 Z-1.4231 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.3462 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.2692 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.1923 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.1154 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-1.0385 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.9615 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.8846 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.8077 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.7308 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.6538 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.5769 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.5 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.4231 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.3462 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.2692 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.1923 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.1154 I-0.3536 J-0.3536
  X0.3536 Y0.3536 Z-0.0385 I-0.3536 J-0.3536
  X-0.3536 Y-0.3536 Z-0.0 I-0.3536 J-0.3536
  G2 X-0.8839 Y-0.8839 Z-0.0 I-0.2651 J-0.2651
  G40 G17 ; Cutter Comp Off
  G0 X-0.8839 Y-0.8839 Z-0.0
  X-0.8839 Y-0.8839 Z0.1
  G1 X-0.8839 Y-0.8839 Z0.1
; --- End of Program ---
N0004 G49 H0 M25
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 
