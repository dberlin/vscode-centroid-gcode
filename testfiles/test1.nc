; ICN_PATH = C:\intercon\SEM_coverplat.icn
; --- Header ---
N0001 ; CNC code generated by Intercon v4.09 Dev Test, Rev 7
; Description: eztrak motor cover
; Programmer: jkm
; Date: 13-Jan-2015
  M25 G49 ; Goto Z home, cancel tool length offset 
  G17 G40 ; Setup for XY plane, no cutter comp 
  G20 ; inch measurements 
  G80 ; Cancel canned cycles 
  G90 ; absolute positioning 
  G98 ; canned cycle initial point return 
; --- Tool #1 ---
;Tool Diameter =    0.0500  Spindle Speed = 1200
;Center Drill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0002 T1 M6
  S1200 M3
  G4 P3.00 ; pause for dwell
  G43 D1
; --- Drill Array ---
N0003 X0.37 Y0.402 Z0.1 H1
  G81 X0.37 Y0.402 Z-0.05 R0.1 F15.0
  X1.88 Y0.402 
  X1.88 Y3.038 
  X0.37 Y3.038 
  G80
; --- Drill Bolt Hole Circle ---
N0004 X1.8166 Y2.5916 Z0.1
  G81 X1.8166 Y2.5916 Z-0.025 R0.1 F15.0
  X0.4334 Y2.5916 
  X0.4334 Y1.2084 
  X1.8166 Y1.2084 
  G80
; --- Tool #2 ---
;Tool Diameter =    0.1875  Spindle Speed = 1200
;Drill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0005 T2 M6
  F15.0 S1200 M3
  G4 P3.00 ; pause for dwell
  G43 D2
; --- Drill Array ---
N0006 X0.37 Y0.402 Z0.1 H2
  G10 P73 R0.025
  G73 X0.37 Y0.402 Z-0.35 R0.1 Q0.05 F15.0
  X1.88 Y0.402 
  X1.88 Y3.038 
  X0.37 Y3.038 
  G80
; --- Tool #2 ---
;Tool Diameter =    0.1875  Spindle Speed = 1200
;Drill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0007 T2 M6
  F15.0 S1200 M3
  G4 P3.00 ; pause for dwell
  G43 D2
; --- Drill Array ---
N0008 X0.37 Y0.402 Z0.1 H2
  G81 X0.37 Y0.402 Z-0.23 R0.1 F10.0
  X1.88 Y0.402 
  X1.88 Y3.038 
  X0.37 Y3.038 
  G80
; --- Tool #2 ---
;Tool Diameter =    0.1875  Spindle Speed = 1200
;Drill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0009 T2 M6
  F10.0 S1200 M3
  G4 P3.00 ; pause for dwell
  G43 D2
; --- Drill Bolt Hole Circle ---
N0010 X1.8166 Y2.5916 Z0.1 H2
  G10 P73 R0.015
  G73 X1.8166 Y2.5916 Z-0.375 R0.1 Q0.04 F10.0
  X0.4334 Y2.5916 
  X0.4334 Y1.2084 
  X1.8166 Y1.2084 
  G80
; --- Tool #9 ---
;Tool Diameter =    0.2500  Spindle Speed = 4800
;1/4 inch end mill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0011 T9 M6
  F10.0 S4800 M3
  G4 P3.00 ; pause for dwell
  G43 D9
