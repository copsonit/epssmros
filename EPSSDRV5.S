	OUTPUT	E:\CBASE300.SCC\MROS\EPSS.DRV
	opt	d-
*RS232

 TEXT 
Begin:
  JMP       L0001 
  DC.B      'MROS EPSS Export V 1.0 0193 (c)1993 Copson DATA/Unit Seventeen',$00 
	even
L0001:
  MOVEA.L   A7,A5 
  MOVEA.L   4(A5),A5
  MOVE.L    12(A5),D0 
  ADD.L     20(A5),D0 
  ADD.L     28(A5),D0 
  ADD.L     #$100,D0
	clr	-(A7)
  MOVE.L    D0,-(sp)
  BSR       L0002 
  MOVE.W    #$31,-(A7) 	;PTERMRES 
  TRAP      #1
L0002:
  BSR       L0005 
  BSR       L0003 
  BSR       L0007 
  PEA       L001B(PC) 
  MOVE.W    #$14,-(A7)
  TRAP      #$A 
  ADDQ.L    #6,A7 
  LEA       L001C(PC),A5
  RTS 
L0003:
  LEA       L001B(PC),A0
  MOVEA.L   A0,A1 
  MOVEQ     #$37,D0 
L0004:
  CLR.B     (A1)+ 
  DBF       D0,L0004
  MOVE.W    #$100,54(A0)
  LEA       L0018(PC),A1
  MOVE.L    A1,(A0) 
  ST        6(A0) 
  MOVE.W    #1,34(A0) 		* Antal entrys
  LEA       L000A(PC),A1
  MOVE.L    A1,36(A0) 
  LEA       L000B(PC),A1
  MOVE.L    A1,40(A0) 
  RTS 
L0005:
  LEA       L001C(PC),A5
  MOVEA.L   A5,A0 
  MOVE.W    #$1F,D0 
L0006:
  CLR.B     (A0)+ 
  DBF       D0,L0006
  MOVE.W    #4,-(A7)
  TRAP      #8
  LEA       2(A7),A7
  MOVEA.L   D0,A0 
  LEA       L001C(PC),A5
  MOVE.L    4(A0),16(A5)
  MOVE.L    8(A0),12(A5)
  MOVE.L    16(A0),24(A5) 
  MOVE.L    32(A0),28(A5) 
  RTS 
L0007:
*  MOVEM.L   A5/A2,-(A7) 
*  LEA       L001C(PC),A5
	move.l	a2,-(sp)
  LEA       L0018(PC),A1
  MOVE.W    #$8F,D0 
L0008:
  CLR.L     (A1)+ 
  DBF       D0,L0008
  LEA       L0018(PC),A0
  LEA       L0017(PC),A1
  LEA       L000C(PC),A2
  MOVE.L    A1,36(A0) 
  LEA       512(A1),A1
  MOVE.L    A1,40(A0) 
  MOVE.L    A2,144(A0)
*  MOVEM.L   (A7)+,A5/A2 
	move.l	(sp)+,a2
  RTS 
L000A:
  MOVE.L    A5,-(A7)
  LEA       L001C(PC),A5
  BSR       L0005 
  LEA       L001B(PC),A0
  ST        28(A0)
  MOVEQ     #0,D0 
  MOVEA.L   (A7)+,A5
  RTS 
L000B:
  MOVE.L    A5,-(A7)
  LEA       L001C(PC),A5
  LEA       L001B(PC),A0
  CLR.W     28(A0)
  MOVEA.L   (A7)+,A5
  MOVEQ     #0,D0 
  RTS 
L000C:
  MOVE.W    58(A0),D0 	Output?
  AND.W     #3,D0 
  LEA       L001C(PC),A1
  MOVE.B    (A1),D1 
  BSET      D0,(A1) 	S„tt bit
  TST.B     D1
  Bne.S     .klar3

  MOVE.L    A5,-(A7)
  LEA       L001C(PC),A5
  TST.B     (A5)	Ska vi spela n†t?
  BEQ       .klar
  MOVEM.L   A0-A2/D0-D2,-(A7) 
.igen
  MOVEA.L   24(A5),A2 
  BTST      #0,(A5) 	Utg†ng 1...
  BEQ.S     .klar2
  LEA       L0018(PC),A0
  JSR       (A2)	H„mta...
	trap	#7	spela p† EPSS
  TST.W     D1
  BEQ.S     .igen
  BCLR      #0,(A5) 
.klar2
  MOVEM.L   (A7)+,A0-A2/D0-D2 
.klar
	move.l	(sp)+,a5
.klar3
	rts

L0016:
  DCB.W     2,0 
L0017:
  DCB.W     768,0 
L0018:
  DCB.W     96,0
L0019:
  DCB.W     96,0
L001A:
  DCB.W     96,0
L001B:
  DCB.W     28,0
  DC.B      'EPSS ',$00,$00,$00
L001C:
  DCB.W     16,0
 BSS
  DS.B      4096
ZUEND: END
