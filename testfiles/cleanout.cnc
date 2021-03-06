; ICN_PATH = c:\intercon\cleanout.icn
; --- Header ---
N0001 ; CNC code generated by Intercon v4.09 Dev Test, Rev 7
; Description: cleanout cycle
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
; --- Pocket Cleanout ---
N0003 
  X2.3943 Y2.0054 Z0.1 H3 F40.0
  G1 X2.3943 Y2.0054 Z-0.22 F30.0
  G2 X3.1434 Y1.9038 Z-0.22 I0.3359 J-0.3359 F60.0
  X3.7265 Y0.1184 Z-0.22 I-4.1104 J-2.3303
  X3.1312 Y-0.3951 Z-0.22 I-0.4719 J-0.0548
  G3 X0.0365 Y-0.3524 Z-0.22 I-1.6312 J-6.0593
  G1 X2.3943 Y2.0054 Z-0.22
  X2.5711 Y1.8286 Z-0.22
  G2 X2.9259 Y1.7805 Z-0.22 I0.1591 J-0.1591
  X3.4781 Y0.0895 Z-0.22 I-3.8929 J-2.207
  X3.1962 Y-0.1537 Z-0.22 I-0.2235 J-0.0259
  G3 X0.7724 Y0.03 Z-0.22 I-1.6962 J-6.3007
  G1 X2.5711 Y1.8286 Z-0.22
  X2.7245 Y1.6285 Z-0.22
  G2 X3.2254 Y0.0973 Z-0.22 I-3.6915 J-2.055
  G3 X1.4161 Y0.3201 Z-0.22 I-1.7254 J-6.5517
  G1 X2.7245 Y1.6285 Z-0.22
  X2.6568 Y1.2072 Z-0.22
  G2 X2.9154 Y0.4266 Z-0.22 I-3.6238 J-1.6337
  G3 X2.0022 Y0.5527 Z-0.22 I-1.4154 J-6.881
  G1 X2.6568 Y1.2072 Z-0.22
  X2.5638 Y0.7606 Z-0.22
  G2 X2.5701 Y0.7415 Z-0.22 I-3.5308 J-1.1871
  G3 X2.5479 Y0.7448 Z-0.22 I-1.0701 J-7.1959
  G1 X2.5638 Y0.7606 Z-0.22
  G0 X2.3943 Y2.0054 Z0.1
  G1 X2.3943 Y2.0054 Z-0.44 F30.0
  G2 X3.1434 Y1.9038 Z-0.44 I0.3359 J-0.3359 F60.0
  X3.7265 Y0.1184 Z-0.44 I-4.1104 J-2.3303
  X3.1312 Y-0.3951 Z-0.44 I-0.4719 J-0.0548
  G3 X0.0365 Y-0.3524 Z-0.44 I-1.6312 J-6.0593
  G1 X2.3943 Y2.0054 Z-0.44
  X2.5711 Y1.8286 Z-0.44
  G2 X2.9259 Y1.7805 Z-0.44 I0.1591 J-0.1591
  X3.4781 Y0.0895 Z-0.44 I-3.8929 J-2.207
  X3.1962 Y-0.1537 Z-0.44 I-0.2235 J-0.0259
  G3 X0.7724 Y0.03 Z-0.44 I-1.6962 J-6.3007
  G1 X2.5711 Y1.8286 Z-0.44
  X2.7245 Y1.6285 Z-0.44
  G2 X3.2254 Y0.0973 Z-0.44 I-3.6915 J-2.055
  G3 X1.4161 Y0.3201 Z-0.44 I-1.7254 J-6.5517
  G1 X2.7245 Y1.6285 Z-0.44
  X2.6568 Y1.2072 Z-0.44
  G2 X2.9154 Y0.4266 Z-0.44 I-3.6238 J-1.6337
  G3 X2.0022 Y0.5527 Z-0.44 I-1.4154 J-6.881
  G1 X2.6568 Y1.2072 Z-0.44
  X2.5638 Y0.7606 Z-0.44
  G2 X2.5701 Y0.7415 Z-0.44 I-3.5308 J-1.1871
  G3 X2.5479 Y0.7448 Z-0.44 I-1.0701 J-7.1959
  G1 X2.5638 Y0.7606 Z-0.44
  G0 X2.3943 Y2.0054 Z0.1
  G1 X2.3943 Y2.0054 Z-0.5 F30.0
  G2 X3.1434 Y1.9038 Z-0.5 I0.3359 J-0.3359 F60.0
  X3.7265 Y0.1184 Z-0.5 I-4.1104 J-2.3303
  X3.1312 Y-0.3951 Z-0.5 I-0.4719 J-0.0548
  G3 X0.0365 Y-0.3524 Z-0.5 I-1.6312 J-6.0593
  G1 X2.3943 Y2.0054 Z-0.5
  X2.5711 Y1.8286 Z-0.5
  G2 X2.9259 Y1.7805 Z-0.5 I0.1591 J-0.1591
  X3.4781 Y0.0895 Z-0.5 I-3.8929 J-2.207
  X3.1962 Y-0.1537 Z-0.5 I-0.2235 J-0.0259
  G3 X0.7724 Y0.03 Z-0.5 I-1.6962 J-6.3007
  G1 X2.5711 Y1.8286 Z-0.5
  X2.7245 Y1.6285 Z-0.5
  G2 X3.2254 Y0.0973 Z-0.5 I-3.6915 J-2.055
  G3 X1.4161 Y0.3201 Z-0.5 I-1.7254 J-6.5517
  G1 X2.7245 Y1.6285 Z-0.5
  X2.6568 Y1.2072 Z-0.5
  G2 X2.9154 Y0.4266 Z-0.5 I-3.6238 J-1.6337
  G3 X2.0022 Y0.5527 Z-0.5 I-1.4154 J-6.881
  G1 X2.6568 Y1.2072 Z-0.5
  X2.5638 Y0.7606 Z-0.5
  G2 X2.5701 Y0.7415 Z-0.5 I-3.5308 J-1.1871
  G3 X2.5479 Y0.7448 Z-0.5 I-1.0701 J-7.1959
  G1 X2.5638 Y0.7606 Z-0.5
  G0 X1.5195 Y0.8124 Z0.1
  G1 X1.5195 Y0.8124 Z-0.5 F30.0
  G3 X1.166 Y0.8124 Z-0.5 I-0.1768 J-0.1768 F40.0
  G1 X-0.0447 Y-0.3983 Z-0.5
  G2 X3.1247 Y-0.4192 Z-0.5 I1.5447 J-6.0561
  G3 X3.7513 Y0.1213 Z-0.5 I0.1299 J0.4828
  X3.1651 Y1.9161 Z-0.5 I-4.7183 J-0.5478
  X2.3766 Y2.0231 Z-0.5 I-0.4349 J-0.2466
  G1 X1.166 Y0.8124 Z-0.5
  G3 X1.166 Y0.4589 Z-0.5 I0.1767 J-0.1768
; --- End Pocket Cleanout ---
; --- End of Program ---
N0008 G49 H0 M25
  G40 ; Cutter Comp Off 
  M5 ; Spindle Off 
  M9 ; Coolant Off 
  G80 ; Cancel canned cycles 
  M30 ; End of program 
