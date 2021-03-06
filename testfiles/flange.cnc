; ICN_PATH = C:\intercon\flange.icn
; --- Header ---
N0001 ; CNC code generated by Intercon v4.09 Dev Test, Rev 7
; Description: 
; Programmer:                     
; Date: Tue Feb 20 16:56:29 2001
  M25 G49 ; Goto Z home, cancel tool length offset 
  G17 G40 ; Setup for XY plane, no cutter comp 
  G20 ; inch measurements 
  G80 ; Cancel canned cycles 
  G90 ; absolute positioning 
  G98 ; canned cycle initial point return 
; --- Tool #9 ---
;Tool Diameter =    0.2500  Spindle Speed = 4800
;1/4 inch end mill
  G49 H0 M25 
  G0 X-2.0 Y-2.0
N0002 T9 M6
  S4800 M3
  G4 P3.00 ; pause for dwell
  G43 D9
; --- Circular Pocket ---
N0003 X0.0 Y-0.25 Z0.1 H9
  G1 G91 X0.0 Y0.0 Z-0.1 F2.0
  X0.0 Y0.0 Z0.0 F10.0
  X0.0 Y0.25 Z-0.25 F2.0
  G2 X0.0 Y0.1865 Z0.0 J0.0932 F10.0
  X-0.1865 Y-0.1865 Z0.0 J-0.1865
  X0.1865 Y0.373 Z0.0 I0.4662
  X0.0 Y0.0 Z0.0 J-0.373 F20.0
  G1 X0.0 Y-0.623 Z0.0 F10.0
  X0.0 Y0.25 Z-0.25 F2.0
  G2 X0.0 Y0.1865 Z0.0 J0.0932 F10.0
  X-0.1865 Y-0.1865 Z0.0 J-0.1865
  X0.1865 Y0.373 Z0.0 I0.4662
  X0.0 Y0.0 Z0.0 J-0.373 F20.0
  G3 X-0.375 Y-0.373 Z0.0 J-0.375 F10.0
  X0.0 Y0.0 Z0.0 I0.375
  X0.375 Y0.0 Z0.0 I0.1875
  G0 G90 X0.0 Y0.0 Z0.1
; --- Drill Bolt Hole Circle ---
N0004 X0.8839 Y0.8839 Z0.25
  G81 X0.8839 Y0.8839 Z-0.5 R0.1 F2.0
  X-0.8839 Y0.8839 
  X-0.8839 Y-0.8839 
  X0.8839 Y-0.8839 
  G80
; --- Frame (Outside Rect) ---
N0005 X1.0 Y1.625 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1
  X0.0 Y0.0 Z0.0 F10.0
  X0.25 Y0.0 Z-0.25 F2.0
  X-2.5 Y0.0 Z0.0 F10.0
  G3 X-0.375 Y-0.375 Z0.0 J-0.375
  G1 X0.0 Y-2.5 Z0.0
  G3 X0.375 Y-0.375 Z0.0 I0.375
  G1 X2.5 Y0.0 Z0.0
  G3 X0.375 Y0.375 Z0.0 J0.375
  G1 X0.0 Y2.5 Z0.0
  G3 X-0.375 Y0.375 Z0.0 I-0.375
  G1 X-0.25 Y0.0 Z0.0
  X0.25 Y0.0 Z-0.25 F2.0
  X-2.5 Y0.0 Z0.0 F10.0
  G3 X-0.375 Y-0.375 Z0.0 J-0.375
  G1 X0.0 Y-2.5 Z0.0
  G3 X0.375 Y-0.375 Z0.0 I0.375
  G1 X2.5 Y0.0 Z0.0
  G3 X0.375 Y0.375 Z0.0 J0.375
  G1 X0.0 Y2.5 Z0.0
  G3 X-0.375 Y0.375 Z0.0 I-0.375
  G0 G90 X1.25 Y1.625 Z0.1
; --- Repeat ---
N0006 ; Begin code repetitions
; Retraction move 
  X6.0 Y-0.25 Z0.25
; Move to start of contour 
  X6.0 Y-0.25 Z0.1
; --- Circular Pocket ---
  X6.0 Y-0.25 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1 F2.0
  X0.0 Y0.0 Z0.0 F10.0
  X0.0 Y0.25 Z-0.25 F2.0
  G2 X0.0 Y0.1865 Z0.0 J0.0932 F10.0
  X-0.1865 Y-0.1865 Z0.0 J-0.1865
  X0.1865 Y0.373 Z0.0 I0.4662
  X0.0 Y0.0 Z0.0 J-0.373 F20.0
  G1 X0.0 Y-0.623 Z0.0 F10.0
  X0.0 Y0.25 Z-0.25 F2.0
  G2 X0.0 Y0.1865 Z0.0 J0.0932 F10.0
  X-0.1865 Y-0.1865 Z0.0 J-0.1865
  X0.1865 Y0.373 Z0.0 I0.4662
  X0.0 Y0.0 Z0.0 J-0.373 F20.0
  G3 X-0.375 Y-0.373 Z0.0 J-0.375 F10.0
  X0.0 Y0.0 Z0.0 I0.375
  X0.375 Y0.0 Z0.0 I0.1875
  G0 G90 X6.0 Y0.0 Z0.1
