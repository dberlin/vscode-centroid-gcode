; ICN_PATH = C:\intercon\Circler pocket.icn
; --- Header ---
N0001 ; CNC code generated by Intercon v4.09 Dev Test, Rev 7
; Description: 1.25 dia circular pocket
; Programmer: ded
; Date: 16-Feb-2016
  M25 G49 ; Goto Z home, cancel tool length offset 
  G17 G40 ; Setup for XY plane, no cutter comp 
  G20 ; inch measurements 
  G80 ; Cancel canned cycles 
  G90 ; absolute positioning 
  G98 ; canned cycle initial point return 
; --- Comment ---
N0002 ; 1/4" endmill 
; --- Tool #9 ---
;Tool Diameter =    0.2500  Spindle Speed = 4800
;1/4 inch end mill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0003 T9 M6
  S4800 M3
  G4 P3.00 ; pause for dwell
  G43 D9
; --- Circular Pocket ---
N0004 X0.0 Y0.0 Z0.132 H9
  G1 G91 X0.0 Y0.0 Z-0.1 F20.0
  X0.0 Y0.0 Z0.0 F10.0
  X0.0 Y0.0 Z-0.032 F20.0
  G3 X0.0 Y0.125 Z0.0 J0.0625 F10.0
  X0.125 Y-0.125 Z0.0 J-0.125
  X-0.125 Y0.25 Z0.0 I-0.3125
  X0.25 Y-0.25 Z0.0 J-0.25 F20.0
  X-0.25 Y0.375 Z0.0 I-0.4063
  X0.375 Y-0.375 Z0.0 J-0.375
  X-0.375 Y0.5 Z0.0 I-0.5208
  X0.0 Y0.0 Z0.0 J-0.5
  X0.0 Y-0.5 Z0.0 J-0.25
  G0 G90 X0.0 Y0.0 Z0.132
; --- Coolant Off ---
N0005 M9
; --- Spindle Off ---
N0006 M5
; --- Go to Z Home ---
N0007 M25 
  X0.0 Y0.0
; --- M & G Codes ---
N0008 
  G53 Y0.0
; --- End of Program ---
N0009 G49 H0 M25
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 