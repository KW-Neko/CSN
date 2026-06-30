@echo off
:TOP
cls


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

	set P_Third=0
	set B_Third=0
	
	
rem ★勝敗フラグ(PLAYER:1, BANKER:2, TIE:3)
	set WINS=0


rem ========================================================
rem                         処理部
rem ========================================================

rem ********************** フェーズ1 **********************
rem                    カードシャッフル
rem *******************************************************

rem ★タイトルコール
	call :TitleCall
	
	echo ------------------------------
	echo Balance : !Balance!
	echo ------------------------------
	
rem ★掛け金を選択
	set BetAmount=
	set /p BetAmount="Enter your bet amount: "
	if "%BetAmount%"=="" goto :TOP
	if %BetAmount% gtr %Balance% (
		echo Insufficient funds.
		timeout -t 1 >nul
		goto :TOP
	) else (
		set /a Balance-=%betAmount%
	)
	

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

rem ★シャッフルされた番号のカードを6枚(IDX[0]~IDX[5])選択。
	for /l %%i in (0,1,5) do (
		set /a j=%%i + 1
    	set N=!IDX[%%i]!
    	call set card[%%i]=%%TC[!N!]%%
	)


rem ********************** フェーズ2 **********************
rem                     カードの計算
rem *******************************************************

	rem ★プレイヤー側カードとバンカー側カードに振り分け
		set P_Card[1]=!card[0]!
		set P_Card[2]=!card[2]!
		set P_Card[3]=!card[4]!
		set B_Card[1]=!card[1]!
		set B_Card[2]=!card[3]!
		set B_Card[3]=!card[5]!

	rem ★カードから得点を抽出(10以上のカードは10としてカウント)
		for /l %%i in (1,1,3) do (
			if "!P_Card[%%i]:~1,1!"=="0" (
				set P_NUM[%%i]=!P_Card[%%i]:~2!
			) else (
				set P_NUM[%%i]=10
			)
		)
		
	for /l %%i in (1,1,3) do (
		if "!B_Card[%%i]:~1,1!"=="0" (
			set B_NUM[%%i]=!B_Card[%%i]:~2!
		) else (
			set B_NUM[%%i]=10
		)
	)

	rem ★1枚目と2枚目のカードを加算し、1の位の値を抽出、得点とする
		set /a P_Count=!P_NUM[1]! + !P_NUM[2]!
		set /a B_Count=!B_NUM[1]! + !B_NUM[2]!
		set P_Count=!P_Count:~-1!
		set B_Count=!B_Count:~-1!


	rem ★テスト用
	rem 	set P_Count=6
	rem 	set B_Count=6

rem ********************** フェーズ3 **********************
rem                        ベット
rem *******************************************************

	rem ★ベット対象を選択
	:SELECT_BET_SIDE
		set SelectSide=0
		echo Place your bet :
		echo  1. PLAYER
		echo  2. BANKER
		echo  3. TIE
		set /p SelectSide=""

	rem ★1-3が入力された場合
		if %SelectSide% geq 1 (
			if %SelectSide% leq 3 (
				rem ★次の処理へ進む
		
		rem ★1-3以外の値が入力された場合、表示しなおす1(残高はすでに引かれているので掛け金をTmp_Balanceに加算して表示)
			) else (
				cls
				call :TitleCall
				set /a Tmp_Balance=%Balance% + %BetAmount%
				echo ------------------------------
				echo Balance : !Tmp_Balance!
				echo ------------------------------
				echo Enter your bet amount: %BetAmount%
				goto :SELECT_BET_SIDE
			)
	rem ★1-3以外の値が入力された場合、表示しなおす2(残高はすでに引かれているので掛け金をTmp_Balanceに加算して表示)
		) else (
			cls
			call :TitleCall
			set /a Tmp_Balance=%Balance% + %BetAmount%
			echo ------------------------------
			echo Balance : !Tmp_Balance!
			echo ------------------------------
			echo Enter your bet amount: %BetAmount%
			goto :SELECT_BET_SIDE
		)

