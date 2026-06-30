@echo off

cls
rem set Balance=1000
:TOP

rem ========================================================
rem                       変数宣言部
rem ========================================================

rem ★遅延環境展開
	setlocal EnableDelayedExpansion

rem ★カードリストを定義
	set TC[0]=S01
	set TC[1]=S02
	set TC[2]=S03
	set TC[3]=S04
	set TC[4]=S05
	set TC[5]=S06
	set TC[6]=S07
	set TC[7]=S08
	set TC[8]=S09
	set TC[9]=S10
	set TC[10]=S11
	set TC[11]=S12
	set TC[12]=S13
	set TC[13]=H01
	set TC[14]=H02
	set TC[15]=H03
	set TC[16]=H04
	set TC[17]=H05
	set TC[18]=H06
	set TC[19]=H07
	set TC[20]=H08
	set TC[21]=H09
	set TC[22]=H10
	set TC[23]=H11
	set TC[24]=H12
	set TC[25]=H13
	set TC[26]=C01
	set TC[27]=C02
	set TC[28]=C03
	set TC[29]=C04
	set TC[30]=C05
	set TC[31]=C06
	set TC[32]=C07
	set TC[33]=C08
	set TC[34]=C09
	set TC[35]=C10
	set TC[36]=C11
	set TC[37]=C12
	set TC[38]=C13
	set TC[39]=D01
	set TC[40]=D02
	set TC[41]=D03
	set TC[42]=D04
	set TC[43]=D05
	set TC[44]=D06
	set TC[45]=D07
	set TC[46]=D08
	set TC[47]=D09
	set TC[48]=D10
	set TC[49]=D11
	set TC[50]=D12
	set TC[51]=D13


	rem ★掛け金(初期値)
		set BetAmount=100
		
	rem ★カード番号
		set CurrentNum=0
	
	rem ★払い戻し倍率
		set Multiplier=1
	
	rem ★確定利益、未確定利益
		set SecuredPrize=0
		set UnsecuredPrize=0

	rem ★3連勝フラグ
		set ThreeWins=0
	
	rem ★勝利回数
		set WinStreak=0
		
	rem ★倍率表示用
		set Magnification=10
	
	rem ★ゲーム開始前残高を記録
		set PreBalance=!Balance!
		
rem ========================================================
rem                         処理部
rem ========================================================

rem ********************** フェーズ1 **********************
rem                    カードシャッフル
rem *******************************************************


rem ★0~51の番号を格納した配列を定義
	for /l %%i in (0,1,51) do (
	    set IDX[%%i]=%%i
	)

rem ★定義した配列をシャッフルして再定義:Fisher-Yates Shuffle
	for /l %%i in (51,-1,1) do (
	    set /a limit=%%i+1
	set /a R=%RANDOM% %% limit

    call set A=%%IDX[%%i]%%
    call set B=%%IDX[!R!]%%

    set IDX[%%i]=!B!
    set IDX[!R!]=!A!
	)

rem ★シャッフルされた番号のカードを5枚(IDX[0]~IDX[4])選択。
	for /l %%i in (0,1,51) do (
		set /a j=%%i + 1
    	set N=!IDX[%%i]!
    	call set card[%%i]=%%TC[!N!]%%
	)


rem ★テスト用
rem set Card[0]=S01
rem set Card[1]=S02
rem set Card[2]=S03
rem set Card[3]=S04
rem set Card[4]=S05
rem set Card[5]=S06
rem set Card[6]=S07
rem set Card[7]=S08
rem set Card[8]=S09
rem set Card[9]=S10
rem set Card[10]=S11


rem ********************** フェーズ2 **********************
rem                        初期配備
rem *******************************************************



:HIGHLOWLOOP
	if !CurrentNum! geq 51 goto :CASHOUT
	
	rem ★タイトルコール
		call :TITLE_CALL
		set /a Balance-=!BetAmount!
		timeout -t 2 >nul

