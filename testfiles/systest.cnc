   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
; $Id: systest.cnc,v 1.1.1.1 2006/01/05 14:30:21 kdennison Exp $ 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
   
  o9101 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ;  Check that travel limits are set and axis is homed 
  ;  for each axis that has a valid axis label 
  ;  (other than N, M, or S) 
  ; 
  m123 ; 
  m123 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  m123 ;;   Checking travel limits and home set 
  #[z] = 1 
n5 
  if [#(20100+#z) == 77] then goto 7  ; skip if axis label is 'M' 
  if [#(20100+#z) == 78] then goto 7  ; skip if axis label is 'N' 
  if [#(20100+#z) == 83] then goto 7  ; skip if axis label is 'S' 
   
  if [not ((#(23500+#z) < 0) || (#(23600+#z) > 0))] then goto 10 
   
n6 
  ; Check that the machine has been homed for axis(n) 
  if [#(23700+#z) == 0] then goto 20 
n7 
  #[z] = #z + 1 
  if [#z < 6] goto 5 
  m123 ;Travel limits set and machine is homed. 
  goto 100 
   
n10 
  ; Check to see if axis is set to rotary before failing 
  if [#z <= 4 && ((#(9090+#z) and 1) != 1)]  goto 15 
  if [#z >= 5 && ((#(9166+(#z-4)) and 1) != 1)]  goto 15 
  m123 l1;Axis 
  m123 l1q0p#z 
  m123 ;is set as rotary without travel limits. 
  goto 6 
   
n15 
  m123 l1 ;***  FAILURE: AXIS 
  m123 q0l1p#z 
  m123 ;INVALID TRAVEL LIMITS 
  goto 99 
   
n20 
  m123 l1 ;***  FAILURE: AXIS 
  m123 q0l1p#z 
  m123 ;NOT HOMED 
  goto 99 
   
n99 
  #149 = 1  ; flag error 
   
n100 
  M99 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
   
   
  o9102 
  ; 
  ;  Home switch testing 
  ; 
  ; 
  ;  Variables used in limit/home switch testing 
  ;  #140 = number of times to test each switch 
  ;  #29101- home posiiton recordings 
  ;  #29201- home count recordings  (UNUNSED) 
  ;  #29301- off limit position recordings 
  ;  #29401- off limit counts recordings (UNUSED) 
  m123 ; 
  m123 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  m123 ;; Starting home switch testing 
  if #50001 
  ;#140 = 3       ; number of times to check each switch 
  #143 = 8       ; denominator of fraction of encoder revolution 
                 ; used to determine possible homing error 
                 ;  
  #[t] = 0.0005  ; tolerance for home position repeatability 
  #[o] = 0.002   ; tolerance for off limit switch repeatability 
  if [#25001 == 21] then #[t] = #t * 25.4 
  if [#25001 == 21] then #[o] = #o * 25.4 
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Check that homing is set to Ref Mark-HS or Home Switch 
  ; Display warning if set to Jog 
  ; 
  if [#25007 == 0] goto 1000 
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Check that every axis with a valid axis label 
  ; other than (M, N, or S) has at least one home switch 
  ; input assigned. Display warning if not. 
  ; Exception for rotary axes. 
  ; 
  #[z] = 1 
   
n2 
  if [#(20100+#z) == 77] then goto 3  ; skip if axis label is 'M' 
  if [#(20100+#z) == 78] then goto 3  ; skip if axis label is 'N' 
  if [#(20100+#z) == 83] then goto 3  ; skip if axis label is 'S' 
   
  if [not ((#(21300+#z) == 0) && (#(21400+#z) == 0))] goto 3 
   
  ; Check to see if axis is set to rotary before warning 
  if [#z <= 4 && ((#(9090+#z) and 1) == 1)]  goto 3 
  if [#z >= 5 && ((#(9166+(#z-4)) and 1) == 1)]  goto 3 
   
  
  M123 ; 
  M123 l1 ;*  WARNING: Axis 
  M123 l1q0p#z 
  M123 ;has no assigned home switch. 
   
n3 
  #[z] = #z + 1 
  if [#z < 6] goto 2 
   
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ;      Loop through axes 
  ; 
  #[z] = 1 
n1 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Check for axis(n) minus switch 
  ; 
  #[r] = 11  ; return N number 
  if [#(21300+#z) == 0] goto #r 
  #[s] = 91  ; home minus 
  goto 98 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ;  Check for axis(n) plus switch 
  ;  test only if non-zero and not the same as minus switch 
n11 
  ; record machine home minus position 
  #[29500+#z] = #29101 
  #[r] = 12 ; return N number 
  if [(#(21400+#z) == 0) || (#(21400+#z) == #(21300+#z))] goto #r 
  #[s] = 92 ; home plus 
  goto 98 
   
n12 
  ; record machine home plus position 
  #[29600+#z] = #29101 
   
  if [#(20100+#z) == 77] then goto 50  ; skip if axis label is 'M' 
  if [#(20100+#z) == 78] then goto 50  ; skip if axis label is 'N' 
  if [#(20100+#z) == 83] then goto 50  ; skip if axis label is 'S' 
   
  ;;;;;;;;;;;;;;;;; 
  ; Compare distances between home positions with travel limits. 
  ; Travel limit distance must be less than distance between 
  ; home positions and within 1.00 inch. 
  ; 
  ; For systems that have one home switch on an axis, 
  ; we attempt a move from the home position out to the 
  ; travel limit distance as a check. Note that in this 
  ; case, we cannot detect a travel limit set too short. 
  ; A travel limit that is too long in this case will 
  ; cause the test program to abort with a full power 
  ; without motion or position error. 
  ; 
  ;;;; 
  ; Check for home switches at both ends 
  if [#(21300+#z) == #(21400+#z)] goto 30 
  if [(#(21300+#z) != 0) && (#(21400+#z) != 0)] goto 20 
  goto 30 
   
n20 
  ; 
  #101 = #(29600+#z) - #(29500+#z) 
  #102 = #(23600+#z) - #(23500+#z)  
  #103 = #101 - #102 
  m123 ;Axis has both minus and plus home switches 
  m123 l1;-Distance between home positions is 
  m123 p#101 
  m123 l1;-Distance between travel limits  is 
  m123 p#102 
  m123 l1;-Difference between distances is 
  m123 p#103 
  #111 = 1.0 
  if [#25001 == 21] then #111 = #111 * 25.4 
  if [(#103 >= 0) && (#103 < #111)] then goto 50 
   
  m123 ;*** FAILURE Travel limits set incorrectly 
  #149 = 1 
  if [#112 == 0] then goto 9999 
  goto 50 
   
n30 
  m123 ; 
  m123 ;-- Checking minus travel limit 
  #[w] = 23500 
n33 
  m123 l1;Moving axis 
  m123 l1q0p#z 
  m123 ;to machine home position 
   
  if [#(20100+#z) == 65] then g90 g53 A0 
  if [#(20100+#z) == 66] then g90 g53 B0 
  if [#(20100+#z) == 67] then g90 g53 C0 
  if [#(20100+#z) == 85] then g90 g53 U0 
  if [#(20100+#z) == 86] then g90 g53 V0 
  if [#(20100+#z) == 87] then g90 g53 W0 
  if [#(20100+#z) == 88] then g90 g53 X0 
  if [#(20100+#z) == 89] then g90 g53 Y0 
  if [#(20100+#z) == 90] then g90 g53 Z0 
   
  #109 = #(#w+#z) 
   
  m123 l1;Moving incrementally 
  m123 p#109 
  g91 g1 f[#(20200+#z)]  ; move at slow jog rate for axis 
  
  if [#(20100+#z) == 65] then A#109 
  if [#(20100+#z) == 66] then B#109 
  if [#(20100+#z) == 67] then C#109 
  if [#(20100+#z) == 85] then U#109 
  if [#(20100+#z) == 86] then V#109 
  if [#(20100+#z) == 87] then W#109 
  if [#(20100+#z) == 88] then X#109 
  if [#(20100+#z) == 89] then Y#109 
  if [#(20100+#z) == 90] then Z#109 
  g90 
   
  if [#w == 23600] goto 50 
  #[w] = 23600 
  m123 ; 
  m123 ;-- Checking plus travel limit 
  goto 33 
   
n50 
  ; move to center of travel 
  if [#(20100+#z) == 65] then g90 g53 A0 
  if [#(20100+#z) == 66] then g90 g53 B0 
  if [#(20100+#z) == 67] then g90 g53 C0 
  if [#(20100+#z) == 85] then g90 g53 U0 
  if [#(20100+#z) == 86] then g90 g53 V0 
  if [#(20100+#z) == 87] then g90 g53 W0 
  if [#(20100+#z) == 88] then g90 g53 X0 
  if [#(20100+#z) == 89] then g90 g53 Y0 
  if [#(20100+#z) == 90] then g90 g53 Z0 
  #118 = [(#(23500+#z) + #(23600+#z)) / 2.0] 
  if [#(20100+#z) == 65] then g91 A#118 
  if [#(20100+#z) == 66] then g91 B#118 
  if [#(20100+#z) == 67] then g91 C#118 
  if [#(20100+#z) == 85] then g91 U#118 
  if [#(20100+#z) == 86] then g91 V#118 
  if [#(20100+#z) == 87] then g91 W#118 
  if [#(20100+#z) == 88] then g91 X#118 
  if [#(20100+#z) == 89] then g91 Y#118 
  if [#(20100+#z) == 90] then g91 Z#118 
  g90 
  #[z] = #z + 1 
  if [#z < 6] goto 1 
   
  goto 101 
   
n98 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; 
  ; Subroutine to check home switch 
  ; returns to line specified by #r 
  ; 
  if [#(20100+#z) == 77] then goto #r  ; return if axis label is 'M' 
  if [#(20100+#z) == 78] then goto #r  ; return if axis label is 'N' 
  if [#(20100+#z) == 83] then goto #r  ; return if axis label is 'S' 
   
  M123    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  M123 L1 ;    Homing axis 
  M123 L1q0 P#z 
   
  if [#s == 91] then M123 ;minus 
  if [#s == 92] then M123 ;plus 
   
   
  #101 = 1/(#143*#(20400+#z)) 
  #109 = #143 - 1 
  #102 = #101 * #109 
  #104 = #101 * #143 
  M123 L1 ;1 / 
  m123 q0l1 p#143 
  m123 L1 ;turn distance is 
  M123 p#101 
  m123 q0l1p#109 
  M123 L1;/ 
  m123 q0l1p#143 
  m123 l1;turn distance is 
  M123 p#102 
  M123 L1 ;full  turn distance is 
  M123 p#104 
  
  M123 ;Off switch|  error  |  home  |  error  | differnce 
  #[i] = 1 
n99 
  if [#(20100+#z) == 65] then M#s/A L1 
  if [#(20100+#z) == 66] then M#s/B L1 
  if [#(20100+#z) == 67] then M#s/C L1 
  if [#(20100+#z) == 85] then M#s/U L1 
  if [#(20100+#z) == 86] then M#s/V L1 
  if [#(20100+#z) == 87] then M#s/W L1 
  if [#(20100+#z) == 88] then M#s/X L1 
  if [#(20100+#z) == 89] then M#s/Y L1 
  if [#(20100+#z) == 90] then M#s/Z L1 
  if #50001 
  #[29300+#i] = #[5020+#z] 
  #[29400+#i] = #[23800+#z] 
  if [#i == 1] then #29300 = #29301 ; record first for error stats 
  if [#i == 1] then #29400 = #29401 ; record first for error stats 
  ; log the off switch position and error 
  M123 r9q4L1 p#[29300+#i] 
  #146 = abs(#29300 - #(29300+#i)) 
  M123 r9q4L1 p#146 
   
  if [#(20100+#z) == 65] then M#s/A 
  if [#(20100+#z) == 66] then M#s/B 
  if [#(20100+#z) == 67] then M#s/C 
  if [#(20100+#z) == 85] then M#s/U 
  if [#(20100+#z) == 86] then M#s/V 
  if [#(20100+#z) == 87] then M#s/W 
  if [#(20100+#z) == 88] then M#s/X 
  if [#(20100+#z) == 89] then M#s/Y 
  if [#(20100+#z) == 90] then M#s/Z 
  if #50001 
  #[29100+#i] = #[5020+#z] 
  #[29200+#i] = #[23800+#z] 
  if [#i == 1] then #29100 = #29101 ; record first for error stats 
  if [#i == 1] then #29200 = #29201 ; record first for error stats 
  ; log home position and error 
  M123 r9q4L1 p#[29100+#i] 
  #146 = abs(#29100-#(29100+#i)) 
  M123 r9q4l1 P#146 
  ; log distance between off switch and home position 
  #146 = abs[#(29100+#i)-#(29300+#i)] 
  M123 r9q4 P#146 
  #[i] = #i + 1 
  if [#i <= #140] goto 99 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Analyze data 
  ; 
  ; 
  ; Check that all measurements are within tolerance. 
  ; Count the number of errors 
  ; 
  #29903 = -9999.999    ; max off switch position 
  #29904 =  9999.999    ; min 
  #29901 = -9999.999    ; max home position 
  #29902 =  9999.999    ; min 
   
  #[v] = 0 
  #[i] = 1 
n97 
   
  #141 = abs(#(29100+#i)-#29100)  ; home position error 
  #142 = abs(#(29300+#i)-#29300)  ; off switch error 
   
  if [#(29100+#i) > #29901] then #29901 = #(29100+#i) 
  if [#(29300+#i) > #29903] then #29903 = #(29300+#i) 
   
  if [#(29100+#i) < #29902] then #29902 = #(29100+#i) 
  if [#(29300+#i) < #29904] then #29904 = #(29300+#i) 
   
  if [#141 > #t] then #[v] = #v + 1 
  ;if [#142 > #o] then #[v] = #v + 1 
  #[i] = #[i] + 1 
  if [#i <= #140] goto 97 
  ; 
  ; log max/min difference 
  ; 
  M123 ;Off switch      Max     Min    Difference 
  M123 L1 ;        
  M123 r9q4l1 p#29903 
  M123 r9q4l1 p#29904 
  #146 = #29903 - #29904 
  M123 r9q4 p#146 
   
  M123 ;home posiiton   Max     Min    Difference 
  M123 L1 ;        
  M123 r9q4l1 p#29901 
  M123 r9q4l1 p#29902 
  #146 = #29901 - #29902 
  M123 r9q4 p#146 
   
  if [#v == 0] then goto 88 
  
  #149 = 1 
  M123 ;*** FAILURE MACHINE HOME SWITCH REPEATABILITY  
  ; 
  ; Suspect limit switch problem 
  ; if error in homing positions 
  ; is approximately one full turn. 
  ; Otherwise, suspect faulty index pulse. 
  ; 
  #111 = 0.001 
  if [#25001 == 21] then #111 = #111 * 25.4 
  
  if [abs(#146-#104) < #111] then  M123 ;--SUSPECTED LIMIT SWITCH PROBLEM 
  if [abs(#146-#104) >= #111] then M123 ;--SUSPECTED ENCODER INDEX PROBLEM 
  if [#112 == 0] goto 9999 
  ; 
  ; Check for conditions in which home position is within 
  ; 1/#143 revolution of coming off switch 
  ; 
n88 
  #[y] = abs(#29100 - #29300) 
  if [(#y > #101) && (#y < (#102))] then goto #r 
  M123 ;*** FAILURE Home position too close to encoder index pulse 
  #149 = 1 
  if [#112 == 1] then goto #r 
  goto 9999 
   
   
n101 M123 ;Finished testing home/limit switches 
  goto 10000 
   
n1000 
   
  M123 ; 
  M123 ;* WARNING: Machine home at power up set to Jog 
  M123 ;           Home switch testing skipped 
  M123 ; 
  goto 10000 
   
N9999 
  #149 = 1 
   
N10000 
  M99 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
  o9201 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Subprogram to measure tool height using TT-1 located at G30 P3 
  ; This subprogram assumes that a data file has been previously opened. 
  ; 
  ; This routine uses variable #29000 - #29xxx to record Z machine 
  ; positions.  If these variables are zero, the routine makes 
  ; an initial measurement.  Otherwise, it makes a tolerance check. 
  ; 
  ; #t is the tolerance 
  ; 
  if #50001 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Determine TT-1 input number 
  ; Default to input specified in machine parameter 11,
  ; if machine parameter 44 = 0. 
  ;  
  #[z] = -#9011 
  if [#9044 != 0] then #[z] = -#9044 
  m5        ; turn off spindle 
  m9        ; turn off coolant 
  g30 p3    ; position to tool detector position 
   
  ; DETERMINING TOOL NUMBER IN SPINDLE 
  ; WHEN THIS LOOP FINISHES, #115 = TOOL NUMBER IN THE SPINDLE 
   
  #130 = 1 ; VARIABLE FOR TOOL AT BIN 0 (ACTIVE TOOL BIN NUMBER) 
  #115 = 0 ; RESETTING TOOL # TO 0 
   
N5 
  if [#[17000+#130] == 0] then #115 = #130 
  if [#115 > 0] then goto 10 
  #130 = #130+1 
  if [#130 > 199] then #ERROR TOOL IN SPINDLE NOT FOUND 
  goto 5 
   
N10 ; CHECKING TOOL HEIGHT 
  m123 l1;  Tool in spindle is 
  m123 q0p#115 
  
  ;#110 = 0
  #[w] = #23503             ; set max distance to travel limit 
  ;m225 #110 "distance = %.2f, adjust = %.2f" #23503 #2700
  #[w] = #w - #2700   ;
                              ; 
  #111 = 50 
  if [#25001 == 21] then #111 = #111 * 25.4
  ;#29567 = #w
  ;m225 #110 "Moving Z to %9.4f" #29567
  ;#129 = #z 
  ;m225 #110 "TT1 Input Used = %f" #129
  M115/Z#w P[-#z] L1 F#111  ; Move down until probe contact (50 IPM) 
  M116/Z P[#z] F[#111/2]    ; Move up until probe clear     (25 IPM) 
  #111 = 0.025 
  if [#25001 == 21] then #111 = #111 * 25.4 
  G91 Z#111                 ; clearance move (0.025 in) 
  G90 
   
  #111 = 10 
  if [#25001 == 21] then #111 = #111 * 25.4 
  M115/Z#w P[-#z] L1 F#111  ; move down until probe contact (10 IPM) 
   
  ; record current Z machine position 
  if #50001 
  #29999 = 0   
  if [#[29000+#115] == 0] then #[29000+#115] = #5023 else #29999 = #5023 
  
  m123 l1;  Z height measured at 
  m123 l1 p#5023 
  if [#29999 == 0] then m123 ;-- INITIAL CHECK 
  if [#29999 != 0] then m123 ; 
  M116/Z P[#z] F10          ; move up until probe clear 
  G91 Z.100 F30             ; clearance move 
  G90 
   
  ; skip tolerance check if initial check 
  if [#29999 == 0] then goto 300  
  
  ; otherwise, compute absolute difference 
  ; between last recorded Z machine position 
  ; and the current recorded Z machine position 
  ; 
  #114 = abs[#29999 - #(29000 + #115)]    
  ; if position within tolerance, skip to the end 
  if [#114 <= #t] then goto 300 
   
n200 
  m123 ;*** FAILURE TOOL CHECK 
  m123 l1 ;Initial check was 
  m123 l1 p#[29000+]] 
  m123 l1 ;current check is 
  m123 l1 p#29999 
  m123 l1 ;error 
  m123 p#114 
  if [#112 == 1] then goto 300 
  #ERROR 
   
N300 
   
  m99 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Subroutine to check that TT-1 is worky properly. 
  ; 
  ; 
  o9202 
  m123 ; 
  m123 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  m123 ;;  Checking TT-1 operation and parameter settings 
  ; * Connect TT-1 and verify the XY location of the TT-1 
  ; * is set in return point #3. Verify that the spindle  
  ; * face is above the TT-1 when at the Z minus travel 
  ; * limit. After pressing CYCLE START, 
  ; * trigger the TT-1 twice. 
  m0 
  if [#9044 != 0] then #[z] = #9044 
  if [#9044 == 0] then #[z] = #9011 
  M123 L1 ;TT-1 set to be input 
  M123 q0 p#z 
  m101/#z 
  g4 p.1 
  m100/#z 
  g4 p.1 
  m101/#z 
  g4 p.1 
  m100/#z 
  g4 p.1 
  if #50001 
  M123 l1;TT-1 has been detected on input 
  m123 q0p#z 
  m0 ; Press CYCLE_START to continue          
  m99 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
  ; 
  ; Subroutine to perform tool changes 
  ; and make position checks 
  ; 
  o9301
  #100 = 0
  m225 #100 "Ensure TT1 is at G30P3 position for tool height testing"
  m123 ; 
  m123 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  m123 ;; Starting tool changes 
   
  #[x] = 1            ; starting tool number 
  #[y] = #9161 / 2    ; next tool number 
  if [#9161 % 2] then #[y] = #y - 0.5  ; adjust for odd number bins 
  #[i] = 0            ; tool change counter 
  #[n] = #9161 * 3    ; number of tool changes  
  #111 = 0.005        ; tolerance for TT-1 check 
  if [#25001 == 21] then #111 = #111 * 25.4 
   
n307 
  M123 L1 ;;Tool change to T 
  M123 q0p#x 
  t#x m6 
  if #50001 
  ; position measurement and check 
  g65 p9201 t#111 
   
  M123 L1 ;;Tool change to T 
  M123 q0p#y 
  t#y m6 
  if #50001 
  ; position measurement and check 
  g65 p9201 t#111 
   
  #[x] = #x + 1 
  #[y] = #y + 1 
  #[i] = #i + 2 
  if [#x > #9161] then #[x] = 1
  if [#y > #9161] then #[y] = 1 
  if [#i <  #n] then goto 307 
  m99 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; 
  ; Subroutine to check spindle speed accuracy and 
  ; various spindle related parameters. 
  ; 
  ; Commands speeds from 100 - max spindle speed 
  ; in steps of 100RPM and measures the actual speed 
  ; Assumes a data file has been opened for recording. 
  ; 
  o9203 
  m123 ; 
  M123 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  M123 ;;  Starting  Spindle Test 
  if [#9078 != 1] then m123 ;* WARNING - Setting P78 to 1.0 
  if [#9036 != 1] then m123 ;* WARNING - Setting P36 to 5.0 
  if [#9033 != 1] then m123 ;* WARNING - Settign P33 to 1.0 
  ; set p78 = 1 (to see actual measured spindle speed) 
  g10 p78 r1 
  ; set p36 = 5 (enable rigid tap, wait for index) 
  g10 p36 r1 
  ; set p33 = 1 (spindle motor gear ratio) 
  g10 p33 r1 
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Try to determine which axis spindle encoder 
  ; is connected to. 
  ; 
  ; Take initial reading of all abs encoder positions 
  ; 
  #[i] = 1 
  #29000 = #25010  ; spindle counts according to axis set by P35 
   
n3 
  #[29000+#i] = #[23800+#i] 
  #[i] = #i + 1 
  if [#i <= 6] then goto 3 
   
  ; 
  ; Command spindle at max speed (according to control config) 
  ; for a few seconds 
  ; 
  m109/2 
  m3 s#25006   
  g4 p3        
  m5 
  m108/2 
  g4 p5        
   
  ; 
  ; Determine which axis has moved at least 10000 encoder counts 
  ; 
  #[i] = 1 
  #[v] = 0 
n4 
  if [abs(#(29000+#i)-#(23800+#i)) > 10000] then #[v] = #i 
  #[i] = #i + 1 
  if [#i <= 6] then goto 4 
   
  if [#v != 0] then goto 5 
  m123 ;*** FAILURE SPINDLE ENCODER NOT DETECTED 
  #149 = 1  ; flag error 
  goto 20   ; exit routine 
   
  ; 
  ; Report the axis spindle encoder is connected to 
  ; and check machine parmeter 35 for correct setting. 
  ; 
n5 
  m123 l1;Spindle encoder detected on axis 
  m123 q0p#v 
  #148 = #v - 1 
  if [abs(#29000-#25010) > 10000] then goto 6 
  m123 ;*** FAILURE Machine parameter 35 is set wrong. 
  m123 l1;It should be 
  m123 l1q0p#148 
  m123 l1;or 
  #148 = #148 + 16 
  m123 l1q0p#148 
  m123 ;(if AC system connected to CPU card) 
  #149 = 1  ; flag error 
  goto 20 
   
n6 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Check P34 for correct sign 
  ; Command M3, if spindle axis counts up, P34 should be positive 
  ; 
  m109/2 
  if #50001 
  #148 = #25010 
  m3 s600 
  g4 p1 
  m5 
  m108/2 
  if #50001 
  #148 = #25010 - #148 
  if [#148 * #9034 < 0] then m123 ;* WARNING: P34 wrong sign, reversing sign 
  if [#148 * #9034 < 0] then g10 p34 r[-#9034] 
 
  #[i] = 1; 
  #[t] = 0; 
  m123 ;-- Determining spindle decel time at 2000RPM 
  m109/2 
n7 
  m3 s2000 
  g4 p3 
  #146 = #25012 
  #145 = #25010 
  m5  
  g4 p.1 
n8 
  if [#145 == #25010] goto 9 
  #145 = #25010 
  g4 p.1      
  goto 8 
   
n9 
  m123 l1;-- Spindle decel time measured at 
  #145 = #25012 - #146 
  #[t] = #t + #145 
  m123 l1q2 p#145 
  m123 ;seconds. 
  #[i] = #i + 1 
  if [#i <= 3] goto 7 
  #145 = #t / 3 
  m123 l1;-- Average decel time 
  m123 l1q2p#145 
  m123 ;seconds. 
   
  #[s] = 0.1 * #25006 ; Start at 10% of max 
  #[i] = 1 
  M123 ;Commanded   Measured   Error 
  M109/2 
n10 
  M123 r8q0L1 p#s 
  M3 s#s 
  g4 p3  ; allow three seconds to get up to speed 
  if #50001
  #100 = #25010 ; record starting spindle position
  #101 = #25012 ; record starting time in seconds
  g4 p4         ; run for a couple of seconds
  if #50001
  #102 = #25010 ; record ending spindle position
  #103 = #25012 ; record ending time in seconds
  ; compute RPMs 
  #118 = (60 * abs(#102 - #100)) / (abs(#9034) * abs(#103 - #101))
  #103 = 3
  #100 = #s
  m225 #103 "Commanded speed: %.1f RPM\nMeasured speed: %.1f RPM" #100 #118
  M123 r8q0l1p#118 
  #146 = #118 - #s 
  m123 r8q0l1p#146 
  #146 = 100*(abs(#118 - #s)/#s) 
  m123 l1 ;( 
  m123 r5q3l1 p#146 
  m123 ;%) 
  #[29000+#i] = #146 
  #[i] = #i + 1 
  #[s] = #25006 * #i/10 ; increment by 10% of max 
  if [#s <= #25006] goto 10 
n20 
  ;;;;;;;;;;;;;;;;;;;;;;; 
  ; Analyze data 
  s0 
  m5 
  m108/2 
  g4 p5 
  if #50001 
  #[i] = 1 
n23 
  if [(#[29000+#i] > 3.0)] then goto 30 
  #[i] = #i + 1 
  if [#i <= 10] then goto 23 
  m123 l1;Spindle speeds within 3% from 
  #146 = #25006/10 
  m123 l1q0p#146 
  m123 l1;RPM to Max 
  goto 40 
n30 
  m123 ;*** FAILURE SPINDLE SPEED VARIATION 
  #149 = 1 
  goto 40 
n40 
  m99 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Subroutine to do tapping test 
  ; 
  o9204 
  m123 ; 
  m123 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  m123 ;; Starting tapping test 
  m109/2 
  if [#20103 == 90] then g90 g53 z0 
  m3 s1000 
  g91 
  #111 = -3 
  if [#25001 == 21] then #111 = #111 * 25.4 
  #113 = 0.01 
  if [#25001 == 21] then #113 = 25.4 * #113 
  m123 l1;Tapping Z = 
  m123 l1p#111 
  m123 l1;q = 
  m123 p#113 
  g84 x0 z#111 q#113 r0 
  g80 
  g90 
  m108/2 
  m5 
  g4 p5 
  m123 ;Tapping test completed successfully. 
  m99 
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
   
   
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
   
   
   
  ;************************************************** 
  ;              MAIN PROGRAM    
  ;************************************************** 
   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; 
  ; skip test if graphing or searching 
  ; 
  if [#4201 || #4202] then goto 10001 
   
  #111 = #1233 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; 
  ; open file for data recording 
  ; 
  ;        MILL            WIN/LINUX 
  if [(#25014 == 1.0) && (#25017 == 2)] then M120 "c:\cncm\systest.out" 
  ;        LATHE           WIN/LINUX     
  if [(#25014 == 2.0) && (#25017 == 2)] then M120 "c:\cnct\systest.out" 
  
  m123 ;------------------------------------------- 
  M123 ;        Starting system test 
  m123 ;------------------------------------------- 
  m123 ; Version Information 
  m123 ; $Id: systest.cnc,v 1.1.1.1 2006/01/05 14:30:21 kdennison Exp $ 
  m123 ;;;;;;;;;;;;;;;;;;;;;;;; 
  #149 = 0 
  #112 = 0 
  #119 = 0 
  #129 = 0
  #130 = 0
  
  g10 p145 r1   ; enable fast branching 
  if [#20103 == 90] then g90 g53 z0
  
n5 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; ATC Check 
  ; 
  ; Check for ATC setup 
  ; System is identified as an ATC 
  ; system if p6 = 1.0 and p160 != 0 
  ; 
  ; If ATC system, do a TT-1 check at the start 
  ; 
  #100 = 0 ; no ATC 
  if [(#9006 == 1) && (#9160 != 0)] then #100 = 1 
  if [#9160 == 2 && #100] then M224 #129 "Running ATC test on Random Tool Changer will invalidate tool library! Continue?\n1 - Yes\n2 - No"
  if #129 then M123 ;Random Tool changer installed. User canceled System Test.
  if #129 then goto 9999 ;exit System Test.
  if [#100] then m123 ;System is configured as ATC 
  if [not #100] then m123 ;System is NOT configured for ATC 
  ;tell user what they should have ready before running system test
  ;if [#100] then m225 #119 "Please note that the height offset is being canceled.\nBefore running System Test you must ensure that:\n1 - The G28 position is set for the Tool change height.\n2 - The G30 position is set for TT1 locaiton.
  if [#100 && #12000 != 0] then m225 #100 "Tool Height compensation canceled."; show message for 1 second
  if [#100 && #12000 != 0] then g43 h0; turn off height compensation to prevent issues with travel
  
  ;check to see if DSP probing is on (p155=1) and tell user to turn it off.
  if [#100 && #9155 == 1] then #129 = 1
  if [#129 != 1] then goto 6
  m225 #130 "DSP Probing, Parameter 155, must be set to 0 for System Test."
  M123 ;DSP Probing, Parameter 155, must be set to 0 for System Test.
  goto 9999
n6
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; travel limit setting and machine home checks 
  G65 p9101 
  if [#149 && (#112 == 0)] then goto 9999 
  #111 = #1234 
  ; 
  ; skip inidividual tests if not ATC since 
  ; non-ATCs only do home switch checks 
  ; 
  if [#100 == 0] then goto 15 
   
  if #50001 
  ;input "Do you want to run all the tests? 1 = yes 0 = no" #118 
  M224 #118 "Do you want to run all the tests?\n1 = yes\n0 = no"
  if [#118] then goto 10 
n7 
  if #50001 
  ;input "Enter test to run: 1-Home Switch 2-Spindle 3-Tap 4-ATC" #118 
  M224 #118 "Enter test number to run:\n1-Home Switch\n2-Spindle\n3-Tap\n4-ATC"
  if [#118 < 0 || #118 > 4] then goto 7 
  #119 = 1 
  if [#118 == 1] then goto 20 
  if [#118 == 2] then goto 25 
  if [#118 == 3] then goto 30 
  if [#118 == 4] then goto 15 
   
n10   
   
n15 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Do TT-1 check if ATC 
  ; 
  if [#100] then g65 p9202 
  if [#119] then goto 40 
   
n20 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Initial home swith check 
  ; Check each switch once with errors 
  ; disabled.   
  ; 
  #113 = #112 
  #112 = 1 
  #140 = 1 
  G65 p9102 
  if #50001 
  #112 = #113 
  if [#149 && (#112 == 0)] then goto 9999 
  if [#119] then goto 35 
   
n25 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; Do Spindle check if ATC 
  ; 
  if [#100] then g65 p9203 
  if [#149 && (#112 == 0)] then goto 9999 
  if [#119] then goto 10001 
  
n30 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ;  Tapping Test 
  ; 
  if [#100] then g65 p9204 
  if [#119] then goto 10001 
  
n35 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ;  Extensive home switch checks 
  #140 = 10  ; Check each switch 10 times  
  g65 p9102 
  if [#149 && (#112 == 0)] then goto 9999 
  if [#119] then goto 10001 
  #111 = #1234 
   
n40 
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
  ; tool change checks 
  ; First, zero variables #29001 - #29199 
  ; which hold Z machine positions. 
  ; In this way, the first time a tool is measured 
  ; with the TT-1, the TT-1 check records a value instead 
  ; of checking tolerance against a previous recording 
  ; 
  if #50001 
  #[i] = 1 
n43 
  #[29000+#i] = 0 
  #[i] = #i + 1 
  if [#i <= 199] then goto 43 
  if [#100] then g65 p9301 
  if [#119] then goto 10001 
  goto 10000 
   
n9999 M123 ;*** FAILED SYSTEM TEST *** 
  ;*************************************************** 
  ;*   
  ;*  ERROR FAILED TEST 
  ;* 
  ;*  Search for "*** FAILURE" in systest.out file 
  ;*  to determine the nature of the failure. 
  ;* 
  ;*************************************************** 
n10000 M123 ;!!! PASSED SYSTEM TEST !!! 
  if [#20103 == 90] then g90 g53 z0   
  g10 p145 r0   ; disable fast branching 
  #111 = #1234 
n10001 
