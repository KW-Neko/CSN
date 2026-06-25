@echo off
cls
:TOP

rem ========================================================
rem                       ïœêîêÈåæïî
rem ========================================================


rem ÅöíxâÑä¬ã´ìWäJ
	setlocal EnableDelayedExpansion

rem ÅöÉäÅ[ÉãÇíËã`
	set Reel1[0]=[41;5mSEVEN [0m
	set Reel1[1]=[91mCHERRY[0m
	set Reel1[2]=[93mLEMON [0m
	set Reel1[3]=[91mCHERRY[0m
	set Reel1[4]=[5mBAR   [0m
	set Reel1[5]=[93mLEMON [0m
	set Reel1[6]=[43mBELL  [0m
	set Reel1[7]=[91mCHERRY[0m
	set Reel1[8]=[33mORANGE[0m
	set Reel1[9]=[93mLEMON [0m
	set Reel1[10]=[5mBAR   [0m
	set Reel1[11]=[91mCHERRY[0m
	set Reel1[12]=[33mORANGE[0m
	set Reel1[13]=[43mBELL  [0m
	set Reel1[14]=[93mLEMON [0m
	set Reel1[15]=[91mCHERRY[0m
	set Reel1[16]=[33mORANGE[0m
	set Reel1[17]=[43mBELL  [0m
	set Reel1[18]=[33mORANGE[0m
	set Reel1[19]=[93mLEMON [0m

	set Reel2[0]=[91mCHERRY[0m
	set Reel2[1]=[93mLEMON [0m
	set Reel2[2]=[91mCHERRY[0m
	set Reel2[3]=[5mBAR   [0m
	set Reel2[4]=[93mLEMON [0m
	set Reel2[5]=[43mBELL  [0m
	set Reel2[6]=[91mCHERRY[0m
	set Reel2[7]=[33mORANGE[0m
	set Reel2[8]=[93mLEMON [0m
	set Reel2[9]=[5mBAR   [0m
	set Reel2[10]=[91mCHERRY[0m
	set Reel2[11]=[41;5mSEVEN [0m
	set Reel2[12]=[33mORANGE[0m
	set Reel2[13]=[43mBELL  [0m
	set Reel2[14]=[93mLEMON [0m
	set Reel2[15]=[91mCHERRY[0m
	set Reel2[16]=[33mORANGE[0m
	set Reel2[17]=[43mBELL  [0m
	set Reel2[18]=[33mORANGE[0m
	set Reel2[19]=[93mLEMON [0m

	set Reel3[0]=[91mCHERRY[0m
	set Reel3[1]=[93mLEMON [0m
	set Reel3[2]=[91mCHERRY[0m
	set Reel3[3]=[5mBAR   [0m
	set Reel3[4]=[93mLEMON [0m
	set Reel3[5]=[43mBELL  [0m
	set Reel3[6]=[91mCHERRY[0m
	set Reel3[7]=[33mORANGE[0m
	set Reel3[8]=[93mLEMON [0m
	set Reel3[9]=[5mBAR   [0m
	set Reel3[10]=[91mCHERRY[0m
	set Reel3[11]=[33mORANGE[0m
	set Reel3[12]=[43mBELL  [0m
	set Reel3[13]=[93mLEMON [0m
	set Reel3[14]=[91mCHERRY[0m
	set Reel3[15]=[33mORANGE[0m
	set Reel3[16]=[43mBELL  [0m
	set Reel3[17]=[33mORANGE[0m
	set Reel3[18]=[41;5mSEVEN [0m
	set Reel3[19]=[93mLEMON [0m

rem ÅöécÇËÇÃÉvÉåÉCâÒêî
	set TryCount=0

rem ÅöëçälìæÉ|ÉCÉìÉg
	set TotalPoint=0
	set TpString=000000000000000000

rem ÅöÉ|ÉCÉìÉg-âÒêîä∑éZóp
	set TmpPoint=0

rem ÅöëçÉvÉåÉCâÒêî
	set TriedCount=0



rem ========================================================
rem                         èàóùïî
rem ========================================================

	call :TITLE_CALL

rem Åöìäì¸Ç∑ÇÈÇ®ã‡Çì¸óÕ
	set /p EnterCoin="Enter a coin : (10/50/100/500) : "
	if not "%EnterCoin%"=="10" (
		if not "%EnterCoin%"=="50" (
			if not "%EnterCoin%"=="100" (
				if not "%EnterCoin%"=="500" (
					echo Invalid value. Please enter 10 or 50 or 100 or 500.
					timeout /t 2 >nul
					cls
					goto :TOP
				)
			)
		)
	)

rem ÅöécçÇåvéZ
	set /a Balance-=%EnterCoin%

rem Åöìäì¸ÇµÇΩã‡äzÇ…âûÇ∂ÇƒÉvÉåÉCâÒêîÇê›íË
	set /a TryCount=%EnterCoin% / 10

:SLOTON

cls
call :TITLE_CALL
call :POINT_CALL

pause
set /a TriedCount+=1
timeout /t 1 >nul
cls


if !TryCount! leq 0 goto :CHECK_RESULT
	set TotalGain=0
	set Gain1=0
	set Gain2=0
	set Gain3=0
	set Gain4=0
	set Gain5=0
	set /a TryCount-=1

	call :TITLE_CALL
	call :POINT_CALL
	timeout /t 2 >nul

	set /a SLOT2=!RANDOM! %% 20
	set /a SLOT5=!RANDOM! %% 20
	set /a SLOT8=!RANDOM! %% 20
	if !SLOT2! equ 0 (
		set /a SLOT1=19
		set /a SLOT3=!SLOT2! + 1
	) else if !SLOT2! equ 19 (
		set /a SLOT1=!SLOT2! - 1
		set /a SLOT3=0
	) else (
		set /a SLOT1=!SLOT2! - 1
		set /a SLOT3=!SLOT2! + 1
	)
	
	if !SLOT5! equ 0 (
		set /a SLOT4=19
		set /a SLOT6=!SLOT5! + 1
	) else if !SLOT5! equ 19 (
		set /a SLOT4=!SLOT5! - 1
		set /a SLOT6=0
	) else (
		set /a SLOT4=!SLOT5! - 1
		set /a SLOT6=!SLOT5! + 1
	)
	
	if !SLOT8! equ 0 (
		set /a SLOT7=19
		set /a SLOT9=!SLOT8! + 1
	) else if !SLOT8! equ 19 (
		set /a SLOT7=!SLOT8! - 1
		set /a SLOT9=0
	) else (
		set /a SLOT7=!SLOT8! - 1
		set /a SLOT9=!SLOT8! + 1
	)
	

rem ÅöÉeÉXÉgóp
rem set SLOT1=19
rem set SLOT2=0
rem set SLOT3=1
rem set SLOT4=12
rem set SLOT5=1
rem set SLOT6=10
rem set SLOT7=17
rem set SLOT8=18
rem set SLOT9=19


	echo ==================================
	echo ====   !TpString:~-18,6! !TpString:~-12,6! !TpString:~-6,6!   ====
	echo ==================================
	echo ==                              ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT1%]!                   ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT2%]!                   ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT3%]!                   ==
	echo ==                              ==
	echo ==                              ==
	echo ==================================
	echo ====   OOOOOO OOOOOO OOOOOO   ====
	echo ==================================
	timeout /t 1 >nul
	cls
	call :TITLE_CALL
	call :POINT_CALL
		echo ==================================
	echo ====   !TpString:~-18,6! !TpString:~-12,6! !TpString:~-6,6!   ====
	echo ==================================
	echo ==                              ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT1%]! !Reel2[%SLOT6%]!            ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT2%]! !Reel2[%SLOT5%]!            ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT3%]! !Reel2[%SLOT4%]!            ==
	echo ==                              ==
	echo ==                              ==
	echo ==================================
	echo ====   OOOOOO OOOOOO OOOOOO   ====
	echo ==================================
	timeout /t 1 >nul
	cls

	call :TITLE_CALL
	call :POINT_CALL
	echo ==================================
	echo ====   !TpString:~-18,6! !TpString:~-12,6! !TpString:~-6,6!   ====
	echo ==================================
	echo ==                              ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT1%]! !Reel2[%SLOT6%]! !Reel3[%SLOT7%]!     ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT2%]! !Reel2[%SLOT5%]! !Reel3[%SLOT8%]!     ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT3%]! !Reel2[%SLOT4%]! !Reel3[%SLOT9%]!     ==
	echo ==                              ==
	echo ==                              ==
	echo ==================================
	echo ====   OOOOOO OOOOOO OOOOOO   ====
	echo ==================================
	echo+
	echo+
	timeout /t 2 >nul
	
rem ÅöíÜíi
	if "!Reel1[%SLOT2%]!"=="!Reel2[%SLOT5%]!" (
		if "!Reel1[%SLOT2%]!"=="!Reel3[%SLOT8%]!" (
			
		rem ÅöBINGO
			if "!Reel1[%SLOT2%]!"=="[91mCHERRY[0m" (
				set /a Gain1+=5
			) else if "!Reel1[%SLOT2%]!"=="[93mLEMON [0m" (
				set /a Gain1+=10
			) else if "!Reel1[%SLOT2%]!"=="[33mORANGE[0m" (
				set /a Gain1+=20
			) else if "!Reel1[%SLOT2%]!"=="[43mBELL  [0m" (
				set /a Gain1+=40
			) else if "!Reel1[%SLOT2%]!"=="[5mBAR   [0m" (
				set /a Gain1+=100
			) else if "!Reel1[%SLOT2%]!"=="[41;5mSEVEN [0m" (
				set /a Gain1+=777
			)
		)
	)

rem Åöè„íi
	if "!Reel1[%SLOT1%]!"=="!Reel2[%SLOT6%]!" (
		if "!Reel1[%SLOT1%]!"=="!Reel3[%SLOT7%]!" (
		
		rem ÅöBINGO
			if "!Reel1[%SLOT1%]!"=="[91mCHERRY[0m" (
				set /a Gain2+=4
			) else if "!Reel1[%SLOT1%]!"=="[93mLEMON [0m" (
				set /a Gain2+=8
			) else if "!Reel1[%SLOT1%]!"=="[33mORANGE[0m" (
				set /a Gain2+=16
			) else if "!Reel1[%SLOT1%]!"=="[43mBELL  [0m" (
				set /a Gain2+=32
			) else if "!Reel1[%SLOT1%]!"=="[5mBAR   [0m" (
				set /a Gain2+=80
			) else if "!Reel1[%SLOT1%]!"=="[41;5mSEVEN [0m" (
				set /a Gain2+=300
			)
		)
	)

rem Åöâ∫íi
	if "!Reel1[%SLOT3%]!"=="!Reel2[%SLOT4%]!" (
		if "!Reel1[%SLOT3%]!"=="!Reel3[%SLOT9%]!" (
		
		rem ÅöBINGO
			if "!Reel1[%SLOT3%]!"=="[91mCHERRY[0m" (
				set /a Gain3+=4
			) else if "!Reel1[%SLOT3%]!"=="[93mLEMON [0m" (
				set /a Gain3+=8
			) else if "!Reel1[%SLOT3%]!"=="[33mORANGE[0m" (
				set /a Gain3+=16
			) else if "!Reel1[%SLOT3%]!"=="[43mBELL  [0m" (
				set /a Gain3+=32
			) else if "!Reel1[%SLOT3%]!"=="[5mBAR   [0m" (
				set /a Gain3+=80
			) else if "!Reel1[%SLOT3%]!"=="[41;5mSEVEN [0m" (
				set /a Gain3+=300
			)
		)
	)

rem ÅöéŒÇﬂ(â∫ÇË)
	if "!Reel1[%SLOT1%]!"=="!Reel2[%SLOT5%]!" (
		if "!Reel1[%SLOT1%]!"=="!Reel3[%SLOT9%]!" (
		
		rem ÅöBINGO
			if "!Reel1[%SLOT1%]!"=="[91mCHERRY[0m" (
				set /a Gain4+=4
			) else if "!Reel1[%SLOT1%]!"=="[93mLEMON [0m" (
				set /a Gain4+=8
			) else if "!Reel1[%SLOT1%]!"=="[33mORANGE[0m" (
				set /a Gain4+=16
			) else if "!Reel1[%SLOT1%]!"=="[43mBELL  [0m" (
				set /a Gain4+=32
			) else if "!Reel1[%SLOT1%]!"=="[5mBAR   [0m" (
				set /a Gain4+=80
			) else if "!Reel1[%SLOT1%]!"=="[41;5mSEVEN [0m" (
				set /a Gain4+=300
			)
		)
	)

rem ÅöéŒÇﬂ(è„ÇË)
	if "!Reel1[%SLOT3%]!"=="!Reel2[%SLOT5%]!" (
		if "!Reel1[%SLOT3%]!"=="!Reel3[%SLOT7%]!" (
		
		rem ÅöBINGO
			if "!Reel1[%SLOT3%]!"=="[91mCHERRY[0m" (
				set /a Gain5+=4
			) else if "!Reel1[%SLOT3%]!"=="[93mLEMON [0m" (
				set /a Gain5+=8
			) else if "!Reel1[%SLOT3%]!"=="[33mORANGE[0m" (
				set /a Gain5+=16
			) else if "!Reel1[%SLOT3%]!"=="[43mBELL  [0m" (
				set /a Gain5+=32
			) else if "!Reel1[%SLOT3%]!"=="[5mBAR   [0m" (
				set /a Gain5+=80
			) else if "!Reel1[%SLOT3	%]!"=="[41;5mSEVEN [0m" (
				set /a Gain5+=300
			)
		)
	)



set /a TotalGain=!Gain1! + !Gain2! + !Gain3! + !Gain4! + !Gain5!



rem ó›åvÉ|ÉCÉìÉg
set /a TotalPoint+=!TotalGain!
set TpString=000000000000000000!TotalPoint!


rem ïœä∑ë“ÇøÉ|ÉCÉìÉg
set /a TmpPoint+=!TotalGain!

echo        Åö Åö Åö Results Åö Åö Åö
echo ========================================
echo ÅEMiddle Row    is !Gain1!
echo ÅETop Row       is !Gain2!
echo ÅEBottom Row    is !Gain3!
echo ÅEDiagonal Up   is !Gain4!
echo ÅEDiagonal Down is !Gain5!
echo ---------------------------------------
echo Get Coin is !TotalGain!
echo ---------------------------------------
echo Total Points : !TotalPoint!
echo Points Bank  : !TmpPoint!
echo Spins Left   : !TryCount!
echo ========================================
echo+
echo+

:CONTINUE_LOOP

set Continue=
set /p Continue="Continue? (y/n) : "
if "%Continue%"=="y" (
	set /a AddPlay=!TmpPoint! / 10
	set /a TryCount+=!AddPlay!
	set /a TmpPoint-=!AddPlay! * 10
	goto :SLOTON

) else if "%Continue%"=="Y" (
	set /a AddPlay=!TmpPoint! / 10
	set /a TryCount+=!AddPlay!
	set /a TmpPoint-=!AddPlay! * 10
	goto :SLOTON

) else if "%Continue%"=="n" (
	goto :CHECK_RESULT

) else if "%Continue%"=="N" (
	goto :CHECK_RESULT

) else (
	call :CONTINUE_CALL
	goto :CONTINUE_LOOP
)


:CHECK_RESULT
echo====================================

cls
call :TITLE_CALL
echo+
echo ------- PLAY RECORD -------
echo+
echo Total Points : !TotalPoint!
echo Play Counts  : !TriedCount!
echo+
echo ---------------------------
echo+

set /a Balance+=(!TryCount!*10)+!TmpPoint!
echo BALANCE=!Balance! > .\save\!CallData!
pause

exit /b

:TITLE_CALL
	echo =====================================
	echo           Åö SLOT GAME Åö
	echo =====================================
	echo ------------------------------
	echo Balance : !Balance!
	echo ------------------------------
	exit /b

:POINT_CALL
	echo ===============================
	echo Total Points : !TotalPoint!
	echo Points Bank  : !TmpPoint!
	echo Spins Left   : !TryCount!
	echo ===============================
	echo+
	echo+

	exit /b

:CONTINUE_CALL
	cls
	call :TITLE_CALL
	call :POINT_CALL
	echo ==================================
	echo ====   !TpString:~-18,6! !TpString:~-12,6! !TpString:~-6,6!   ====
	echo ==================================
	echo ==                              ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT1%]! !Reel2[%SLOT6%]! !Reel3[%SLOT7%]!     ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT2%]! !Reel2[%SLOT5%]! !Reel3[%SLOT8%]!     ==
	echo ==                              ==
	echo ==     !Reel1[%SLOT3%]! !Reel2[%SLOT4%]! !Reel3[%SLOT9%]!     ==
	echo ==                              ==
	echo ==                              ==
	echo ==================================
	echo ====   OOOOOO OOOOOO OOOOOO   ====
	echo ==================================
	echo+
	echo+
	
	echo        Åö Åö Åö Results Åö Åö Åö
	echo ========================================
	echo ÅEMiddle Row    is !Gain1!
	echo ÅETop Row       is !Gain2!
	echo ÅEBottom Row    is !Gain3!
	echo ÅEDiagonal Down is !Gain4!
	echo ÅEDiagonal Up   is !Gain5!
	echo ---------------------------------------
	echo Get Coin is !TotalGain!
	echo ---------------------------------------
	echo Total Points : !TotalPoint!
	echo Points Bank  : !TmpPoint!
	echo Spins Left   : !TryCount!
	echo ========================================
	echo+
	echo+
	
	exit /b