:INVALID_LOOP
	rem ★掛け金を引いた後のタイトルコール
		cls
		call :TITLE_CALL
		timeout -t 1 >nul
	
	rem ★HiGH/LOW選択を初期化
		set SelectHighLow=9999

	rem ★選択画面
		echo Current Card : !Card[%CurrentNum%]!
		echo+
		echo Will the next card be...
		echo  [1] HIGH
		echo  [2] LOW
		echo+
		set /p SelectHighLow="Choose High or Low ( 1 or 2 ) : "
	
	rem ★入力値チェック
		if %SelectHighLow% equ 1 (
			rem ★そのまま
		) else if %SelectHighLow% equ 2 (
			rem ★そのまま
		) else (
			goto :INVALID_LOOP
		)
	
	rem ★変数のネストを避けるために現在のカードを新しい変数に格納
		for /f "usebackq" %%A in (`call echo %%Card[!CurrentNum!]%%`) do set PreCard=%%A

	rem ★番号が同じだった場合、カード番号の加算と変数格納を再実行するためのループフラグ
	:EVENLOOP
	
	rem ★カード番号を加算
		set /a CurrentNum+=1
		
	rem ★変数のネストを避けるために次のカードを新しい変数に格納
		for /f "usebackq" %%B in (`call echo %%Card[!CurrentNum!]%%`) do set PostCard=%%B

	rem ★演出
		echo+
		cls
		call :TITLE_CALL
		echo Current Card : !PreCard!
		echo+
		echo Revealing the next card...
		timeout -t 2 >nul
		echo+
		echo Next Card : !PostCard!
		echo+
	
	rem ★HIGHにかけていた場合
		if %SelectHighLow% equ 1 (
		
		rem ★LOWだった場合
			if !PreCard:~1! gtr !PostCard:~1! (
				echo WRONG^^!
				echo You lost all unsecured prizes.
			
			rem ★未確定利益をゼロに
				set UnsecuredPrize=0
				timeout -t 2 >nul
				goto :CASHOUT
		
		rem ★HIGHだった場合
			) else if !PreCard:~1! lss !PostCard:~1! (
				echo CORRECT^^!
			
			rem ★勝利回数と倍率計算用変数を加算
				set /a WinStreak+=1
				set /a Multiplier+=1
				if !Multiplier! gtr 6 (
					set Multiplier=6
				)
				set /a Magnification+=5
				if !Magnification! gtr 30 set Magnification=30
				set /a ThreeWins+=1
				set /a UnsecuredPrize+=!BetAmount!*!Multiplier!/2
				
				echo -----------------------------------
				echo Win Streak        : !WinStreak!
				echo Payout Multiplier : x!Magnification:~0,1!.!Magnification:~1,1!
				echo+
				echo Unsecured Prize   : !UnsecuredPrize!
				echo Secured Prize     : !SecuredPrize!
				echo+
				echo Save Progress     : !ThreeWins!/3
				echo -----------------------------------

		rem ★同点だった場合
			) else (
				echo DRAW^^!
				echo+
				echo The cards have the same value.
				echo Drawing another card...
				timeout -t 2 >nul
				goto :EVENLOOP
			)
			
	rem ★LOWにかけていた場合
		) else (
		
		rem ★LOWだった場合
			if !PreCard:~1! gtr !PostCard:~1! (
				echo CORRECT^^!
			
			rem ★勝利回数と倍率計算用変数を加算
				set /a WinStreak+=1
				set /a Multiplier+=1
				if !Multiplier! gtr 6 (
					set Multiplier=6
				)
				set /a Magnification+=5
				if !Magnification! gtr 30 set Magnification=30
				set /a ThreeWins+=1
				set /a UnsecuredPrize+=!BetAmount!*!Multiplier!/2
				
				echo -----------------------------------
				echo Win Streak        : !WinStreak!
				echo Payout Multiplier : x!Magnification:~0,1!.!Magnification:~1,1!
				echo+
				echo Unsecured Prize   : !UnsecuredPrize!
				echo Secured Prize     : !SecuredPrize!
				echo+
				echo Save Progress     : !ThreeWins!/3
				echo -----------------------------------
	
		rem ★HIGHだった場合
			) else if !PreCard:~1! lss !PostCard:~1! (
				echo WRONG^^!
				echo You lost all unsecured prizes.
			
			rem ★未確定利益をゼロに
				set UnsecuredPrize=0
				timeout -t 2 >nul
				goto :CASHOUT
		
		rem ★同点だった場合
			) else (
				echo DRAW^^!
				echo+
				echo The cards have the same value.
				echo Drawing another card...
				timeout -t 2 >nul
				goto :EVENLOOP
			)
		)

	rem ★3連勝した場合
	:Three_Q
		if !ThreeWins! equ 3 (
		pause
		cls
		call :TITLE_CALL
		rem ★利確するかの選択肢を提示
			set SaveAmount=
			set NextBet=
			
			echo SAVE AVAILABLE^^!
			echo+
			echo You have reached a save point.
			echo+
			echo ------------------------------
			echo Current Prize : !UnsecuredPrize!
			set /a NextBet=!BetAmount!*2
			echo Next Bet      : !NextBet!
			echo ------------------------------
			echo+
			echo Do you want to secure your prize?
			echo [Y] Save
			echo [N] Continue
			set /p SaveAmount=""
			echo+


		rem ★小文字[y]
			if "!SaveAmount!"=="y" (
				set /a BetAmount=!BetAmount!*2
				set SecuredPrize=!UnsecuredPrize!
				
				cls
				call :TITLE_CALL
				echo Prize secured^^!
				echo Your bet amount has increased.
				echo New Bet Amount : !BetAmount!
			
		rem ★大文字[Y]
			) else if "!SaveAmount!"=="Y" (
				set /a BetAmount=!BetAmount!*2
				set SecuredPrize=!UnsecuredPrize!

				cls
				call :TITLE_CALL
				echo Prize secured^^!
				echo Your bet amount has increased.
				echo New Bet Amount : !BetAmount!
			
		rem ★小文字[n]
			) else if "!SaveAmount!"=="n" (
				rem ★そのまま続行
			
		rem ★大文字[N]
			) else if "!SaveAmount!"=="N" (
				rem ★そのまま続行

		rem ★その他の文字	
			) else (
				rem ★再質問
				goto :Three_Q
			)
			
		rem ★3連勝フラグをリセット
			set ThreeWins=0
		)

	rem ★続行
	:CNTLOOP
		set Continue=
		echo ------------------------------
		echo Current Prize : !UnsecuredPrize!
		echo Secured Prize : !SecuredPrize!
		echo ------------------------------
		echo+
		echo Do you want to continue?
		echo   [Y] Continue
		echo   [N] Cash Out
		set /p Continue=""
		
		if "!Continue!"=="y" (
			goto :HIGHLOWLOOP
		) else if "!Continue!"=="Y" (
			goto :HIGHLOWLOOP
		) else if "!Continue!"=="n" (
			set SecuredPrize=!UnsecuredPrize!
			goto :CASHOUT
		) else if "!Continue!"=="N" (
			set SecuredPrize=!UnsecuredPrize!
			goto :CASHOUT
		) else (
			goto :CNTLOOP
		)

	rem ★清算
	:CASHOUT
	set /a TotalBet=!PreBalance!-!Balance!
	set /a NetProfit=!SecuredPrize!-!TotalBet!
	set /a Balance+=!SecuredPrize!
	
	:CHECK_RESULT
	set RETRY=
	cls
	call :TITLE_CALL
	echo Cashing out...
	echo ------------------------------
	echo Total Bet   : !TotalBet!
	echo Final Prize : !SecuredPrize!
	if !NetProfit! geq 0 (
		echo Net Profit  : +!NetProfit!
	) else (
		echo Net Profit  : !NetProfit!
	)
	echo Balance     : !Balance!
	echo ------------------------------
	echo+
	if !WinStreak! geq 10 (
		set AchievementFlag[6]=1
	)
	
rem ★再PLAY用選択肢
	
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
rem                       関数定義部
rem ========================================================



:TITLE_CALL
	cls
	echo =====================================
	echo           ★ HIGH / LOW ★ 
	echo =====================================
	echo ------------------------------
	echo Balance : !Balance!
	echo ------------------------------
	echo+
	exit /b


