@echo off

cls
rem set Balance=1000
:TOP

rem ========================================================
rem                       •Ï”éŒ¾•”
rem ========================================================

	rem š’x‰„ŠÂ‹«“WŠJ
		setlocal EnableDelayedExpansion
		
	rem šƒxƒbƒgŽí•Ê
		set BetName[1]=Pass Line   ^(Make Point^)
		set BetName[2]=Place       ^(Beat 7^)
		set BetName[3]=Field       ^(One Roll^)
		set BetName[4]=Proposition ^(Special Bets^)
		set BetName[5]=Hard Way    ^(Exact Pair^)

	rem šƒxƒbƒgˆÊ’u
		set BetName[1][1]=Pass Line
		set BetName[1][2]=Don^'t Pass
		rem ^'šsakura—p
		
		set BetName[2][1]=Place 4
		set BetName[2][2]=Place 5
		set BetName[2][3]=Place 6
		set BetName[2][4]=Place 8
		set BetName[2][5]=Place 9
		set BetName[2][6]=Place 10
		
		set BetName[3][1]=Field
		
		set BetName[4][1]=Any Seven
		set BetName[4][2]=Any Craps
		set BetName[4][3]=Yo
		set BetName[4][4]=Craps 2
		set BetName[4][5]=Craps 3
		set BetName[4][6]=Craps 12
		
		set BetName[5][1]=Hard 4
		set BetName[5][2]=Hard 6
		set BetName[5][3]=Hard 8
		set BetName[5][4]=Hard 10


	rem š“–‚½‚è”»’è
		set WinNumber[1][1]= 7 11 
		set WinNumber[1][2]= 2 3 
		set LoseNumber[1][1]= 2 3 12 
		set LoseNumber[1][2]= 7 11 
		set DrawNumber[1][2]= 12 
		set WinNumber[2][1]= 4 
		set WinNumber[2][2]= 5 
		set WinNumber[2][3]= 6 
		set WinNumber[2][4]= 8 
		set WinNumber[2][5]= 9 
		set WinNumber[2][6]= 10 
		set WinNumber[3][1]= 2 3 4 9 10 11 12 
		set WinNumber[4][1]= 7 
		set WinNumber[4][2]= 2 3 12 
		set WinNumber[4][3]= 11 
		set WinNumber[4][4]= 2 
		set WinNumber[4][5]= 3 
		set WinNumber[4][6]= 12 
		set WinNumber[5][1]= 4 ^(only 2,2^)
		set WinNumber[5][2]= 6 ^(only 3,3^)
		set WinNumber[5][3]= 8 ^(only 4,4^)
		set WinNumber[5][4]= 10 ^(only 5,5^)
		set LoseNumber[5][1]= 7 4 ^(not 2,2^)
		set LoseNumber[5][2]= 7 6 ^(not 3,3^)
		set LoseNumber[5][3]= 7 8 ^(not 4,4^)
		set LoseNumber[5][4]= 7 10 ^(not 5,5^)

	rem š•¥‚¢–ß‚µ”{—¦
		set ReturnMultiplier[1][1]=x  2.0
		set ReturnMultiplier[1][2]=x  2.0
		set ReturnMultiplier[2][1]=x  2.8
		set ReturnMultiplier[2][2]=x  2.4
		set ReturnMultiplier[2][3]=x  2.2
		set ReturnMultiplier[2][4]=x  2.2
		set ReturnMultiplier[2][5]=x  2.4
		set ReturnMultiplier[2][6]=x  2.8
		set ReturnMultiplier[3][1]=x  2.0
		set ReturnMultiplier[4][1]=x  5.0
		set ReturnMultiplier[4][2]=x  8.0
		set ReturnMultiplier[4][3]=x 16.0
		set ReturnMultiplier[4][4]=x 31.0
		set ReturnMultiplier[4][5]=x 16.0
		set ReturnMultiplier[4][6]=x 31.0
		set ReturnMultiplier[5][1]=x  8.0
		set ReturnMultiplier[5][2]=x 10.0
		set ReturnMultiplier[5][3]=x 10.0
		set ReturnMultiplier[5][4]=x  8.0

	rem šPoint‚Ì‰Šú’l(ƒtƒ‰ƒO)
		set Point=0

	rem šŠ|‚¯‹à
		set BetAmount=100
	
	rem šƒQ[ƒ€ŠJŽn‘OŽc‚‚ð‹L˜^
		set PreBalance=!Balance!
		
	rem šƒTƒCƒRƒ‚ðU‚Á‚½‰ñ”
		set ThrowCount=0
		
rem ========================================================
rem                         ˆ—•”
rem ========================================================

rem ********************** ƒtƒF[ƒY1 **********************
rem                       ƒxƒbƒg‘I‘ð
rem *******************************************************

	rem šƒ^ƒCƒgƒ‹ƒR[ƒ‹
		call :TITLE_CALL
		set /a Balance-=!BetAmount!
		rem timeout -t 2 >nul

	rem š“ü—Í’l‚ª•s³‚Ìê‡‚Éƒ‹[ƒv
	:SELECT_LOOP
		set BetStyle=99999
		set BetPlace=99999
		cls
		call :TITLE_CALL

	rem šƒxƒbƒgŽí•Ê‘I‘ð
		echo Place Your Bet...
		echo Choose Bet Style
		echo+
		
		for /l %%i in (1,1,5) do (
			echo %%i. !BetName[%%i]!
		)
		set /p BetStyle=""

		echo+
		echo =========================
	
		rem šPass Line‚Ìê‡
			if !BetStyle! equ 1 (
				echo Pass Line
				echo+
				for /l %%i in (1,1,2) do (
					echo %%i. !BetName[1][%%i]!
				)
			
		rem šPlase Bet‚Ìê‡
			) else if !BetStyle! equ 2 (
				echo Place Bet
				echo+
				for /l %%i in (1,1,6) do (
					echo %%i. !BetName[2][%%i]!
				)
				
		rem šField Bet‚Ìê‡
			) else if !BetStyle! equ 3 (

			rem šField‚Í‘I‘ðŽˆ‚P‚Â‚Ì‚Ý
				echo Field Bet
				set BetPlace=1

		rem šProposition Bet‚Ìê‡
			) else if !BetStyle! equ 4 (
				echo Proposition Bet
				echo+
				for /l %%i in (1,1,6) do (
					echo %%i. !BetName[4][%%i]!
				)
		
		rem š Hard Way‚Ìê‡
			) else if !BetStyle! equ 5 (
				echo Hard Way
				echo+
				for /l %%i in (1,1,4) do (
					echo %%i. !BetName[5][%%i]!
				)
		
		rem š‚»‚Ì‘¼‚Ì’l‚ª“ü—Í‚³‚ê‚½ê‡
			) else (
				call :INVALID_CALL
			)
			
			if not !BetStyle! equ 3 (
				set /p BetPlace=""
			)
	
rem ********************** ƒtƒF[ƒY2 **********************
rem                       ƒxƒbƒgŠm”F
rem *******************************************************
set CheckBet=
:BET_CHECK
	rem šŠm”F
		cls
		call :TITLE_CALL

		rem šPass Line‚Ìê‡
			if !BetStyle! equ 1 (
			
			rem š³í‚È’l‚Ìê‡AŸ—˜ðŒ‚È‚Ç‚ð•\Ž¦
				if !BetPlace! geq 1 (
					if !BetPlace! leq 2 (
						call echo Your Bet   : %%BetName[1][!BetPlace!]%%
						call echo Multiplier : %%ReturnMultiplier[1][!BetPlace!]%%
						echo+
						call echo Win        :%%WinNumber[1][!BetPlace!]%%
						call echo Lose       :%%LoseNumber[1][!BetPlace!]%%
						if !BetPlace! equ 2 (
							call echo Push       :%%DrawNumber[1][!BetPlace!]%%
						)
						echo Point      : others.
						echo+
				
				rem š•s³‚È’l‚Ìê‡
					) else (
						call :INVALID_CALL
					)

			rem š•s³‚È’l‚Ìê‡
				) else (
					call :INVALID_CALL
				)
			
		rem šPlace Bet‚Ìê‡
			) else if !BetStyle! equ 2 (
			
			rem š³í‚È’l‚Ìê‡AŸ—˜ðŒ‚È‚Ç‚ð•\Ž¦
				if !BetPlace! geq 1 (
					if !BetPlace! leq 6 (
						call echo Your Bet   : %%BetName[2][!BetPlace!]%%
						call echo Multiplier : %%ReturnMultiplier[2][!BetPlace!]%%
						echo+
						call echo Win        :%%WinNumber[2][!BetPlace!]%%
						echo Lose       : 7
						echo Continue   : others.
						echo+
						
				rem š•s³‚È’l‚Ìê‡
					) else (
						call :INVALID_CALL
					)
					
			rem š•s³‚È’l‚Ìê‡
				) else (
					call :INVALID_CALL
				)
		
		rem šField‚Ìê‡
			) else if !BetStyle! equ 3 (
			
			rem šŸ—˜ðŒ‚È‚Ç‚ð•\Ž¦
				call echo Your Bet   : %%BetName[3][!BetPlace!]%%
				call echo Multiplier : %%ReturnMultiplier[3][!BetPlace!]%%
				echo+
				call echo Win        :%%WinNumber[3][!BetPlace!]%%
				echo Lose       : others.
				echo+

		rem šPropsition Bet‚Ìê‡
			) else if !BetStyle! equ 4 (
			
			rem š³í‚È’l‚Ìê‡AŸ—˜ðŒ‚È‚Ç‚ð•\Ž¦
				if !BetPlace! geq 1 (
					if !BetPlace! leq 6 (
						call echo Your Bet   : %%BetName[4][!BetPlace!]%%
						call echo Multiplier : %%ReturnMultiplier[4][!BetPlace!]%%
						echo+
						call echo Win        :%%WinNumber[4][!BetPlace!]%%
						echo Lose       : others.
						echo+
						
				rem š•s³‚È’l‚Ìê‡
					) else (
						call :INVALID_CALL
					)
					
			rem š•s³‚È’l‚Ìê‡
				) else (
					call :INVALID_CALL
				)
			
		rem šHard Way‚Ìê‡
			) else if !BetStyle! equ 5 (
			
			rem š³í‚È’l‚Ìê‡AŸ—˜ðŒ‚È‚Ç‚ð•\Ž¦
				if !BetPlace! geq 1 (
					if !BetPlace! leq 4 (
						call echo Your Bet   : %%BetName[5][!BetPlace!]%%
						call echo Multiplier : %%ReturnMultiplier[5][!BetPlace!]%%
						echo+
						call echo Win        :%%WinNumber[5][!BetPlace!]%%
						call echo Lose       :%%LoseNumber[5][!BetPlace!]%%
						echo Continue   : others.
						echo+
						
				rem š•s³‚È’l‚Ìê‡
					) else (
						call :INVALID_CALL
					)
					
			rem š•s³‚È’l‚Ìê‡
				) else (
					call :INVALID_CALL
				)
			)
			echo ------------------------------------

	rem š‘I‘ðBet‚ÌŠm”F
		if "!CheckBet!"=="" (
			set /p CheckBet="Confirm this bet? (y/n) : "
			if "!CheckBet!"=="y" (
				goto :BET_CHECK
			) else if "!CheckBet!"=="Y" (
				goto :BET_CHECK
			) else if "!CheckBet!"=="n" (
				goto :SELECT_LOOP
			) else if "!CheckBet!"=="N" (
				goto :SELECT_LOOP
			) else (
				set CheckBet=
				goto :BET_CHECK
			)
		) else (
			set /a ThrowCount+=1
			echo Current Roll : !ThrowCount!
		)

rem ********************** ƒtƒF[ƒY3 **********************
rem                    ƒ_ƒCƒXƒXƒ[
rem *******************************************************
:THROW_DICE

	rem šƒTƒCƒRƒ1‚Â–Ú
	
		rem š1~6‚Ì”Ô†‚ðŠi”[‚µ‚½”z—ñ‚ð’è‹`
			for /l %%i in (1,1,6) do (
			    set IDX1[%%i]=%%i
			)

		rem š’è‹`‚µ‚½”z—ñ‚ðƒVƒƒƒbƒtƒ‹‚µ‚ÄÄ’è‹`:Fisher-Yates Shuffle
			for /l %%i in (6,-1,2) do (
			    set /a limit=%%i
			set /a R=%RANDOM% %% limit + 1

		    call set A=%%IDX1[%%i]%%
		    call set B=%%IDX1[!R!]%%

		    set IDX1[%%i]=!B!
		    set IDX1[!R!]=!A!
			)
	
	rem šƒTƒCƒRƒ2‚Â–Ú
		rem š1~6‚Ì”Ô†‚ðŠi”[‚µ‚½”z—ñ‚ð’è‹`
			for /l %%i in (1,1,6) do (
			    set IDX2[%%i]=%%i
			)

		rem š’è‹`‚µ‚½”z—ñ‚ðƒVƒƒƒbƒtƒ‹‚µ‚ÄÄ’è‹`:Fisher-Yates Shuffle
			for /l %%i in (6,-1,2) do (
			    set /a limit=%%i
			set /a R=%RANDOM% %% limit + 1

		    call set A=%%IDX2[%%i]%%
		    call set B=%%IDX2[!R!]%%

		    set IDX2[%%i]=!B!
		    set IDX2[!R!]=!A!
			)

	rem šƒeƒXƒg—p
	set IDX1[1]=1
	set IDX2[1]=1


rem ********************** ƒtƒF[ƒY4 **********************
rem                       Œ‹‰ÊŠm”F
rem *******************************************************

	rem šo–Ú‚Ì•\Ž¦‚ð’è‹`
		for /l %%i in (1,1,2) do (
		
		rem šo–Ú‚Ì‰Šú’l
			set DICE[%%i][1]=„¡„Ÿ„Ÿ„Ÿ„Ÿ„Ÿ„Ÿ„Ÿ„¢
			set DICE[%%i][2]=„        „ 
			set DICE[%%i][3]=„    [91mœ[0m   „ 
			set DICE[%%i][4]=„        „ 
			set DICE[%%i][5]=„¤„Ÿ„Ÿ„Ÿ„Ÿ„Ÿ„Ÿ„Ÿ„£

		rem šo–Ú‚É‚æ‚Á‚Ä·‚µ‘Ö‚¦
			if !IDX%%i[1]! equ 2 (
				set DICE[%%i][2]=„  œ     „ 
				set DICE[%%i][3]=„        „ 
				set DICE[%%i][4]=„      œ „ 
			) else if !IDX%%i[1]! equ 3 (
				set DICE[%%i][2]=„      œ „ 
				set DICE[%%i][3]=„    œ   „ 
				set DICE[%%i][4]=„  œ     „ 
			) else if !IDX%%i[1]! equ 4 (
				set DICE[%%i][2]=„  œ   œ „ 
				set DICE[%%i][3]=„        „ 
				set DICE[%%i][4]=„  œ   œ „ 
			) else if !IDX%%i[1]! equ 5 (
				set DICE[%%i][2]=„  œ   œ „ 
				set DICE[%%i][3]=„    œ   „ 
				set DICE[%%i][4]=„  œ   œ „ 
			) else if !IDX%%i[1]! equ 6 (
				set DICE[%%i][2]=„  œ   œ „ 
				set DICE[%%i][3]=„  œ   œ „ 
				set DICE[%%i][4]=„  œ   œ „ 
			)
		)

	rem šo–Ú‚ðo—Í
		echo !DICE[1][1]!  !DICE[2][1]!
		echo !DICE[1][2]!  !DICE[2][2]!
		echo !DICE[1][3]!  !DICE[2][3]!
		echo !DICE[1][4]!  !DICE[2][4]!
		echo !DICE[1][5]!  !DICE[2][5]!
		echo+
		
		set /a DiceSum=!IDX1[1]!+!IDX2[1]!
		echo Dice Number : !IDX1[1]!, !IDX2[1]!
		echo         Sum : !DiceSum!
		echo+
		echo+


rem ********************** ƒtƒF[ƒY5 **********************
rem                          ”»’è
rem *******************************************************

	rem š‹¤’ÊA”Ô†‚ªHit‚µ‚½ê‡
		call echo %%WinNumber[!BetStyle!][!BetPlace!]%% | find " !DiceSum! " >nul
		if !errorlevel! equ 0 (

		rem šHard Way‚Ìê‡Aƒ_ƒCƒX“¯Žm‚Ìˆê’v‚àŠm”F
			if !BetStyle! equ 5 (
			
			rem šˆê’v‚µ‚Ä‚¢‚È‚¢ê‡‚Í•‰‚¯
				if not !IDX1[1]! equ !IDX2[1]! (
					set Result=LOSE
					echo LOSE...
					timeout -t 2 >nul
					goto :CASHOUT
				)
			)
			
		rem šHard WayˆÈŠO‚ÍHit‚µ‚½Žž“_‚ÅŸ‚¿
			set Result=WIN
			echo WIN^^!
			timeout -t 2 >nul
			goto :CASHOUT
			
	rem š”Ô†‚ªHit‚µ‚È‚©‚Á‚½ê‡
		) else (
		
		rem šPlace‚Ìê‡
			if !BetStyle! equ 2 (
			
			rem š7‚¾‚Á‚½‚ç•‰‚¯
				if !DiceSum! equ 7 (
					set Result=LOSE
					echo LOSE...
					timeout -t 2 >nul
					goto :CASHOUT
			
			rem š‚»‚êˆÈŠO‚È‚çContinue
				) else (
					echo Continue...
					pause
					goto :BET_CHECK
				)

		rem šPass Line‚Ìê‡
			) else if !BetStyle! equ 1 (
			
			rem šLoseNumber‚ÉHit‚µ‚½Žž“_‚Å•‰‚¯
				call echo %%LoseNumber[!BetStyle!][!BetPlace!]%% | find " !DiceSum! " >nul
				if !errorlevel! equ 0 (
					set Result=LOSE
					echo LOSE...
					timeout -t 2 >nul
					goto :CASHOUT
				)
		
			rem šDrawNumber‚ÉHit‚µ‚½Žž“_‚ÅPush(ˆø‚«•ª‚¯)
				call echo %%DrawNumber[!BetStyle!][!BetPlace!]%% | find " !DiceSum! " >nul
				if !errorlevel! equ 0 (
					set Result=PUSH
					echo PUSH...
					timeout -t 2 >nul
					goto :CASHOUT
				)
				
			rem š‚à‚µPoint‚ª‰Šú’l0(=‚P“Š–Ú)‚Ìê‡A2“Š–ÚˆÈ~‚ÌŸ‚¿•‰‚¯ðŒ‚ðXVAˆø‚«•ª‚¯‚Í0‚É‚µ‚Ä–³Œø‰»
				if !Point! equ 0 (
					set Point=!DiceSum!
					
					if !BetPlace! equ 1 (
						set WinNumber[!BetStyle!][!BetPlace!]= !DiceSum! 
						set LoseNumBer[!BetStyle!][!BetPlace!]= 7 
					) else (
						set WinNumber[!BetStyle!][!BetPlace!]= 7 
						set LoseNumBer[!BetStyle!][!BetPlace!]= !DiceSum! 
					)
					set DrawNumber[!BetStyle!][!BetPlace!]= 0 
					echo Point...
			
			rem š2“Š–ÚˆÈ~‚ÍPoint‚ÌXV‚Ís‚í‚¸‚ÉÄŽÀs
				) else (
					echo Continue...
				)
				
				pause
				goto :BET_CHECK
				
		rem šHard Way‚Ìê‡
			) else if !BetStyle! equ 5 (
			
			rem š7‚¾‚Á‚½‚ç•‰‚¯
				if !DiceSum! equ 7 (
					set Result=LOSE
					echo LOSE...
					timeout -t 2 >nul
					goto :CASHOUT
			
			rem š‚»‚êˆÈŠO‚È‚çContinue
				) else (
					echo Continue...
					pause
					goto :BET_CHECK
				)
			)
	
		rem šPass Line, Place, HardWayˆÈŠO‚ÅHit‚µ‚È‚©‚Á‚½ê‡‚Í‘¦•‰‚¯
			set Result=LOSE
			echo LOSE...
			timeout -t 2 >nul
			goto :CASHOUT
		)


:CASHOUT

	if !BetStyle! equ 1 (
		set Payout=200
	) else if !BetStyle! equ 2 (
		if !BetPlace! equ 1 (
			set Payout=280
		) else if !BetPlace! equ 2 (
			set Payout=240
		) else if !BetPlace! equ 5 (
			set Payout=240
		) else if !BetPlace! equ 6 (
			set Payout=280
		) else (
			set Payout=220
		)
	) else if !BetStyle! equ 3 (
		set Payout=200
	) else if !BetStyle! equ 4 (
		if !BetPlace! equ 1 (
			set Payout=500
		) else if !BetPlace! equ 2 (
			set Payout=800
		) else if !BetPlace! equ 3 (
			set Payout=1600
		) else if !BetPlace! equ 5 (
			set Payout=1600
		) else (
			set Payout=3100
			set AchievementFlag[7]=1
		)
	) else if !BetStyle! equ 5 (
		if !BetPlace! equ 1 (
			set Payout=800
		) else if !BetPlace! equ 2 (
			set Payout=800
		) else (
			set Payout=1000
		)
	)

	if "!Result!"=="WIN" (
		set /a Balance+=!Payout!
	) else if "!Result!"=="PUSH" (
		set /a Balance+=100
	)


:CHECK_RESULT
	cls
	call :TITLE_CALL
	echo Result : !Result!
	echo+
	echo Cashing out...
	echo ------------------------------
	if "!Result!"=="WIN" (
		echo Payout : !Payout!
	) else if "!Result!"=="LOSE" (
		echo Payout : 0
	) else (
		echo Payout  : 100
	)
	echo Balance : !Balance!
	echo ------------------------------
	echo+
	
rem šÄPLAY—p‘I‘ðŽˆ
	
	set /p RETRY="Do you want to retry? (y/n) : "
		if "%RETRY%"=="y" (
			cls
			goto :TOP
		) else if "%RETRY%"=="Y" (
			cls
			goto :TOP
		) else if "%RETRY%"=="n" (
			goto :SAVEEXIT
		) else if "%RETRY%"=="N" (
			goto :SAVEEXIT
		) else (
			cls
			goto :CHECK_RESULT
	)


exit /b


:SAVEEXIT
	echo BALANCE=!Balance! > .\save\!CallData!
	echo AchievementFlag[1]=!AchievementFlag[1]!>> .\save\!CallData!
	echo AchievementFlag[2]=!AchievementFlag[2]!>> .\save\!CallData!
	echo AchievementFlag[3]=!AchievementFlag[3]!>> .\save\!CallData!
	echo AchievementFlag[4]=!AchievementFlag[4]!>> .\save\!CallData!
	echo AchievementFlag[5]=!AchievementFlag[5]!>> .\save\!CallData!
	echo AchievementFlag[6]=!AchievementFlag[6]!>> .\save\!CallData!
	echo AchievementFlag[7]=!AchievementFlag[7]!>> .\save\!CallData!
	exit /b


rem ========================================================
rem                       ŠÖ”’è‹`•”
rem ========================================================



:TITLE_CALL
	cls
	echo =====================================
	echo              š Craps š 
	echo =====================================
	echo ------------------------------------
	echo Balance : !Balance!
	echo ------------------------------------
	echo+
	exit /b


:INVALID_CALL
	echo Invalid Value.
	timeout -t 2 >nul
	goto :SELECT_LOOP
	exit /b