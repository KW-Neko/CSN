@echo off

cls
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

rem ★現在のカードのカウント
	set CardCount=0
	
rem ★ターンカウント
	set TurnCount=0

rem ★引いたカードの一覧
	set Y_CardLine=
	set D_CardLine=

rem ★引いたカードの合計値の初期値
	set Y_CardSum=0
	set D_CardSum=0


rem ★1を11換算で計算した合計値の初期値
	set Y_AceSum=0
	set D_AceSum=0

rem ★プレイヤーがスタンドしたかの確認フラグ
	set StandFlag=0

rem ★1が出たかの確認フラグ
	set Y_AceFlag=0
	set D_AceFlag=0

rem ★バーストしたかの確認フラグ
	set Y_BustFlag=0
	set D_BustFlag=0

rem ★ブラックジャックフラグ
	set Y_BlackJack=0
	set D_BlackJack=0


rem ========================================================
rem                         処理部
rem ========================================================

rem ********************** フェーズ1 **********************
rem                    カードシャッフル
rem *******************************************************

rem ★タイトルコール
	call :TITLE_CALL
	set /a Balance-=100
	timeout -t 2 >nul
	cls
	call :TITLE_CALL
	timeout -t 1 >nul

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
rem set card[0]=S01
rem set card[2]=S11
rem set card[4]=S05
rem 
rem set card[1]=H02
rem set card[3]=H13
rem set card[5]=H06


rem ********************** フェーズ2 **********************
rem                        初期配備
rem *******************************************************


rem ★2枚を交互にひくために2回繰り返す
	for /l %%i in (0,1,1) do (
	
		call :TITLE_CALL
		echo *************************
		echo       Initial deal
		echo *************************
		echo+
		
	rem ★プレイヤーサイド
		echo ^<^<^<^<^<^<^<^<^< PLAYER SIDE ^>^>^>^>^>^>^>^>^>
		echo+

		rem ★引いたカードをカード一覧に追加(callによる遅延環境変数のネストはsetでは効かないのでechoの結果を取り出す)
			for /f "usebackq" %%A in (`call echo %%card[!CardCount!]%%`) do (
				set Y_CardLine=!Y_CardLine! %%A
				set CurrentCard=%%A

			rem ★カードの合計値を算出(11, 12, 13の場合は10を加算)
				if !CurrentCard:~1! equ 11 (
					set /a Y_CardSum+=10
				) else if !CurrentCard:~1! equ 12 (
					set /a Y_CardSum+=10
				) else if !CurrentCard:~1! equ 13 (
					set /a Y_CardSum+=10
				) else (
			
				rem ★0パディング対応
					if "!CurrentCard:~1,1!"=="0" (
						set /a Y_CardSum+=!CurrentCard:~2!
					) else (
						set /a Y_CardSum+=!CurrentCard:~1!
					)
				)
				
			rem ★引いたカードが1の場合、1か11かを選択できるフラグを立てる
				if "!CurrentCard:~1!"=="01" (
					set /a Y_AceFlag+=1
				)
				
			)

		rem ★現在のカード一覧と合計数を表示
			echo **Player draw a card.
			echo -----------------------------
			call :YOUR_HANDS
			call :YOUR_CARD_SUMS
			echo -----------------------------
			timeout -t 2 >nul


		rem ★カード番号を更新
			set /a CardCount+=1
			echo+
	
	rem ★ディーラーサイド
		echo ^<^<^<^<^<^<^<^<^< DEALER SIDE ^>^>^>^>^>^>^>^>^>
		echo+

		rem ★引いたカードをカード一覧に追加(callによる遅延環境変数のネストはsetでは効かないのでechoの結果を取り出す)
			for /f "usebackq" %%A in (`call echo %%card[!CardCount!]%%`) do (
				set D_CardLine=!D_CardLine! %%A
				set CurrentCard=%%A

			rem ★カードの合計値を算出(11, 12, 13の場合は10を加算)
				if !CurrentCard:~1! equ 11 (
					set /a D_CardSum+=10
				) else if !CurrentCard:~1! equ 12 (
					set /a D_CardSum+=10
				) else if !CurrentCard:~1! equ 13 (
					set /a D_CardSum+=10
				) else (
			
				rem ★0パディング対応
					if "!CurrentCard:~1,1!"=="0" (
						set /a D_CardSum+=!CurrentCard:~2!
					) else (
						set /a D_CardSum+=!CurrentCard:~1!
					)
				)
				
			rem ★引いたカードが1の場合、1か11かを選択できるフラグを立てる
				if "!CurrentCard:~1!"=="01" (
					set /a D_AceFlag+=1
				)
				
			)

		echo **Dealer draws a card.
		echo+
		timeout -t 3 >nul

		rem ★カード番号を更新
			set /a CardCount+=1
			echo+

	)