rem ********************** フェーズ4 **********************
rem                    カードディール描画
rem *******************************************************

	rem ★タイトルとベットサイドを再表示してカードを引く場面を描画1
		cls
		call :TitleCall
		call :BET_SIDE_CALL
		timeout -t 1 >nul

		echo Dealing cards...
		timeout -t 1 >nul
		echo+

		echo+
		echo+
		echo+
		echo+
		echo --------------------
		echo PLAYER
		echo+
		echo                       BANKER
		echo        --------------------
		echo+
		echo+
		echo+
		echo+

	rem ★タイトルとベットサイドを再表示してカードを引く場面を描画2
		timeout -t 1 >nul
		cls
		call :TitleCall
		call :BET_SIDE_CALL
		
		echo Dealing cards...
		echo+

		echo  ┌───┐
		echo  │XXX│
		echo  │XXX│
		echo  └───┘
		echo --------------------
		echo PLAYER
		echo+
		echo                       BANKER
		echo        --------------------
		echo+
		echo+
		echo+
		echo+

	rem ★タイトルとベットサイドを再表示してカードを引く場面を描画3
		timeout -t 1 >nul
		cls
		call :TitleCall
		call :BET_SIDE_CALL
		
		echo Dealing cards...
		echo+
		
		echo  ┌───┐
		echo  │XXX│
		echo  │XXX│
		echo  └───┘
		echo --------------------
		echo PLAYER
		echo+
		echo                       BANKER
		echo        --------------------
		echo                       ┌───┐
		echo                       │XXX│
		echo                       │XXX│
		echo                       └───┘

	rem ★タイトルとベットサイドを再表示してカードを引く場面を描画4
		timeout -t 1 >nul
		cls
		call :TitleCall
		call :BET_SIDE_CALL
		
		echo Dealing cards...
		echo+
		
		echo  ┌───┐┌───┐
		echo  │XXX││XXX│
		echo  │XXX││XXX│
		echo  └───┘└───┘
		echo --------------------
		echo PLAYER
		echo+
		echo                       BANKER
		echo        --------------------
		echo                       ┌───┐
		echo                       │XXX│
		echo                       │XXX│
		echo                       └───┘


	rem ★タイトルとベットサイドを再表示してカードを引く場面を描画5
		timeout -t 1 >nul
		cls
		call :TitleCall
		call :BET_SIDE_CALL
		
		echo Dealing cards...
		echo+
		
		echo  ┌───┐┌───┐
		echo  │XXX││XXX│
		echo  │XXX││XXX│
		echo  └───┘└───┘
		echo --------------------
		echo PLAYER
		echo+
		echo                       BANKER
		echo        --------------------
		echo                  ┌───┐┌───┐
		echo                  │XXX││XXX│
		echo                  │XXX││XXX│
		echo                  └───┘└───┘


