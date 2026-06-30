@echo off

setlocal enabledelayedexpansion

rem šƒf[ƒ^ƒ[ƒh
:LOAD
	rem šŒÄ‚Ño‚µƒf[ƒ^/‘I‘ðƒf[ƒ^‚ð‰Šú‰»
		set CallData=
		set SelectData=0
		set DataLoad=0
		
	rem š‚Í‚¶‚ß‚©‚ç/‚Â‚Ã‚«‚©‚ç
		cls
		echo ----------------------------------
		echo Choose number.
		echo 1. NEW GAME   /   2. DATA LOAD
		echo ----------------------------------
		set /p DataLoad=""


	rem š‚Í‚¶‚ß‚©‚ç
		if %DataLoad% equ 1 (
		
		rem šŒ»ÝŽž‚ÅƒZ[ƒuƒtƒ@ƒCƒ‹‚ðì¬EŒÄ‚Ño‚µƒf[ƒ^‚Æ‚µ‚Ä“o˜^
		mkdir .\save
			set CallData=save_%date:~,4%%date:~5,2%%date:~8,2%_%time:~,2%%time:~3,2%.dat
			echo BALANCE=1000 > .\save\!CallData!
	
	rem š‚Â‚Ã‚«‚©‚ç
		) else if %DataLoad% equ 2 (
		
		rem šŠù‘¶‚ÌƒZ[ƒuƒtƒ@ƒCƒ‹‚Ì”‚ðƒJƒEƒ“ƒg‚µ‚Äƒtƒ@ƒCƒ‹–¼‚ð•Ï”‚ÉŠi”[
			set SaveFileCount=0
			cls
			for %%f in (.\save\save*.dat) do (
				set /a SaveFileCount+=1
				set File[!SaveFileCount!]=%%f
			)
		
		rem šƒZ[ƒuƒtƒ@ƒCƒ‹‚Ì‘I‘ð
			echo Select Save File:
			for /l %%i in (1,1,!SaveFileCount!) do (
				echo   %%i. !File[%%i]:~7!
			)
			set /p SelectData=""
			
		rem š‘I‘ð‚µ‚½ƒZ[ƒuƒtƒ@ƒCƒ‹”Ô†‚ª³‚µ‚¢ê‡
			if !SelectData! geq 1 (
				if !SelectData! leq !SaveFileCount! (
			
				rem šŒÄ‚Ño‚µƒf[ƒ^‚Æ‚µ‚Ä“o˜^
					for /f "usebackq" %%A in (`call echo %%File[!SelectData!]:~,7%%`) do set CallData=%%A
					
					
				) else (
				
				rem š‘I‘ð‚µ‚½ƒZ[ƒuƒtƒ@ƒCƒ‹”Ô†‚ª•s³‚Ìê‡1
					echo Invalid value.
					timeout -t 1 >nul
					cls
					goto :LOAD
				)
		rem š‘I‘ð‚µ‚½ƒZ[ƒuƒtƒ@ƒCƒ‹”Ô†‚ª•s³‚Ìê‡2
			) else (
				echo Invalid value.
				timeout -t 1 >nul
				cls
				goto :LOAD
			)
	rem š1:‚Í‚¶‚ß‚©‚ç 2:‚Â‚Ã‚«‚©‚çˆÈŠO‚ð‘I‘ð‚µ‚½ê‡
		) else (
		goto :LOAD
		)



rem šƒƒjƒ…[‰æ–Ê
:TOP
	cls
	set CHOGAME=0
	
	rem š ƒZ[ƒuƒf[ƒ^ŒÄ‚Ño‚µ
		for /f "tokens=1,2 delims==" %%a in (.\save\%CallData%) do (
	    	set %%a=%%b
		)
		
	rem šƒƒjƒ…[‰æ–Ê•\Ž¦
		call :TITLE_CALL
		echo --------------------------
		echo Balance : !Balance!
		echo --------------------------
		echo+
		echo [93mPlease choose the game you want to play.[0m : 
		echo  1. POKER
		echo  2. BLACKJACK
		echo  3. SLOTGAME
		echo  4. BACCARAT
		echo  5. ROULETTE
		echo  6. HIGH/LOW
		echo  7. CRAPS
		echo  [2m?. How To PLAY[0m
		echo  [2mq. Exit[0m
		set /p CHOGAME=""

	rem š[1]‚Åƒ|[ƒJ[ŠJŽn
		if %CHOGAME% equ 1 (
			call .\call_bat\tp1.bat
	
	rem š[2]‚Åƒuƒ‰ƒbƒNƒWƒƒƒbƒNŠJŽn
		) else if %CHOGAME% equ 2 (
			call .\call_bat\tp2.bat
	
	rem š[3]‚ÅƒXƒƒbƒgŠJŽn
		) else if %CHOGAME% equ 3 (
			call .\call_bat\tp3.bat
			
	rem š[4]‚ÅƒoƒJƒ‰ŠJŽn
		) else if %CHOGAME% equ 4 (
			call .\call_bat\tp4.bat
	
	rem š[5]‚Åƒ‹[ƒŒƒbƒgŠJŽn
		) else if %CHOGAME% equ 5 (
			call .\call_bat\tp5.bat
			
	rem š[6]‚ÅHIGH/LOWŠJŽn
		) else if %CHOGAME% equ 6 (
			call .\call_bat\tp6.bat
			
	rem š[7]‚ÅCRAPSŠJŽn
		) else if %CHOGAME% equ 7 (
			call .\call_bat\tp7.bat
	
	rem š[T]‚Åtest.batŠJŽn(ƒfƒoƒbƒO—p)
		) else if %CHOGAME% equ T (
			call .\call_bat\test.bat
			
	rem š[?]‚Å—V‚Ñ•û‚ð•\Ž¦
		) else if "%CHOGAME%"=="?" (
			call :HOWTO
			goto :TOP
	
	rem š[q]‚Åƒoƒbƒ`I—¹
		) else if "%CHOGAME%"=="q" (
			set CANCEL=0

		rem š3•bŠÔ‚Ì—P—\ [c]‚ÅI—¹‚ðƒLƒƒƒ“ƒZƒ‹
			for /l %%i in (3,-1,1) do (
    			cls
    			echo Exiting in %%i seconds...
    			echo Press c to cancel.

    			choice /c cQ /t 1 /d Q /n

    			if errorlevel 2 (
	        		rem š‰½‚à‰Ÿ‚³‚È‚¢ or Q
	    		) else (
        			set CANCEL=1
        			goto :CANCEL
    			)
			)
			
		rem šI—¹
			exit /b

		rem šI—¹cancelŽž
			:CANCEL
				echo Exit canceled.
				timeout -t 2 >nul
				goto :TOP
			
	rem š‚»‚êˆÈŠO‚ª“ü—Í‚³‚ê‚½ê‡‚ÍTOP‚É–ß‚é
		) else (
			goto :TOP
		)
	goto :TOP

:HOWTO
	cls
	set HowToPlay=9999
	call :TITLE_CALL
	echo [96mPlease select a game to learn how to play.[0m : 
	echo+
	echo  1. POKER
	echo  2. BLACKJACK
	echo  3. SLOTGAME
	echo  4. BACCARAT
	echo  5. ROULETTE
	echo  6. HIGH/LOW
	echo  7. CRAPS
	echo  [2m0. Back[0m
	set /p HowToPlay=""
	
	rem š[1]‚Åƒ|[ƒJ[
		if %HowToPlay% equ 1 (
			cls
			call :POKER_RULE_CALL1
			pause
			cls
			call :POKER_RULE_CALL1
			call :POKER_RULE_CALL2
			pause
			goto :HOWTO
	
	rem š[2]‚Åƒuƒ‰ƒbƒNƒWƒƒƒbƒN
		) else if %HowToPlay% equ 2 (
			cls
			call :BLACKJACK_RULE_CALL1
			pause
			cls
			call :BLACKJACK_RULE_CALL1
			call :BLACKJACK_RULE_CALL2
			pause
			goto :HOWTO
	
	rem š[3]‚ÅƒXƒƒbƒg
		) else if %HowToPlay% equ 3 (
			cls
			call :SLOT_RULE_CALL1
			pause
			cls
			call :SLOT_RULE_CALL1
			call :SLOT_RULE_CALL2
			pause
			goto :HOWTO
			
	rem š[4]‚ÅƒoƒJƒ‰
		) else if %HowToPlay% equ 4 (
			cls
			call :BACCARAT_RULE_CALL1
			pause
			cls
			call :BACCARAT_RULE_CALL1
			call :BACCARAT_RULE_CALL2
			pause
			goto :HOWTO
	
	rem š[5]‚Åƒ‹[ƒŒƒbƒg
		) else if %HowToPlay% equ 5 (
			cls
			call :ROULETTE_RULE_CALL1
			pause
			cls
			call :ROULETTE_RULE_CALL1
			call :ROULETTE_RULE_CALL2
			pause
			goto :HOWTO
			
	rem š[6]‚ÅHIGH/LOW
		) else if %HowToPlay% equ 6 (
			cls
			call :HIGHLOW_RULE_CALL1
			pause
			cls
			call :HIGHLOW_RULE_CALL1
			call :HIGHLOW_RULE_CALL2
			pause
			goto :HOWTO
			
	rem š[7]‚ÅCRAPS
		) else if %HowToPlay% equ 7 (
			cls
			call :CRAPS_RULE_CALL1
			pause
			cls
			call :CRAPS_RULE_CALL1
			call :CRAPS_RULE_CALL2
			pause
			goto :HOWTO
	
	rem š[0]‚Å–ß‚é
		) else if %HowToPlay% equ 0 (
			exit /b
	
	rem š‚»‚Ì‘¼‚Ì“ü—Í‚Í—V‚Ñ•ûTOP‚É–ß‚é
		) else (
			goto :HOWTO
		)



:TITLE_CALL
echo ==========================================
echo    š š š CASINO GAME CENTER š š š
echo ==========================================
echo+
exit /b


:POKER_RULE_CALL1
	echo ›ƒ|[ƒJ[
	echo+
	echo   ¥ŠT—v
	echo     5–‡‚ÌŽèŽD‚Å–ð‚ðì‚èA‚»‚Ì‹­‚³‚ð‹£‚¤ƒQ[ƒ€‚Å‚·B
	echo+     
	echo   ¥ƒQ[ƒ€‚Ì—¬‚ê
	echo     1. 5–‡‚ÌƒJ[ƒh‚ª”z‚ç‚ê‚Ü‚·B
	echo     2. ƒJ[ƒh‚ÍÅ‘å3‰ñ‚Ü‚ÅŒðŠ·‚Å‚«‚Ü‚·B
	echo        ŒðŠ·‚µ‚½‚¢ƒJ[ƒh‚Ì”Ô†‚ð“ü—Í‚µ‚Ä‚­‚¾‚³‚¢B
	echo        ŒðŠ·‚µ‚½‚­‚È‚¢ê‡‚Íu0v‚ð“ü—Í‚·‚é‚ÆA‚»‚ÌŽž“_‚ÅŽèŽD‚ªŠm’è‚µ‚Ü‚·B
	echo     3. ÅI“I‚È5–‡‚ÌŽèŽD‚©‚ç–ð‚ª”»’è‚³‚ê‚Ü‚·B
	echo     4. –ð‚É‰ž‚¶‚Ä”z“–‚ðŽó‚¯Žæ‚è‚Ü‚·B
	echo+   
	echo   ¥Ÿ—˜ðŒ
	echo     ˆÈ‰º‚Ì‚¢‚¸‚ê‚©‚Ì–ð‚ð¬—§‚³‚¹‚Ü‚·B
	echo     EOne Pair             : “¯‚¶”Žš‚ÌƒJ[ƒh‚ª2–‡‚ ‚éó‘ÔB
	echo     ETwo Pair             : “¯‚¶”Žš‚ÌƒJ[ƒh2–‡‚Ì‘g‚ª2‘g‚ ‚éó‘ÔB
	echo     EThree of a Kind      : “¯‚¶”Žš‚ÌƒJ[ƒh‚ª3–‡‚ ‚éó‘ÔB
	echo     EStraight             : ”Žš‚ª˜A‘±‚µ‚½ƒJ[ƒh‚ª5–‡‚ ‚éó‘ÔBƒ}[ƒN‚Í–â‚í‚È‚¢B
	echo     EFlush                : “¯‚¶ƒ}[ƒN‚ÌƒJ[ƒh‚ª5–‡‚ ‚éó‘ÔB”Žš‚Ì•À‚Ñ‚Í–â‚í‚È‚¢B
	echo     EFull House           : Three of a Kind‚ÆOne Pair‚ª“¯Žž‚É¬—§‚µ‚Ä‚¢‚éó‘ÔB
	echo     EFour of a Kind       : “¯‚¶”Žš‚ÌƒJ[ƒh‚ª4–‡‚ ‚éó‘ÔB
	echo     EStraight Flush       : “¯‚¶ƒ}[ƒN‚©‚Â”Žš‚ª˜A‘±‚µ‚½ƒJ[ƒh‚ª5–‡‚ ‚éó‘ÔB
	echo     ERoyal Straight Flush : 10AJAQAKAA‚É‚æ‚éStraight FlushB
	echo+
	exit /b

:POKER_RULE_CALL2
	echo   ¥”z“–
	echo+     
	echo     EŠ|‚¯‹à : 100
	echo     ----------------------------------------------------------
	echo     –ð                        •¥–ß”{—¦
	echo     ----------------------------------------------------------
	echo     EOne Pair             : x 0.5
	echo     ETwo Pair             : x 1.5
	echo     EThree of a Kind      : x   3
	echo     EStraight             : x   5
	echo     EFlush                : x   7
	echo     EFull House           : x  10
	echo     EFour of a Kind       : x  25
	echo     EStraight Flush       : x  50
	echo     ERoyal Straight Flush : x 100
	echo     ----------------------------------------------------------
	echo+
	exit /b

:BLACKJACK_RULE_CALL1
	echo ›ƒuƒ‰ƒbƒNƒWƒƒƒbƒN
	echo+
	echo   ¥ŠT—v
	echo     ƒfƒB[ƒ‰[‚ÆŸ•‰‚µAŽèŽD‚Ì”’l‚Ì‡Œv‚ð21‚É‹ß‚Ã‚¯‚éƒQ[ƒ€‚Å‚·B
	echo     11A12A13‚ÌƒJ[ƒh‚Í10‚Æ‚µ‚ÄƒJƒEƒ“ƒg‚³‚ê‚Ü‚·B
	echo     ‚Ü‚½A1‚ÌƒJ[ƒh‚Í1‚Ü‚½‚Í11‚Æ‚µ‚ÄƒJƒEƒ“ƒg‚·‚é‚±‚Æ‚ª‚Å‚«‚Ü‚·B
	echo+    
	echo   ¥ƒQ[ƒ€‚Ì—¬‚ê
	echo     1. ƒvƒŒƒCƒ„[‚ÆƒfƒB[ƒ‰[‚»‚ê‚¼‚ê‚É2–‡‚ÌƒJ[ƒh‚ª”z‚ç‚ê‚Ü‚·B
	echo     2. ‚±‚ÌŽž“_‚Å21‚ª¬—§‚µ‚Ä‚¢‚éê‡ABLACKJACK‚Æ‚È‚è‚Ü‚·B
	echo        (—á: 1 + 10 or 11 or 12 or 13)
	echo        ƒvƒŒƒCƒ„[‚ªBLACKJACK‚Æ‚È‚Á‚½ê‡‚ÍŸ—˜‚Æ‚È‚è‚Ü‚·B
	echo        ‚½‚¾‚µAƒfƒB[ƒ‰[‚àBLACKJACK‚Ìê‡‚Íˆø‚«•ª‚¯‚É‚È‚è‚Ü‚·B
	echo     3. ƒvƒŒƒCƒ„[‚ÍHit‚ð‘I‘ð‚·‚é‚±‚Æ‚Å’Ç‰Á‚ÅƒJ[ƒh‚ðˆø‚­‚±‚Æ‚ª‚Å‚«‚Ü‚·B
	echo        ‚±‚êˆÈãƒJ[ƒh‚ðˆø‚©‚È‚¢ê‡‚ÍStand‚ð‘I‘ð‚µ‚Ä‚­‚¾‚³‚¢B
	echo        ƒJ[ƒh‚Ì‡Œv‚ª21‚ð’´‚¦‚½Žž“_‚ÅBust‚Æ‚È‚èA”s–k‚ªŠm’è‚µ‚Ü‚·B
	echo     4. ƒvƒŒƒCƒ„[‚Ìƒ^[ƒ“I—¹ŒãA‹K’è‚É]‚Á‚ÄƒfƒB[ƒ‰[‚ªs“®‚µ‚Ü‚·B
	echo     5. ƒvƒŒƒCƒ„[‚ÆƒfƒB[ƒ‰[‘o•û‚ªStand‚Æ‚È‚Á‚½Žž“_‚Å”’l‚ð”äŠr‚µAŸ”s‚ðŒˆ’è‚µ‚Ü‚·B
	echo+  
	echo   ¥Ÿ—˜ðŒ
	echo     E21‚ð’´‚¦‚¸A‚æ‚è21‚É‹ß‚Ã‚¯‚½•û‚ÌŸ—˜‚Æ‚È‚è‚Ü‚·B
	echo     E21‚ð’´‚¦‚½ê‡‚ÍBust‚Æ‚È‚è”s–k‚Æ‚È‚è‚Ü‚·B
	echo     E“¯“_‚Ìê‡‚Íˆø‚«•ª‚¯‚Æ‚È‚è‚Ü‚·B
	echo+
	exit /b
	
:BLACKJACK_RULE_CALL2
	echo   ¥”z“–
	echo+
	echo     EŠ|‚¯‹à : 100
	echo     ----------------------------------------------------------
	echo      Ÿ”s                    •¥–ß”{—¦
	echo     ----------------------------------------------------------
	echo     EŸ—˜                  : x   2
	echo     EŸ—˜(BLACKJACK‚É‚æ‚é) : x 2.5
	echo     Eˆø‚«•ª‚¯              : x   1
	echo     ----------------------------------------------------------
	echo+
	exit /b

:SLOT_RULE_CALL1
	echo ›ƒXƒƒbƒgƒQ[ƒ€
	echo+
	echo   ¥ŠT—v
	echo     ƒRƒCƒ“‚ð“Š“ü‚µ‚Ä3x3‚ÌƒXƒƒbƒg‚ð‰ñ‚µ‚Ü‚·B
	echo     “¯‚¶ŠG•¿‚ª3‚Â‘µ‚¤‚ÆƒRƒCƒ“‚ðŠl“¾‚Å‚«‚Ü‚·B
	echo+     
	echo   ¥ƒQ[ƒ€‚Ì—¬‚ê
	echo     1. ƒRƒCƒ“‚ð“Š“ü‚µ‚Ü‚·B“Š“ü‚µ‚½ƒRƒCƒ“‚É‰ž‚¶‚ÄƒvƒŒƒC‰ñ”‚ªŒˆ‚Ü‚è‚Ü‚·B
	echo        “Š“ü‚Å‚«‚éƒRƒCƒ“‚ÆƒvƒŒƒC‰ñ”‚ÍˆÈ‰º‚Ì’Ê‚è‚Å‚·B
	echo          E 10 ƒRƒCƒ“ :  1‰ñ
	echo          E 50 ƒRƒCƒ“ :  5‰ñ
	echo          E100 ƒRƒCƒ“ : 10‰ñ
	echo          E500 ƒRƒCƒ“ : 50‰ñ
	echo     2. ƒXƒƒbƒg‚ªŠJŽn‚³‚ê‚Ü‚·B
	echo     3. ŠG•¿‚ª3‚Â‘µ‚¤‚Æ”z“–‚ªŽó‚¯Žæ‚ê‚Ü‚·B
	echo+  
	echo   ¥Ÿ—˜ðŒ
	echo     ˆÈ‰º‚Ì5ƒ‰ƒCƒ“‚Ì‚¢‚¸‚ê‚©‚Å“¯‚¶ŠG•¿‚ª3‚Â‘µ‚¤‚Æ”z“–‚ðŠl“¾‚Å‚«‚Ü‚·B
	echo     ”z“–‚Í‘µ‚¦‚½ŠG•¿‚¨‚æ‚Ñƒ‰ƒCƒ“‚É‚æ‚Á‚ÄˆÙ‚È‚è‚Ü‚·B
	echo+    
	echo      E’†‰›:      Eã’i:¡¡¡   E‰º’i:   
	echo             ¡¡¡                          
	echo                                       ¡¡¡
	echo+             
	echo      E‰Eã‚ª‚èŽÎ‚ß:  ¡     E‰E‰º‚ª‚èŽÎ‚ß:¡  
	echo                      ¡                      ¡ 
	echo                     ¡                        ¡
	echo+ 
	exit /b

:SLOT_RULE_CALL2
	echo   ¥”z“–
	echo+
	echo     E1ƒvƒŒƒC‚ ‚½‚è‚ÌŠ|‚¯‹à : 10
	echo     ----------------------------------------------------------
	echo       ŠG•¿            ’†‰›ƒ‰ƒCƒ“     ‚»‚Ì‘¼ƒ‰ƒCƒ“
	echo     ----------------------------------------------------------
	echo     ESEVEN  :        x 77.7          x   30
	echo     EBAR    :        x   10          x    8
	echo     EBELL   :        x    4          x  3.2
	echo     EORANGE :        x    2          x  1.6
	echo     ELEMON  :        x    1          x  0.8
	echo     ECHERRY :        x  0.5          x  0.4
	echo     ----------------------------------------------------------
	echo+
	exit /b

:BACCARAT_RULE_CALL1
echo ›ƒoƒJƒ‰
echo+ 
echo   ¥ŠT—v
echo     ƒvƒŒƒCƒ„[‚Æƒoƒ“ƒJ[‚Ì‚Ç‚¿‚ç‚ªŸ‚Â‚©‚ð—\‘z‚·‚éƒQ[ƒ€‚Å‚·B
echo     ƒJ[ƒh‚ðˆø‚­‚©‚Ç‚¤‚©‚Íƒ‹[ƒ‹‚É]‚Á‚ÄŽ©“®“I‚ÉŒˆ’è‚³‚êA
echo     ƒvƒŒƒCƒ„[‚ª‰î“ü‚·‚é‚±‚Æ‚Í‚Å‚«‚Ü‚¹‚ñB
echo+   
echo   ¥ƒQ[ƒ€‚Ì—¬‚ê
echo     1. ƒxƒbƒgŠz‚ð“ü—Í‚µ‚Ü‚·B
echo     2. ƒvƒŒƒCƒ„[Aƒoƒ“ƒJ[‚Ü‚½‚Íˆø‚«•ª‚¯‚Ì‚¢‚¸‚ê‚©‚Éƒxƒbƒg‚µ‚Ü‚·B
echo     3. ƒvƒŒƒCƒ„[Eƒoƒ“ƒJ[‚É2–‡‚¸‚ÂƒJ[ƒh‚ª”z‚ç‚ê‚Ü‚·B
echo     4. ƒ‹[ƒ‹‚É‰ž‚¶‚ÄA•K—v‚Èê‡3–‡–Ú‚ÌƒJ[ƒh‚ª”z‚ç‚ê‚Ü‚·B
echo     5. ÅI“I‚È“_”‚ð”äŠr‚µ‚ÄAŸ”s‚ðŒˆ’è‚µ‚Ü‚·B
echo+     
echo        “_”‚ÍƒJ[ƒh‚Ì‡Œv’l‚Ì1‚ÌˆÊ‚ðŽg—p‚µ‚Ü‚·B(—á: 7+8=15 ¨ 5“_)
echo        ‚Ü‚½A10A11A12A13‚ÌƒJ[ƒh‚Í0“_‚Æ‚µ‚Äˆµ‚í‚ê‚Ü‚·B
echo+   
echo   ¥Ÿ—˜ðŒ
echo     ƒvƒŒƒCƒ„[‚Æƒoƒ“ƒJ[‚Ì“¾“_‚ð”äŠr‚µA“¾“_‚Ì‚‚¢•û‚ªŸ—˜‚Æ‚È‚è‚Ü‚·B
echo     ŸŽÒ‚Éƒxƒbƒg‚µ‚Ä‚¢‚½ê‡A”z“–‚ªŠl“¾‚Å‚«‚Ü‚·B
echo+       
exit /b

:BACCARAT_RULE_CALL2
echo   ¥”z“–
echo+   
echo     EŠ|‚¯‹à : ”CˆÓ
echo     ----------------------------------------------------------
echo      Ÿ”s               •¥–ß”{—¦
echo     ----------------------------------------------------------
echo     EƒvƒŒƒCƒ„[ “I’†  : x   2
echo     Eƒoƒ“ƒJ[ “I’†    : x   2
echo     Eˆø‚«•ª‚¯ “I’†    : x   9
echo     ----------------------------------------------------------
echo+
exit /b

:ROULETTE_RULE_CALL1
echo ›ƒ‹[ƒŒƒbƒg
echo+
echo   ¥ŠT—v
echo     0`36‚Ì”Žš‚Ì‚Ç‚±‚Éƒ{[ƒ‹‚ªŽ~‚Ü‚é‚©‚ð—\‘z‚·‚éƒQ[ƒ€‚Å‚·B
echo     ƒvƒŒƒCƒ„[‚ÍD‚«‚ÈêŠ‚Éƒxƒbƒg‚·‚é‚±‚Æ‚ª‚Å‚«‚Ü‚·B
echo     ”Žš‚»‚Ì‚à‚Ì‚¾‚¯‚Å‚È‚­A•¡”‚Ì”Žš‚âFA‹ô”EŠï”‚È‚Ç‚É‚à‚©‚¯‚é‚±‚Æ‚ª‚Å‚«‚Ü‚·B
echo+    
echo   ¥ƒQ[ƒ€‚Ì—¬‚ê
echo     1. ƒxƒbƒgŠz‚ð“ü—Í‚µ‚Ü‚·B
echo     2. ƒxƒbƒgŽí•Ê‚ð‘I‘ð‚µ‚Ü‚·BƒxƒbƒgŽí•Ê‚É‚æ‚è”z“–‚ªˆÙ‚È‚è‚Ü‚·B
echo     3. ƒxƒbƒgˆÊ’u‚ð‘I‘ð‚µ‚Ü‚·B
echo     4. ƒ‹[ƒŒƒbƒg‚ªŠJŽn‚³‚ê‚Ü‚·B“–‘I‚µ‚½ê‡Aƒxƒbƒg‚ÌŽí—Þ‚É‰ž‚¶‚½”z“–‚ðŠl“¾‚µ‚Ü‚·B
echo+  
echo   ¥Ÿ—˜ðŒ
echo     ƒxƒbƒg‚µ‚½“à—e‚ª“–‘IŒ‹‰Ê‚ÉŠY“–‚µ‚½ê‡AƒxƒbƒgŽí•Ê‚É‰ž‚¶‚½”z“–‚ðŠl“¾‚Å‚«‚Ü‚·B
echo     ƒxƒbƒgŽí•Ê‚ÍˆÈ‰º‚Ì’Ê‚è‚Å‚·B
echo     EStraight Up         : ’Pˆê‚Ì”Žš‚É“q‚¯‚Ü‚·B
echo     ESplit               : —×Ú‚·‚é2‚Â‚Ì”Žš‚É“q‚¯‚Ü‚·B
echo     EStreet              : 3‚Â‚Ì”Žš(1—ñ•ª)‚É“q‚¯‚Ü‚·B
echo     ECorner              : —×Ú‚·‚é4‚Â‚Ì”Žš‚É“q‚¯‚Ü‚·B
echo     ESix Line            : —×Ú‚·‚é2‚Â‚ÌStreet(6‚Â‚Ì”Žš)‚É“q‚¯‚Ü‚·B
echo     E0 Bets (Trio)       : 0‚ðŠÜ‚Þ—×Ú‚·‚é3‚Â‚Ì”Žš‚É“q‚¯‚Ü‚·B(0-1-2‚Ü‚½‚Í0-2-3)
echo     E0 Bets (First Four) : 0‚ðŠÜ‚Þ—×Ú‚·‚é4‚Â‚Ì”Žš‚É“q‚¯‚Ü‚·B(0-1-2-3)
echo     EColumn              : [1,4,7,`,34]A[2,5,8,`,35]A[3,6,9,`,36]‚Ì‚¢‚¸‚ê‚©12ŒÂ‚Ì”Žš‚É“q‚¯‚Ü‚·B
echo     EDozen               : [1`12]A[13`24]A[25`36]‚Ì‚¢‚¸‚ê‚©‚É“q‚¯‚Ü‚·B
echo     ERed / Black         : Ô‚Ü‚½‚Í•‚É“q‚¯‚Ü‚·B
echo     EEven / Odd          : ‹ô”‚Ü‚½‚ÍŠï”‚É“q‚¯‚Ü‚·B
echo     ELow / High          : [1`18] ‚Ü‚½‚Í [19`36] ‚É“q‚¯‚Ü‚·B
echo+  
exit /b

:ROULETTE_RULE_CALL2
echo   ¥”z“–
echo+  
echo     EŠ|‚¯‹à : ”CˆÓ
echo     ----------------------------------------------------------
echo     ƒxƒbƒgŽí•Ê               •¥–ß”{—¦
echo     ----------------------------------------------------------
echo     EStraight Up            :  x 36
echo     ESplit                  :  x 18
echo     EStreet                 :  x 12
echo     ECorner                 :  x  9
echo     ESix Line               :  x  6
echo     E0 Bets (Trio)          :  x 12
echo     E0 Bets (First Four)    :  x  9
echo     EColumn                 :  x  3
echo     EDozen                  :  x  3
echo     ERed / Black            :  x  2
echo     EEven / Odd             :  x  2
echo     ELow / High             :  x  2
echo     ----------------------------------------------------------
echo+
exit /b

:HIGHLOW_RULE_CALL1
echo ›HIGH/LOW
echo+
echo   ¥ŠT—v
echo     Œ»Ý‚ÌƒJ[ƒh‚æ‚èŽŸ‚ÌƒJ[ƒh‚ª‚‚¢‚©’á‚¢‚©‚ð—\‘z‚·‚éƒQ[ƒ€‚Å‚·B
echo     —\‘z‚ª“I’†‚·‚é‚ÆÜ‹à‚ðŠl“¾‚Å‚«A˜AŸ‚·‚é‚Ù‚Ç•¥‚¢–ß‚µ”{—¦‚ªã¸‚µ‚Ü‚·B
echo     –{ƒQ[ƒ€‚Å‚Í—\‘z‚ðs‚¤‚½‚Ñ‚ÉŠ|‚¯‹à‚ª”­¶‚µ‚Ü‚·B
echo     ˜AŸ‚É‚æ‚é‚”z“–‚ÆAŠ|‚¯‹à‚Ì‘‰ÁƒŠƒXƒN‚ð“V”‰‚É‚©‚¯‚È‚ª‚çÜ‹àŠl“¾‚ð–ÚŽw‚µ‚Ü‚·B
echo     ‚Ü‚½A3˜AŸ‚²‚Æ‚ÉÜ‹à‚ðŠm’èiSAVEj‚Å‚«‚Ü‚·B
echo     SAVE‚ðs‚¤‚ÆŽŸ‰ñˆÈ~‚ÌŠ|‚¯‹à‚ª2”{‚É‚È‚è‚Ü‚·‚ªAƒQ[ƒ€ƒI[ƒo[‚É‚È‚Á‚Ä‚àŠm’èÏ‚Ý‚ÌÜ‹à‚ÍŽ¸‚í‚ê‚Ü‚¹‚ñB
echo+
echo   ¥ƒQ[ƒ€‚Ì—¬‚ê
echo     1. Œ»Ý‚ÌƒJ[ƒh‚ª•\Ž¦‚³‚ê‚Ü‚·B
echo     2. ŽŸ‚ÌƒJ[ƒh‚ª HIGHi‚æ‚è‘å‚«‚¢j‚© LOWi‚æ‚è¬‚³‚¢j‚©‚ð—\‘z‚µ‚Ü‚·B
echo     3. —\‘z‚ª“I’†‚·‚é‚ÆÜ‹à‚ðŠl“¾‚Å‚«‚Ü‚·B
echo        “¯‚¶”Žš‚¾‚Á‚½ê‡‚Íˆø‚«•ª‚¯‚Æ‚È‚èAŽŸ‚ÌƒJ[ƒh‚ÅÄ”»’è‚µ‚Ü‚·B
echo     4. 3˜AŸ‚²‚Æ‚É SAVE ‚ª‰Â”\‚É‚È‚è‚Ü‚·B
echo     5. ‘±s‚·‚é‚©AÜ‹à‚ðŽó‚¯Žæ‚Á‚ÄI—¹iCash Outj‚·‚é‚©‚ð‘I‘ð‚µ‚Ü‚·B
echo+
echo   ¥Ÿ—˜ðŒ
echo     HIGH / LOW ‚Ì—\‘z‚ð“I’†‚³‚¹‘±‚¯‚é‚±‚Æ‚ÅÜ‹à‚ð‘‚â‚¹‚Ü‚·B
echo     Cash Out ‚ðs‚¤‚ÆA‚»‚ÌŽž“_‚ÌÜ‹à‚ðŠl“¾‚µ‚ÄƒQ[ƒ€I—¹‚Æ‚È‚è‚Ü‚·B
echo     —\‘z‚ðŠO‚µ‚½ê‡A–¢Šm’è‚ÌÜ‹à‚Í‚·‚×‚ÄŽ¸‚í‚ê‚Ü‚·B
echo     SAVE ‚µ‚Ä‚¢‚½ê‡‚ÍAÅŒã‚ÉŠm’è‚µ‚½Ü‹à‚ðŠl“¾‚Å‚«‚Ü‚·B
echo+
exit /b


:HIGHLOW_RULE_CALL2
echo   ¥”z“–
echo     EŠ|‚¯‹à : 100 ¨ 200 ¨ 400 ¨ 800 ¨ 1600 ¨ c 
echo         ¦SAVEŽÀs‚²‚Æ‚Éã¸‚µ‚Ü‚·BƒQ[ƒ€ƒI[ƒo[‚É‚È‚é‚Æ‰Šú’l100‚É–ß‚è‚Ü‚·B
echo+
echo     ----------------------------------------------------------
echo      ˜AŸ”          •¥–ß”{—¦
echo     ----------------------------------------------------------
echo     E1Ÿ            : x 1.0
echo     E2Ÿ            : x 1.5
echo     E3Ÿ            : x 2.0
echo     E4Ÿ            : x 2.5
echo     E5ŸˆÈã        : x 3.0
echo     ----------------------------------------------------------
echo+
exit /b

:CRAPS_RULE_CALL1
echo ›CRAPS
echo+
echo   ¥ŠT—v
echo     2ŒÂ‚ÌƒTƒCƒRƒ‚ðU‚èAo–Ú‚â‚»‚Ì‘g‚Ý‡‚í‚¹‚ð—\‘z‚·‚éƒQ[ƒ€‚Å‚·B
echo     ƒxƒbƒg‚ÌŽí—Þ‚É‚æ‚Á‚ÄŸ”sðŒ‚â”z“–‚ªˆÙ‚È‚è‚Ü‚·B
echo+
echo   ¥ƒQ[ƒ€‚Ì—¬‚ê
echo     1. ƒxƒbƒgŽí•Ê‚ð‘I‘ð‚µ‚Ü‚·B
echo     2. ƒxƒbƒg“à—e‚ð‘I‘ð‚µ‚Ü‚·B
echo     3. ƒxƒbƒg“à—e‚ðŠm”FŒãAƒTƒCƒRƒ‚ðU‚è‚Ü‚·B
echo     4. ƒxƒbƒgŽí•Ê‚É‰ž‚¶‚½Ÿ”sðŒ‚É]‚Á‚Ä”»’è‚ðs‚¢‚Ü‚·B
echo        ƒxƒbƒg‚É‚æ‚Á‚Ä‚Í1‰ñ‚ÅŒˆ’…‚·‚é‚à‚Ì‚ÆAŸ”s‚ªŒˆ‚Ü‚é‚Ü‚ÅƒQ[ƒ€‚ª‘±s‚·‚é‚à‚Ì‚ª‚ ‚è‚Ü‚·B
echo     5. Ÿ—˜‚µ‚½ê‡Aƒxƒbƒg“à—e‚É‰ž‚¶‚½”z“–‚ðŠl“¾‚µ‚Ü‚·B
echo+
echo   ¥Ÿ—˜ðŒ
echo     ƒxƒbƒg‚µ‚½“à—e‚ªo–Ú‚ÌŒ‹‰Ê‚ÉŠY“–‚µ‚½ê‡A”z“–‚ðŠl“¾‚Å‚«‚Ü‚·B
echo     ƒxƒbƒgŽí•Ê‚ÍˆÈ‰º‚Ì’Ê‚è‚Å‚·B
echo+
echo     EPass Line   : Å‰‚Ìƒ[ƒ‹‚Å7, 11‚ªo‚½ê‡‚ÍŸ—˜A2, 3, 12‚ªo‚½ê‡‚Í”s–k‚Æ‚È‚è‚Ü‚·B
echo                     ã‹LˆÈŠO‚Ì”Žš‚ªo‚½ê‡‚ÍPoint‚Æ‚È‚èAˆÈ~‚Ìƒ[ƒ‹‚Å7‚æ‚èæ‚ÉPoint‚Æ“¯‚¶”Žš‚ªo‚é‚ÆŸ—˜‚µ‚Ü‚·B

echo     EDon^'t Pass  : Å‰‚Ìƒ[ƒ‹‚Å2, 3‚ªo‚½ê‡‚ÍŸ—˜A7, 11‚ªo‚½ê‡‚Í”s–kA12‚ªo‚½ê‡‚Íˆø‚«•ª‚¯‚Æ‚È‚è‚Ü‚·B
rem '
echo                     ã‹LˆÈŠO‚Ì”Žš‚ªo‚½ê‡‚ÍPoint‚Æ‚È‚èAˆÈ~‚Ìƒ[ƒ‹‚ÅPoint‚æ‚èæ‚É7‚ªo‚é‚ÆŸ—˜‚µ‚Ü‚·B

echo     EPlace Bet   : Žw’è‚µ‚½”Žš‚ª7‚æ‚èæ‚Éo‚é‚ÆŸ—˜‚µ‚Ü‚·B

echo     EField       : ŽŸ‚Ì1‰ñ‚Ìƒ[ƒ‹‚Å‘ÎÛ‚Ì”Žš‚ªo‚é‚ÆŸ—˜‚µ‚Ü‚·B

echo     EProposition : ŽŸ‚Ì1‰ñ‚Ìƒ[ƒ‹‚ÅŽw’è‚µ‚½o–Ú‚ªo‚é‚ÆŸ—˜‚µ‚Ü‚·B

echo     EHard Way    : Žw’è‚µ‚½”Žš‚ðƒ]ƒ–Ú‚Åo‚·‚ÆŸ—˜‚µ‚Ü‚·B
echo+
exit /b


:CRAPS_RULE_CALL2
echo   ¥”z“–
echo+
echo     EŠ|‚¯‹à : 100
echo     ----------------------------------------------------------
echo      ƒxƒbƒgŽí•Ê             •¥–ß”{—¦
echo     ----------------------------------------------------------
echo     EPass Line             : x 2.0
echo     EDon^'t Pass            : x 2.0
rem '
echo     EPlace 4 / 10          : x 2.8
echo     EPlace 5 / 9           : x 2.4
echo     EPlace 6 / 8           : x 2.2
echo     EField                 : x 2.0
echo     EHard 4 / 10           : x 8.0
echo     EHard 6 / 8            : x 10.0
echo     EAny Seven             : x 5.0
echo     EAny Craps             : x 8.0
echo     EYo (11)               : x 16.0
echo     ECraps 2               : x 31.0
echo     ECraps 3               : x 16.0
echo     ECraps 12              : x 31.0
echo     ----------------------------------------------------------
exit /b