rem ********************** フェーズ3 **********************
rem                      BLACKJACK判定
rem *******************************************************

rem ★プレイヤー側BLACKJACK判定
	if !Y_AceFlag! equ 1 (
		if !Y_CardSum! equ 11 (
			set Y_BlackJack=1
		)
	)

rem ★ディーラー側BLACKJACK判定
	if !D_AceFlag! equ 1 (
		if !D_CardSum! equ 11 (
			set D_BlackJack=1
		)
	)

rem ★双方のブラックジャックが成立した場合
	if %Y_BlackJack% equ 1 (
		if %D_BlackJack% equ 1 (
			echo *** PLAYER : BLACKJACK^^! ***
			echo *** DEALER : BLACKJACK^^! ***
			timeout -t 2 >nul
			goto :CHECK_RESULT
			
	rem★プレイヤーのみブラックジャックが成立した場合
		) else (
			echo *** PLAYER : BLACKJACK^^! ***
			timeout -t 2 >nul
			goto :CHECK_RESULT
		)

rem ★ディーラーのみブラックジャックが成立した場合
	) else if %D_BlackJack% equ 1 (
		echo *** DEALER : BLACKJACK^^! ***
		timeout -t 2 >nul
		goto :CHECK_RESULT
	)

rem ********************** フェーズ4 **********************
rem                  HIT or STAND(PLAYER SIDE)
rem *******************************************************

rem ★HIT/STANDのループ開始
:HIT_LOOP

	rem ★ターン数をカウント
		set /a TurnCount+=1
	
	rem ★入力不備により再度表示する場合はターンカウントを更新しない
	:ERR_LOOP
	
	rem ★タイトル画面とターンカウントを表示
		cls
		call :TITLE_CALL
		echo *************************
		echo           Turn %TurnCount%
		echo *************************
		echo+

	rem ★プレイヤーサイド
		echo ^<^<^<^<^<^<^<^<^< PLAYER SIDE ^>^>^>^>^>^>^>^>^>
		echo+
		echo -----------------------------
		call :YOUR_HANDS
		call :YOUR_CARD_SUMS
		echo -----------------------------
		
	rem ★プレイヤーがSTANDしていない場合のみHIT/STANDの選択肢を表示
		if "%StandFlag%"=="0" (
			set /p HitOrStand="Hit or Stand ? ( Hit : 1 / Stand : 0 ) :"
		)

	rem ★HITの場合
		if "%HitOrStand%"=="1" (

		rem ★引いたカードをカード一覧に追加(callによる遅延環境変数のネストはsetでは効かないのでechoの結果を取り出す)
			for /f "usebackq" %%A in (`call echo %%card[!CardCount!]%%`) do (
				set Y_CardLine=!Y_CardLine! %%A
				set CurrentCard=%%A

			rem ★カードの合計値を算出(11, 12, 13の場合は10を加算)
				if !CurrentCard:~1! equ 11 (
					set /a Y_CardSum+=10
				) else if !CurrentCard:~1! equ 12 (
					set /a Y_CardSum+=10
				) else if !CurrentCard:~1! equ 13 (
					set /a Y_CardSum+=10
				) else (
			
				rem ★0パディング対応
					if "!CurrentCard:~1,1!"=="0" (
						set /a Y_CardSum+=!CurrentCard:~2!
					) else (
						set /a Y_CardSum+=!CurrentCard:~1!
					)
				)
				
			rem ★引いたカードが1の場合、1か11かを選択できるフラグを立てる
				if "!CurrentCard:~1!"=="01" (
					set /a Y_AceFlag+=1
				)
				
			)

		rem ★現在のカード一覧と合計数を表示
			echo **Player draw a card.
			echo -----------------------------
			call :YOUR_HANDS
			
			rem ★1のカードが1回以上出ているとき
				if !Y_AceFlag! gtr 0 (
					set /a Y_AceSum+=10
				
				rem ★1のカードを11とみなしたときに合計数が21を超えている場合
					if !Y_AceSum! gtr 21 (
						echo   Your total is !Y_CardSum!
			
				rem ★1のカードを11とみなしたときに合計数が21を超えていない場合
					) else (
						echo   Your total is !Y_CardSum! ( or !Y_AceSum! ^)
					)
			
			rem ★1のカードが出ていないとき
				) else (
				 	echo   Your total is !Y_CardSum!
				)
			echo -----------------------------
			timeout -t 2 >nul

		rem ★カード番号を更新
			set /a CardCount+=1
			echo+

		rem ★カードの合計値が21を超えた場合、バースト
			if !Y_CardSum! gtr 21 (
				echo *** You bust. ***
				set Y_BustFlag=1
				timeout -t 2 >nul
				goto :CHECK_RESULT
			)

	rem ★STANDの場合
		) else if "%HitOrStand%"=="0" (
			echo ** Player stnads.
			set StandFlag=1
			
	rem ★それ以外の値が入力された場合
		) else (
			goto :ERR_LOOP
		)
	echo+