rem ********************** フェーズ5 **********************
rem                         判定
rem *******************************************************


	rem ★6以上で同点の場合は引き分け
		if !P_Count! geq 6 (
			if !B_Count! equ !P_Count! (
				rem ★引き分け
					set WINS=3
					goto :SIDE_SECELT
			)
		)

	rem ★プレイヤーが5以下でバンカーが2以下なら双方3枚目を引く
		if !P_Count! leq 5 (
			if !B_Count! leq 2 (
				set P_Third=1
				set B_Third=1
		
		rem ★プレイヤーが5以下でバンカーが2以上7以下ならプレイヤーが3枚目を引く
			) else if !B_Count! leq 7 (
				set P_Third=1
		
			rem ★プレイヤーが5以下でバンカーが3ならバンカーも3枚目を引く
				if !B_Count! equ 3 (
					if not !P_NUM[3]! equ 8 (
					
						set B_Third=1
					)
				)
			
			rem ★プレイヤーが5以下でバンカーが4のとき、プレイヤーの3枚目が2以上7以下ならバンカーも3枚目を引く
				if !B_Count! equ 4 (
					if !P_NUM[3]! geq 2 (
						if !P_NUM[3]! leq 7 (
							set B_Third=1
						)
					)
				)
			
			rem ★プレイヤーが5以下でバンカーが5のとき、プレイヤーの3枚目が4以上7以下ならバンカーも3枚目を引く
				if !B_Count! equ 5 (
					if !P_NUM[3]! geq 4 (
						if !P_NUM[3]! leq 7 (
							set B_Third=1
						)
					)
				)
			
			rem ★プレイヤーが5以下でバンカーが6以上のとき、プレイヤーの3枚目が7以下ならバンカーも3枚目を引く
				if !B_Count! equ 6 (
					if !P_NUM[3]! geq 6 (
						if !P_NUM[3]! leq 7 (
							set B_Third=1
						)
					)
				)
			
			rem ★プレイヤーが5以下でバンカーが8以上ならバンカーの勝ち
			) else (
				rem ★バンカーの勝ち
				set WINS=2
				goto :SIDE_SECELT
			)
		
	rem ★プレイヤーが6以上7以下でバンカーが5以下ならバンカーが3枚目を引く
		) else if !P_Count! leq 7 (
			if !B_Count! leq 5 (
				rem ★バンカーのみ追加
					set B_Third=1
			
		rem ★プレイヤーが7でバンカーが6ならプレイヤーの勝ち(同点は除外済みなので6以上7以下=7確定)
			) else if !B_Count! equ 6 (
				rem ★プレイヤーの勝ち
				set WINS=1
				goto :SIDE_SECELT
			
		rem ★プレイヤーが6でバンカーが7以上ならバンカーの勝ち(同点は除外済みなので6以上7以下=6確定)
			) else (
				rem ★バンカーの勝ち
				set WINS=2
				goto :SIDE_SECELT
			)
	rem ★プレイヤーが8以上でバンカーが7以下ならプレイヤーの勝ち(同点は除外済みなので8以下=7以下確定)
		) else (
			if !B_Count! leq 8 (
				rem ★プレイヤーの勝ち
				set WINS=1
				goto :SIDE_SECELT
		
		rem ★プレイヤーが8でバンカーが9ならプレイヤーの勝ち(同点は除外済みなので8以上=8確定)
			) else (
				rem ★バンカーの勝ち
				set WINS=2
				goto :SIDE_SECELT
			)
		)