; --- Drill Bolt Hole Circle ---
  X6.8839 Y0.8839 Z0.25
  G81 X6.8839 Y0.8839 Z-0.5 R0.1 F2.0
  X5.1161 Y0.8839 
  X5.1161 Y-0.8839 
  X6.8839 Y-0.8839 
  G80
; --- Frame ---
  X7.0 Y1.625 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1
  X0.0 Y0.0 Z0.0 F10.0
  X0.25 Y0.0 Z-0.25 F2.0
  X-2.5 Y0.0 Z0.0 F10.0
  G3 X-0.375 Y-0.375 Z0.0 J-0.375
  G1 X0.0 Y-2.5 Z0.0
  G3 X0.375 Y-0.375 Z0.0 I0.375
  G1 X2.5 Y0.0 Z0.0
  G3 X0.375 Y0.375 Z0.0 J0.375
  G1 X0.0 Y2.5 Z0.0
  G3 X-0.375 Y0.375 Z0.0 I-0.375
  G1 X-0.25 Y0.0 Z0.0
  X0.25 Y0.0 Z-0.25 F2.0
  X-2.5 Y0.0 Z0.0 F10.0
  G3 X-0.375 Y-0.375 Z0.0 J-0.375
  G1 X0.0 Y-2.5 Z0.0
  G3 X0.375 Y-0.375 Z0.0 I0.375
  G1 X2.5 Y0.0 Z0.0
  G3 X0.375 Y0.375 Z0.0 J0.375
  G1 X0.0 Y2.5 Z0.0
  G3 X-0.375 Y0.375 Z0.0 I-0.375
  G0 G90 X7.25 Y1.625 Z0.1
; Retraction move 
  X12.0 Y-0.25 Z0.25
; Move to start of contour 
  X12.0 Y-0.25 Z0.1
; --- Circular Pocket ---
  X12.0 Y-0.25 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1 F2.0
  X0.0 Y0.0 Z0.0 F10.0
  X0.0 Y0.25 Z-0.25 F2.0
  G2 X0.0 Y0.1865 Z0.0 J0.0932 F10.0
  X-0.1865 Y-0.1865 Z0.0 J-0.1865
  X0.1865 Y0.373 Z0.0 I0.4663
  X0.0 Y0.0 Z0.0 J-0.373 F20.0
  G1 X0.0 Y-0.623 Z0.0 F10.0
  X0.0 Y0.25 Z-0.25 F2.0
  G2 X0.0 Y0.1865 Z0.0 J0.0932 F10.0
  X-0.1865 Y-0.1865 Z0.0 J-0.1865
  X0.1865 Y0.373 Z0.0 I0.4663
  X0.0 Y0.0 Z0.0 J-0.373 F20.0
  G3 X-0.375 Y-0.373 Z0.0 J-0.375 F10.0
  X0.0 Y0.0 Z0.0 I0.375
  X0.375 Y0.0 Z0.0 I0.1875
  G0 G90 X12.0 Y0.0 Z0.1
; --- Drill Bolt Hole Circle ---
  X12.8839 Y0.8839 Z0.25
  G81 X12.8839 Y0.8839 Z-0.5 R0.1 F2.0
  X11.1161 Y0.8839 
  X11.1161 Y-0.8839 
  X12.8839 Y-0.8839 
  G80
; --- Frame ---
  X13.0 Y1.625 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1
  X0.0 Y0.0 Z0.0 F10.0
  X0.25 Y0.0 Z-0.25 F2.0
  X-2.5 Y0.0 Z0.0 F10.0
  G3 X-0.375 Y-0.375 Z0.0 J-0.375
  G1 X0.0 Y-2.5 Z0.0
  G3 X0.375 Y-0.375 Z0.0 I0.375
  G1 X2.5 Y0.0 Z0.0
  G3 X0.375 Y0.375 Z0.0 J0.375
  G1 X0.0 Y2.5 Z0.0
  G3 X-0.375 Y0.375 Z0.0 I-0.375
  G1 X-0.25 Y0.0 Z0.0
  X0.25 Y0.0 Z-0.25 F2.0
  X-2.5 Y0.0 Z0.0 F10.0
  G3 X-0.375 Y-0.375 Z0.0 J-0.375
  G1 X0.0 Y-2.5 Z0.0
  G3 X0.375 Y-0.375 Z0.0 I0.375
  G1 X2.5 Y0.0 Z0.0
  G3 X0.375 Y0.375 Z0.0 J0.375
  G1 X0.0 Y2.5 Z0.0
  G3 X-0.375 Y0.375 Z0.0 I-0.375
  G0 G90 X13.25 Y1.625 Z0.1
; --- End of Program ---
N0007 G49 H0 M25
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 