rem ********************** フェーズ5 **********************
rem                  HIT or STAND(DEALER SIDE)
rem *******************************************************

	rem ★ディーラーサイド
		echo ^<^<^<^<^<^<^<^<^< DEALER SIDE ^>^>^>^>^>^>^>^>^>
		echo+
		
		rem ★カードの合計値が17以上の場合はSTAND
			if !D_CardSum! gtr 16 (
			
			rem ★プレイヤーもSTANDしている場合、結果画面へ
				if "%StandFlag%"=="1" (
					echo ** Dealer stands.
					timeout -t 2 >nul
					goto :CHECK_RESULT
			
			rem ★プレイヤーがSTANDしていない場合、STANDして次のターンへ
				) else (
					echo ** Dealer stands.
					timeout -t 2 >nul
					echo+
					goto :HIT_LOOP
				)
			)

		rem ★1のカードを11換算した場合の合計値が17以上の場合はSTAND
			if !D_AceSum! gtr 16 (
			
			rem ★プレイヤーもSTANDしている場合、結果画面へ
				if "%StandFlag%"=="1" (
					echo ** Dealer stands.
					timeout -t 2 >nul
					goto :CHECK_RESULT
					
			
			rem ★プレイヤーがSTANDしていない場合、STANDして次のターンへ
				) else (
					echo ** Dealer stands.
					timeout -t 2 >nul
					echo+
					goto :HIT_LOOP
				)
			)

		rem ★16以下の場合
			echo ** Dealer hits.

			rem ★引いたカードをカード一覧に追加(callによる遅延環境変数のネストはsetでは効かないのでechoの結果を取り出す)
				for /f "usebackq" %%A in (`call echo %%card[!CardCount!]%%`) do (
					set D_CardLine=!D_CardLine! %%A
					set CurrentCard=%%A

				rem ★カードの合計値を算出(11, 12, 13の場合は10を加算)
					if !CurrentCard:~1! equ 11 (
						set /a D_CardSum+=10
					) else if !CurrentCard:~1! equ 12 (
						set /a D_CardSum+=10
					) else if !CurrentCard:~1! equ 13 (
						set /a D_CardSum+=10
					) else (
			
					rem ★0パディング対応
						if "!CurrentCard:~1,1!"=="0" (
							set /a D_CardSum+=!CurrentCard:~2!
						) else (
							set /a D_CardSum+=!CurrentCard:~1!
						)
					)
				
				rem ★引いたカードが1の場合、1か11かを選択できるフラグを立てる
					if "!CurrentCard:~1!"=="01" (
						set /a D_AceFlag+=1
					)
				
				)

			echo **Dealer draws a card.
			echo+
			timeout -t 3 >nul

		rem ★カード番号を更新
			set /a CardCount+=1
			echo+

		rem ★1が1回以上出ているとき
			if %D_AceFlag% gtr 0 (
				set /a D_AceSum+=10
			)

		rem ★カードの合計値が21を超えた場合、バースト
			if !D_CardSum! gtr 21 (
				echo *** Dealer busts. ***
				set D_BustFlag=1
				timeout -t 2 >nul
				goto :CHECK_RESULT
			)

		rem ★次のターンへ
			echo+
			goto :HIT_LOOP