rem ********************** フェーズ6 **********************
rem                         3枚目
rem *******************************************************

	rem ★3枚目を引く場合タイトルとベットサイドを再表示してカードを引く場面を描画1

	rem ★プレイヤーが引く場合
		if %P_Third% equ 1 (
			timeout -t 2 >nul
			cls
			call :TitleCall
			call :BET_SIDE_CALL
			
			echo Player draws a third card...
			echo+
			
			echo  ┌───┐┌───┐
			echo  │XXX││XXX│
			echo  │XXX││XXX│
			echo  └───┘└───┘
			echo --------------------
			echo PLAYER
			echo+
			echo                       BANKER
			echo        --------------------
			echo                  ┌───┐┌───┐
			echo                  │XXX││XXX│
			echo                  │XXX││XXX│
			echo                  └───┘└───┘
			
	rem ★3枚目を引く場合タイトルとベットサイドを再表示してカードを引く場面を描画2
			timeout -t 1 >nul
			cls
			call :TitleCall
			call :BET_SIDE_CALL
		
			echo Player draws a third card...
			echo+
		
			echo  ┌───┐┌───┐┌───┐
			echo  │XXX││XXX││XXX│
			echo  │XXX││XXX││XXX│
			echo  └───┘└───┘└───┘
			echo --------------------
			echo PLAYER
			echo+
			echo                       BANKER
			echo        --------------------
			echo                  ┌───┐┌───┐
			echo                  │XXX││XXX│
			echo                  │XXX││XXX│
			echo                  └───┘└───┘

		rem ★バンカーも引く場合
			if %B_Third% equ 1 (
			
			rem ★3枚目を引く場合タイトルとベットサイドを再表示してカードを引く場面を描画3
				timeout -t 2 >nul
				cls
				call :TitleCall
				call :BET_SIDE_CALL
				
				echo Banker draws a third card...
				echo+
				
				echo  ┌───┐┌───┐┌───┐
				echo  │XXX││XXX││XXX│
				echo  │XXX││XXX││XXX│
				echo  └───┘└───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo                  ┌───┐┌───┐
				echo                  │XXX││XXX│
				echo                  │XXX││XXX│
				echo                  └───┘└───┘
				
			rem ★3枚目を引く場合タイトルとベットサイドを再表示してカードを引く場面を描画4
				timeout -t 1 >nul
				cls
				call :TitleCall
				call :BET_SIDE_CALL
				
				echo Banker draws a third card...
				echo+
				
				echo  ┌───┐┌───┐┌───┐
				echo  │XXX││XXX││XXX│
				echo  │XXX││XXX││XXX│
				echo  └───┘└───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo            ┌───┐┌───┐┌───┐
				echo            │XXX││XXX││XXX│
				echo            │XXX││XXX││XXX│
				echo            └───┘└───┘└───┘
			)
	
	rem ★プレイヤーが引かない場合
		) else (
		
		rem ★バンカーが引く場合
			if %B_Third% equ 1 (
			
			rem ★3枚目を引く場合タイトルとベットサイドを再表示してカードを引く場面を描画5
				timeout -t 2 >nul
				cls
				call :TitleCall
				call :BET_SIDE_CALL
				
				echo Banker draws a third card...
				echo+
				
				echo  ┌───┐┌───┐
				echo  │XXX││XXX│
				echo  │XXX││XXX│
				echo  └───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo                  ┌───┐┌───┐
				echo                  │XXX││XXX│
				echo                  │XXX││XXX│
				echo                  └───┘└───┘
				
			rem ★3枚目を引く場合タイトルとベットサイドを再表示してカードを引く場面を描画6
				timeout -t 1 >nul
				cls
				call :TitleCall
				call :BET_SIDE_CALL
		
				echo Banker draws a third card...
				echo+
				
				echo  ┌───┐┌───┐
				echo  │XXX││XXX│
				echo  │XXX││XXX│
				echo  └───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo            ┌───┐┌───┐┌───┐
				echo            │XXX││XXX││XXX│
				echo            │XXX││XXX││XXX│
				echo            └───┘└───┘└───┘
			)
		)

rem ★:SIDE_SECELTに戻ってきたときに再表示する
:SIDE_SECELT
	
	rem ★プレイヤーもバンカーも引く場合
		if %P_Third% equ 1 (
			if %B_Third% equ 1 (
				cls
				call :TitleCall
				call :BET_SIDE_CALL
				
				echo Banker draws a third card...
				echo+
				
				echo  ┌───┐┌───┐┌───┐
				echo  │XXX││XXX││XXX│
				echo  │XXX││XXX││XXX│
				echo  └───┘└───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo            ┌───┐┌───┐┌───┐
				echo            │XXX││XXX││XXX│
				echo            │XXX││XXX││XXX│
				echo            └───┘└───┘└───┘
		rem ★プレイヤーだけ引く場合
			) else (
				cls
				call :TitleCall
				call :BET_SIDE_CALL
				
				echo Player draws a third card...
				echo+
				
				echo  ┌───┐┌───┐┌───┐
				echo  │XXX││XXX││XXX│
				echo  │XXX││XXX││XXX│
				echo  └───┘└───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo                  ┌───┐┌───┐
				echo                  │XXX││XXX│
				echo                  │XXX││XXX│
				echo                  └───┘└───┘
			)
	rem ★バンカーだけ引く場合
		) else (
			if %B_Third% equ 1 (
				cls
				call :TitleCall
				call :BET_SIDE_CALL
				
				echo Banker draws a third card...
				echo+
				
				echo  ┌───┐┌───┐
				echo  │XXX││XXX│
				echo  │XXX││XXX│
				echo  └───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo            ┌───┐┌───┐┌───┐
				echo            │XXX││XXX││XXX│
				echo            │XXX││XXX││XXX│
				echo            └───┘└───┘└───┘
				
		rem ★プレイヤーもバンカーも引かない場合
			) else (
				cls
				call :TitleCall
				call :BET_SIDE_CALL
				
				echo Dealing cards...
				echo+
				
				echo  ┌───┐┌───┐
				echo  │XXX││XXX│
				echo  │XXX││XXX│
				echo  └───┘└───┘
				echo --------------------
				echo PLAYER
				echo+
				echo                       BANKER
				echo        --------------------
				echo                  ┌───┐┌───┐
				echo                  │XXX││XXX│
				echo                  │XXX││XXX│
				echo                  └───┘└───┘
			)
		)