; --- Circular Pocket ---
N0012 X1.125 Y1.8 Z0.1 H9
  G1 G91 X0.0 Y0.0 Z-0.1
  X0.0 Y0.0 Z0.0 F12.5
  X0.0 Y0.1 Z-0.1 F10.0
  G3 X0.0 Y0.1369 Z0.0 J0.0684 F12.5
  X0.1369 Y-0.1369 Z0.0 J-0.1369
  X-0.1369 Y0.2738 Z0.0 I-0.3422
  X0.2737 Y-0.2738 Z0.0 J-0.2738 F25.0
  X-0.2737 Y0.4106 Z0.0 I-0.4448
  X0.4106 Y-0.4106 Z0.0 J-0.4106
  X-0.4106 Y0.5475 Z0.0 I-0.5703
  X0.0 Y0.0 Z0.0 J-0.5475
  G1 X0.0 Y-0.6475 Z0.0 F12.5
  X0.0 Y0.1 Z-0.1 F10.0
  G3 X0.0 Y0.1369 Z0.0 J0.0684 F12.5
  X0.1369 Y-0.1369 Z0.0 J-0.1369
  X-0.1369 Y0.2738 Z0.0 I-0.3422
  X0.2737 Y-0.2738 Z0.0 J-0.2738 F25.0
  X-0.2737 Y0.4106 Z0.0 I-0.4448
  X0.4106 Y-0.4106 Z0.0 J-0.4106
  X-0.4106 Y0.5475 Z0.0 I-0.5703
  X0.0 Y0.0 Z0.0 J-0.5475
  G1 X0.0 Y-0.6475 Z0.0 F12.5
  X0.0 Y0.1 Z-0.06 F10.0
  G3 X0.0 Y0.1369 Z0.0 J0.0684 F12.5
  X0.1369 Y-0.1369 Z0.0 J-0.1369
  X-0.1369 Y0.2738 Z0.0 I-0.3422
  X0.2737 Y-0.2738 Z0.0 J-0.2738 F25.0
  X-0.2737 Y0.4106 Z0.0 I-0.4448
  X0.4106 Y-0.4106 Z0.0 J-0.4106
  X-0.4106 Y0.5475 Z0.0 I-0.5703
  X0.0 Y0.0 Z0.0 J-0.5475
  X-0.5625 Y-0.5475 Z0.0 J-0.5627
  X0.0 Y0.0 Z0.0 I0.5625
  X0.5625 Y0.0 Z0.0 I0.2813
  G0 G90 X1.125 Y1.9 Z0.1
; --- Frame (Outside Rect) ---
N0013 X-0.125 Y3.325 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1 F8.0
  X0.0 Y0.0 Z0.0 F25.0
  X0.0 Y0.1 Z-0.1 F8.0
  G2 X0.14 Y0.14 Z0.0 I0.14 F25.0
  G1 X2.22 Y0.0 Z0.0
  G2 X0.14 Y-0.14 Z0.0 J-0.14
  G1 X0.0 Y-3.41 Z0.0
  G2 X-0.14 Y-0.14 Z0.0 I-0.14
  G1 X-2.22 Y0.0 Z0.0
  G2 X-0.14 Y0.14 Z0.0 J0.14
  G1 X0.0 Y3.41 Z0.0
  X0.0 Y-0.1 Z0.0
  X0.0 Y0.1 Z-0.1 F8.0
  G2 X0.14 Y0.14 Z0.0 I0.14 F25.0
  G1 X2.22 Y0.0 Z0.0
  G2 X0.14 Y-0.14 Z0.0 J-0.14
  G1 X0.0 Y-3.41 Z0.0
  G2 X-0.14 Y-0.14 Z0.0 I-0.14
  G1 X-2.22 Y0.0 Z0.0
  G2 X-0.14 Y0.14 Z0.0 J0.14
  G1 X0.0 Y3.41 Z0.0
  X0.0 Y-0.1 Z0.0
  X0.0 Y0.1 Z-0.06 F8.0
  G2 X0.14 Y0.14 Z0.0 I0.14 F25.0
  G1 X2.22 Y0.0 Z0.0
  G2 X0.14 Y-0.14 Z0.0 J-0.14
  G1 X0.0 Y-3.41 Z0.0
  G2 X-0.14 Y-0.14 Z0.0 I-0.14
  G1 X-2.22 Y0.0 Z0.0
  G2 X-0.14 Y0.14 Z0.0 J0.14
  G1 X0.0 Y3.41 Z0.0
  G0 G90 X-0.125 Y3.425 Z0.1
; --- End of Program ---
N0014 G49 H0 M25
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 