rem ********************** フェーズ6 **********************
rem                        結果発表
rem *******************************************************
:CHECK_RESULT
	cls
	call :TITLE_CALL
	echo *************************
	echo           Result
	echo *************************
	echo+

	rem ★1のカードが1回以上出ており、かつ1のカードを11換算したときに合計数が21を超えていない場合、そちらを採択
		if !Y_CardSum! leq !Y_AceSum! (
			if !Y_AceSum! leq 21 (
				set Y_CardSum=!Y_AceSum!
			)
		)

		if !D_CardSum! leq !D_AceSum! (
			if !D_AceSum! leq 21 (
				set D_CardSum=!D_AceSum!
			)
		)

	rem ★カード内容の開示
	echo -----------------------------
		echo   Your hand is:!Y_CardLine!
		echo   Your Total is !Y_CardSum!.
		echo+
		echo   Dealerr hand is:!D_CardLine!
		echo   Dealer Total is !D_CardSum!.
		echo -----------------------------

	rem ★勝敗判定
		rem ★プレイヤーがバーストしている場合
			if "!Y_BustFlag!"==1 (
				echo You bust.
				echo Your rose.
				
		rem ★ディーラーがバーストしている場合
			) else if "!D_BustFlag!"=="1" (
				echo Dealer busts.
				echo Your win.
				set /a Balance+=100
				
		rem ★どちらもバーストしなかった場合
			) else (
		
			rem ★プレイヤーの合計値の方が大きい場合
				if !Y_CardSum! gtr !D_CardSum! (
					echo Your win.
					set /a Balance+=200
					if !Y_BlackJack! equ 1 (
						set /a Balance+=50
					)
			
			rem ★ディーラーの合計値の方が大きい場合
				) else if !Y_CardSum! lss !D_CardSum! (
					echo Your rose.
			
			rem ★プレイヤーとディーラーの合計値が等しい場合
				) else (
					echo draw.
					set /a Balance+=100
				)
			)


pause
echo+
rem ★再PLAY用選択肢
:RTFLAG

	set /p RETRY="Do you want to retry? (y/n) : "
		if "%RETRY%"=="y" (
			cls
			goto :TOP
		) else if "%RETRY%"=="Y" (
			cls
			goto :TOP
		) else if "%RETRY%"=="n" (
			echo BALANCE=!Balance! > .\save\!CallData!
			exit /b
		) else if "%RETRY%"=="N" (
			echo BALANCE=!Balance! > .\save\!CallData!
			exit /b
		) else (
			cls
			goto :CHECK_RESULT
	)


exit /b

rem ========================================================
rem                       関数定義部
rem ========================================================



:TITLE_CALL
	cls
	echo =====================================
	echo           ★ BLACK JACK ★
	echo =====================================
	echo ------------------------------
	echo Balance : !Balance!
	echo ------------------------------
	echo+
	exit /b

:YOUR_HANDS
	echo   Your hand is :%Y_CardLine%
	exit /b

:YOUR_CARD_SUMS
	if "%Y_AceFlag%"=="1" (
		set /a Y_AceSum=%Y_CardSum% + 10
		echo   Your total is %Y_CardSum% ( or !Y_AceSum! ^)
	) else (
		 echo   Your total is %Y_CardSum%
	)
	exit /b