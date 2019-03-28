; ICN_PATH = C:\intercon\helix.icn
; --- Header ---
N0001 ; CNC code generated by Intercon v2.31
; Description: Demo Helix Program
; Programmer: John Q. Public
; Date: Wed Oct 16 16:22:01 1996
  M25 G49 ; Goto Z home, cancel tool length offset 
  G17 G40 ; Setup for XY plane, no cutter comp 
  G20 ; inch measurements 
  G80 ; Cancel canned cycles 
  G90 ; absolute positioning 
  G98 ; canned cycle initial point return 
; --- Tool #1 ---
;Tool Diameter =    0.2500  Spindle Speed = 0
;                   
  G49 H0 M25 
  G0 X0.0 Y0.0
N0002 T1 M6
  S0
  G4 P3.00 ; pause for dwell
  G43 D1
; --- Rapid ---
N0003 M25 H1
  X0.0 Y0.0
; --- Rapid ---
N0004 X-0.001 Y0.0 Z-0.9
; --- Line ---
N0005 G1 X-0.001 Y0.0 Z-1.0 F10.0
; --- Comp Left ---
N0006 G41 G17 ; Cutter Comp Left
; --- Line ---
N0007 X0.0 Y0.0 Z-1.0
; --- Arc CCW ---
N0008 G3 X0.0 Y-1.9 Z-1.0 J-0.95 F20.0
; --- Arc CCW ---
N0009 X0.0 Y-1.9 Z-0.8 J1.9
; --- Arc CCW ---
N0010 X0.0 Y-1.9 Z-0.6 J1.9
; --- Arc CCW ---
N0011 X0.0 Y-1.9 Z-0.4 J1.9
; --- Arc CCW ---
N0012 X0.0 Y-1.9 Z-0.2 J1.9
; --- Arc CCW ---
N0013 X0.0 Y-1.9 Z0.0 J1.9
; --- Comp Off ---
N0014 G40 G17 ; Cutter Comp Off
; --- Line ---
N0015 G1 X0.0 Y0.0 Z0.0
; --- End Prog ---
N0016 G49 H0 M25 
  G0 X0.0 Y0.0
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 