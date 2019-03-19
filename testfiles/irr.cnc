; --- Header ---
N0010 ; CNC code generated by Intercon v8.11 Dev Test, Rev dg2 (DJGPP)
; Program: IRR
; Description: 
; Programmer: 
; Date: 28-Jun-2002
  M25 G49 ; Goto Z home, cancel tool length offset 
  G17 G40 ; Setup for XY plane, no cutter comp 
  G20 ; inch measurements 
  G80 ; Cancel canned cycles 
  G90 ; absolute positioning 
  G98 ; canned cycle initial point return 
; --- Cleanout ---
N0020 
  G0 X-0.0004 Y-5.275 F30.0
  G1 X-0.0004 Y-5.275 Z-0.125 F10.0
  X-3.4909 Y-5.275 F15.0
  G2 X-3.5213 Y-5.2744 J0.775 F15.0
  G1 X3.5206 Y-5.2744 F30.0
  G3 X4.2647 Y-4.5244 I-0.0305 J0.7744 F15.0
  G1 X-4.2655 Y-4.5244 F30.0
  G2 X-4.2659 Y-4.5 I0.7746 J0.0244 F15.0
  X-4.2568 Y-4.3817 I0.775 F15.0
  G1 X-4.163 Y-3.7744 F15.0
  X4.1623 Y-3.7744 F30.0
  X4.0466 Y-3.0244 F15.0
  X-4.0471 Y-3.0244 F30.0
  X-3.9312 Y-2.2744 F15.0
  X3.9308 Y-2.2744 F30.0
  X3.8151 Y-1.5244 F15.0
  X-3.8154 Y-1.5244 F30.0
  X-3.6995 Y-0.7744 F15.0
  X3.6994 Y-0.7744 F30.0
  X3.5881 Y-0.0534 F15.0
  G2 X3.5849 Y-0.0244 I0.3459 J0.0534 F15.0
  G1 X-3.5849 Y-0.0244 F30.0
  G3 X-3.584 Y0.0 I-0.3491 J0.0244 F15.0
  X-3.5881 Y0.0534 I-0.35 F15.0
  G1 X-3.6918 Y0.7256 F15.0
  X3.6918 Y0.7256 F30.0
  X3.8076 Y1.4756 F15.0
  X-3.8076 Y1.4756 F30.0
  X-3.9233 Y2.2256 F15.0
  X3.9233 Y2.2256 F30.0
  X4.039 Y2.9756 F15.0
  X-4.039 Y2.9756 F30.0
  X-4.1548 Y3.7256 F15.0
  X4.1548 Y3.7256 F30.0
  X4.256 Y4.3818 F15.0
  G3 X4.2647 Y4.4756 I-0.7659 J0.1182 F15.0
  G1 X-4.2647 Y4.4756 F30.0
  G2 X-4.2651 Y4.5 I0.7746 J0.0244 F15.0
  X-3.7624 Y5.2256 I0.775 F15.0
  G1 X3.7624 Y5.2256 F30.0
  X3.7624 Y5.2256 Z0.1
  G0 X-0.0004 Y-5.275
  G1 X-0.0004 Y-5.275 Z-0.125
  X-0.0004 Y-5.275
  X-3.4909 Y-5.275
  G2 X-4.2659 Y-4.5 J0.775
  X-4.2568 Y-4.3817 I0.775
  G1 X-3.5881 Y-0.0534
  G3 X-3.584 Y0.0 I-0.3459 J0.0534
  X-3.5881 Y0.0534 I-0.35
  G1 X-4.256 Y4.3818
  G2 X-4.2651 Y4.5 I0.7659 J0.1182
  X-3.4901 Y5.275 I0.775
  G1 X0.0 Y5.275
  X3.4901 Y5.275
  G2 X4.2651 Y4.5 J-0.775
  X4.256 Y4.3818 I-0.775
  G1 X3.5881 Y0.0534
  G3 X3.584 Y0.0 I0.3459 J-0.0534
  X3.5881 Y-0.0534 I0.35
  G1 X4.256 Y-4.3818
  G2 X4.2651 Y-4.5 I-0.7659 J-0.1182
  X3.4901 Y-5.275 I-0.775
  G1 X-0.0004 Y-5.275
  G0 X-0.0004 Y-5.275 Z0.1
  T5 M6
  F30.0 S0
  G4 P3.00 ; pause for dwell
  G43 D5
  G0 X-0.0004 Y-5.625
  G1 X-0.0004 Y-5.625 Z-0.125 H5
  X-0.0004 Y-5.625
  X-0.0004 Y-5.625
  X3.4901 Y-5.625
  G3 X4.6151 Y-4.5 J1.125
  X4.6019 Y-4.3284 I-1.125
  G1 X3.934 Y0.0
  X4.6019 Y4.3284
  G3 X4.6151 Y4.5 I-1.1118 J0.1716
  X3.4901 Y5.625 I-1.125
  G1 X0.0 Y5.625
  X-3.4901 Y5.625
  G3 X-4.6151 Y4.5 J-1.125
  X-4.6019 Y4.3284 I1.125
  G1 X-3.934 Y0.0
  X-4.6027 Y-4.3282
  G3 X-4.6159 Y-4.5 I1.1118 J-0.1718
  X-3.4909 Y-5.625 I1.125
  G1 X-0.0004 Y-5.625
  G0 X-0.0004 Y-5.625 Z0.1
; --- End Cleanout ---
; --- End Prog ---
N0120 G49 H0 M25 
  X0.0 Y5.625
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 