rem ********************** フェーズ7 **********************
rem                     3枚目込みの判定
rem *******************************************************

	rem ★じらす
	:CHECK_RESULT
		timeout -t 3 >nul
		
	rem ★3枚目を引いている場合は得点に加算
		if %P_Third% equ 1 (
			set /a P_Count=!P_NUM[1]! + !P_NUM[2]! + !P_NUM[3]!
			set P_Count=!P_Count:~-1!
		)

		if %B_Third% equ 1 (
			set /a B_Count=!B_NUM[1]! + !B_NUM[2]! +!B_NUM[3]!
			set B_Count=!B_Count:~-1!
		)

	rem ★最終的な得点を比較。
		if !P_Count! gtr !B_Count! (
			set WINS=1
		) else if !P_Count! lss !B_Count! (
			set WINS=2
		) else (
			set WINS=3
		)

	rem ★結果表示
		echo ===========================
		echo        ★ RESULTS ★
		echo ===========================

	rem ★プレイヤー、バンカー双方のカードリストと得点を開示
		if %P_Third% equ 1 (
			echo PLAYERS CARD  : !P_Card[1]! !P_Card[2]! !P_Card[3]!
			echo PLAYERS COUNT : !P_Count!
		) else (
			echo PLAYERS CARD  : !P_Card[1]! !P_Card[2]!
			echo PLAYERS COUNT : !P_Count!
		)
		echo+
		
	
		if %B_Third% equ 1 (
			echo BANKERS CARD  : !B_Card[1]! !B_Card[2]! !B_Card[3]!
			echo BANKERS COUNT : !B_Count!
		) else (
			echo BANKERS CARD  : !B_Card[1]! !B_Card[2]!
			echo BANKERS COUNT : !B_Count!
		)
		echo+

	rem ★賭けた側が勝利した場合
		if %SelectSide% equ %WINS% (
			echo Your WiN.
			
		rem ★引き分けにかけていた場合
			if %WINS% equ 3 (
				set /a Balance+=%BetAmount%*9
				set AchievementFlag[4]=1
		
		rem ★プレイヤー/バンカーに賭けた場合
			) else (
				set /a Balance+=%BetAmount%*2
			)
		) else (
		
		rem ★賭けた側が敗北した場合
			echo Your LOSE.
		)	
		echo+


	rem ★再プレイの確認
	:RETRY_LOOP

		set /p RETRY="Try Again? (y/n) : "
		if "%RETRY%"=="y" (
			goto :TOP
		) else if "%RETRY%"=="Y" (
			goto :TOP
		) else if "%RETRY%"=="n" (
			goto :SAVEEXIT
		) else if "%RETRY%"=="N" (
			goto :SAVEEXIT
		) else (
			goto :RETRY_LOOP
		)

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



:TitleCall
	echo =====================================
	echo            ★ BACCARAT ★
	echo =====================================
	exit /b


:BET_SIDE_CALL
	echo ------------------------------
	if %SelectSide% equ 1 (
		echo Your Bet : 1. PLAYER
	) else if %SelectSide% equ 2 (
		echo Your Bet : 2. BANKER
	) else (
		echo Your Bet : 3. TIE
	)
	echo ------------------------------
	
	exit /b