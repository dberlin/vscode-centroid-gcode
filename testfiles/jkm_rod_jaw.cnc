; ICN_PATH = C:\intercon\jkm_rod_jaw.icn
; --- Header ---
N0001 ; CNC code generated by Intercon v4.09 Dev Test, Rev 7
; Description: 
; Programmer: jkm
; Date: 07-Feb-2016
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
; --- Rapid Traverse ---
N0003 X-141.5 Y23.5 Z-1.5 H3
; --- Line ---
N0004 G1 X141.5 Y23.5 Z-1.5 F750.0
; --- Rapid Traverse ---
N0005 G0 X141.5 Y-23.5 Z-1.5
; --- Line ---
N0006 G1 X-141.5 Y-23.5 Z-1.5
; --- Tool #1 ---
;Tool Diameter =    2.0000  Spindle Speed = 1200
;Center Drill
  G49 H0 M25 
  G0 X0.0 Y0.0
N0007 T1 M6
  F750.0 S1200 M3
  G4 P3.00 ; pause for dwell
  G43 D1
; --- Circular Pocket ---
N0008 X-60.325 Y-7.3546 Z0.1 H1
  G1 G91 X0.0 Y0.0 Z-0.1 F350.0
  X0.0 Y0.0 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.0 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  X0.0 Y-4.875 Z0.0 J-2.4375
  G0 G90 X-60.325 Y-3.81 Z0.1
; --- Circular Pocket ---
N0009 X-60.325 Y-10.8991 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1 F350.0
  X0.0 Y0.0 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-0.2 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G3 X-8.09 Y-7.59 Z0.0 J-8.1065
  X0.0 Y0.0 Z0.0 I8.09
  X8.09 Y0.0 Z0.0 I4.045
  G0 G90 X-60.325 Y-3.81 Z0.1
; --- Circular Pocket ---
N0010 X60.325 Y-7.3546 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1 F350.0
  X0.0 Y0.0 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-7.0892 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.25 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  G1 X0.0 Y-8.4196 Z0.0 F375.0
  X0.0 Y7.0892 Z-1.0 F350.0
  X0.0 Y-3.5446 Z0.0 F375.0
  G2 X0.0 Y2.4375 Z0.0 J1.2188
  X-2.4375 Y-2.4375 Z0.0 J-2.4375
  X2.4375 Y4.875 Z0.0 I6.0938
  X0.0 Y0.0 Z0.0 J-4.875 F750.0
  X0.0 Y-4.875 Z0.0 J-2.4375
  G0 G90 X60.325 Y-3.81 Z0.1
; --- Circular Pocket ---
N0011 X60.325 Y-10.8991 Z0.1
  G1 G91 X0.0 Y0.0 Z-0.1 F350.0
  X0.0 Y0.0 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-2.5 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G1 X0.0 Y-14.6791 Z0.0 F375.0
  X0.0 Y14.1782 Z-0.2 F350.0
  X0.0 Y-7.0891 Z0.0 F375.0
  G2 X0.0 Y1.8975 Z0.0 J0.9487
  X-1.8975 Y-1.8975 Z0.0 J-1.8975
  X1.8975 Y3.795 Z0.0 I4.7437
  X-3.795 Y-3.795 Z0.0 J-3.795 F750.0
  X3.795 Y5.6925 Z0.0 I6.1669
  X-5.6925 Y-5.6925 Z0.0 J-5.6925
  X5.6925 Y7.59 Z0.0 I7.9063
  X0.0 Y0.0 Z0.0 J-7.59
  G3 X-8.09 Y-7.59 Z0.0 J-8.1065
  X0.0 Y0.0 Z0.0 I8.09
  X8.09 Y0.0 Z0.0 I4.045
  G0 G90 X60.325 Y-3.81 Z0.1
; --- End of Program ---
N0012 G49 H0 M25
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 