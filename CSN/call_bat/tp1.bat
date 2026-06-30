@echo off

cls
:TOP

rem ========================================================
rem                       変数宣言部
rem ========================================================

rem ★遅延環境展開
	setlocal EnableDelayedExpansion

rem ★変更可能回数のカウント
	set CNGCNT=3

rem ★変更キャンセルフラグ
	set Select0=NO

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

rem ★スートカウント変数を定義
	set Scount=0
	set Hcount=0
	set Ccount=0
	set Dcount=0

rem ★数字カウント変数を定義
	set N01count=0
	set N02count=0
	set N03count=0
	set N04count=0
	set N05count=0
	set N06count=0
	set N07count=0
	set N08count=0
	set N09count=0
	set N10count=0
	set N11count=0
	set N12count=0
	set N13count=0

rem ★フラグと役の初期化
	set FlushFlg=0
	set StraightFlg=0
	set Hand=Buta

rem ========================================================
rem                         処理部
rem ========================================================

rem ********************** フェーズ1 **********************
rem                    カードシャッフル
rem *******************************************************

rem ★タイトルコール
	call :TitleCall
	set /a Balance-=100
	timeout -t 2 >nul
	cls
	call :TitleCall
	call :ChangeCall

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
	for /l %%i in (0,1,4) do (
		set /a j=%%i + 1
    	set N=!IDX[%%i]!
    	call set card[%%i]=%%TC[!N!]%%
    	echo Selected_!j!: !card[%%i]!
	)


rem ★検証用(任意のカードを設定)
rem 	set card[0]=S01
rem 	set card[1]=S12
rem 	set card[2]=S10
rem 	set card[3]=S13
rem 	set card[4]=S11

rem ********************** フェーズ2 **********************
rem                     カード入れ替え1
rem *******************************************************

rem ★1回目
:loop1
echo+
echo+

	rem ★変更選択初期値設定
		set choose1=

	rem ★入れ替えるカードを選択
		echo Select the card number to change.
		set /p choose1="(Select 0 if you do not want to change anything.) (1/3) : "

	rem ★入力内容がnullの時再選択
		if "%choose1%"=="" (
			echo Prease enter a value.
			timeout /t 2 >nul
			cls
			call :AllCall
			goto :loop1
		) else (

		rem ★0,1~5以外の値が入力されたら再選択
				echo(%choose1%|findstr /R "^[0-5]$" >nul
				if errorlevel 1 (
					echo Invalid value. Please enter 0 or 1 to 5.
					timeout /t 2 >nul
					cls
					call :AllCall
					goto :loop1
				) else (
			
			rem ★0以外(かつ1~5)の値が入力された場合
				if "%choose1%" neq "0" (
					set /a choose1=%choose1% - 1
					set card[!choose1!]=!TC[%IDX[5]%]!
					set /a CNGCNT-=1
				) else (
					goto :CHECK_RESULTS
				)
			)
		)

	cls
	call :AllCall



rem ********************** フェーズ3 **********************
rem                     カード入れ替え2
rem *******************************************************

rem ★2回目
:loop2
echo+
echo+
	
	rem ★変更選択初期値設定
		set choose2=

	rem ★入れ替えるカードを選択
		echo Select the card number to change.
		set /p choose2="(Select 0 if you do not want to change anything.) (2/3) : "

	rem ★入力内容がnullの時再選択
		if "%choose2%"=="" (
			echo Prease enter a value.
			timeout /t 2 >nul
			cls
			call :AllCall
			goto :loop2
		) else (

		rem ★0,1~5以外の値が入力されたら再選択
				echo(%choose2%|findstr /R "^[0-5]$" >nul
				if errorlevel 1 (
					echo Invalid value. Please enter 0 or 1 to 5.
					timeout /t 2 >nul
					cls
					call :AllCall
					goto :loop2
				) else (
	
			rem ★0以外(かつ1~5)の値が入力された場合
				if "%choose2%" neq "0" (
					set /a choose2=%choose2% - 1
					set card[!choose2!]=!TC[%IDX[6]%]!
					set /a CNGCNT-=1
				) else (
					goto :CHECK_RESULTS
				)
			)
		)

	cls
	call :AllCall


rem ********************** フェーズ4 **********************
rem                     カード入れ替え3
rem *******************************************************

rem ★3回目
:loop3
echo+
echo+
		
	rem ★変更選択初期値設定
		set choose3=

	rem ★入れ替えるカードを選択
		echo Select the card number to change.
		set /p choose3="(Select 0 if you do not want to change anything.) (3/3) : "
	
	rem ★入力内容がnullの時再選択
		if "%choose3%"=="" (
			echo Prease enter a value.
			timeout /t 2 >nul
			cls
			call :AllCall
			goto :loop3
		) else (
	
		rem ★0,1~5以外の値が入力されたら再選択
				echo(%choose3%|findstr /R "^[0-5]$" >nul
				if errorlevel 1 (
					echo Invalid value. Please enter 0 or 1 to 5.
					timeout /t 2 >nul
					cls
					call :AllCall
					goto :loop3
				) else (
			
			rem ★0以外(かつ1~5)の値が入力された場合
				if "%choose3%" neq "0" (
					set /a choose3=%choose3% - 1
					set card[!choose3!]=!TC[%IDX[7]%]!
					set /a CNGCNT-=1
				) else (
					goto :CHECK_RESULTS
				)
			)
		)

:CHECK_RESULTS
	cls
	call :TitleCall
	call :CardListCall


rem ********************** フェーズ5 **********************
rem                 選択結果の確認・仕分け
rem *******************************************************


rem ★スートと数字をカウント
	for /l %%i in (0,1,4) do (
	
	rem ★スート
		if "!card[%%i]:~,1!"=="S" (
			set /a Scount+=1
		) else if "!card[%%i]:~,1!"=="H" (
			set /a Hcount+=1
		) else if "!card[%%i]:~,1!"=="C" (
			set /a Ccount+=1
		) else if "!card[%%i]:~,1!"=="D" (
			set /a Dcount+=1
		)
	
	rem ★数字
		if "!card[%%i]:~1!"=="01" (
			set /a N01count+=1
		) else if "!card[%%i]:~1!"=="02" (
			set /a N02count+=1
		) else if "!card[%%i]:~1!"=="03" (
			set /a N03count+=1
		) else if "!card[%%i]:~1!"=="04" (
			set /a N04count+=1
		) else if "!card[%%i]:~1!"=="05" (
			set /a N05count+=1
		) else if "!card[%%i]:~1!"=="06" (
			set /a N06count+=1
		) else if "!card[%%i]:~1!"=="07" (
			set /a N07count+=1
		) else if "!card[%%i]:~1!"=="08" (
			set /a N08count+=1
		) else if "!card[%%i]:~1!"=="09" (
			set /a N09count+=1
		) else if "!card[%%i]:~1!"=="10" (
			set /a N10count+=1
		) else if "!card[%%i]:~1!"=="11" (
			set /a N11count+=1
		) else if "!card[%%i]:~1!"=="12" (
			set /a N12count+=1
		) else if "!card[%%i]:~1!"=="13" (
			set /a N13count+=1
		)
	)
	

rem ★数字のカウントを一列に結合(長いから2分割で)
	set NumLine=%N01count%%N02count%%N03count%%N04count%%N05count%%N06count%%N07count%
	set NumLine=%NumLine%%N08count%%N09count%%N10count%%N11count%%N12count%%N13count%

rem ★straight識別用に13の後ろに1を結合した列を定義
	set NumLine_S=%NumLine%%N01count%

rem ★スートのカウントを一列に結合
	set SuitLine=%Scount%%Hcount%%Ccount%%Dcount%


rem ********************** フェーズ6 **********************
rem                        役の判別
rem *******************************************************

rem ★four of a kind識別
	set tmpLine=%NumLine:4=%
	set tmpLen=0

	:LenLoop1
		if defined tmpLine (
			set tmpLine=%tmpLine:~1%
			set /a tmpLen+=1
			goto :LenLoop1
		)
		
		if %tmpLen% neq 13 (
			set Hand=Four_of_a_Kind
			set /a Balance+=2500
		)


rem ★three of a kind識別
	set tmpLine=%NumLine:3=%
	set tmpLen=0

	:LenLoop2
		if defined tmpLine (
			set tmpLine=%tmpLine:~1%
			set /a tmpLen+=1
			goto :LenLoop2
		)
		
		if %tmpLen% neq 13 (
			set Hand=Three_of_a_Kind
			set /a Balance+=300
		)


rem ★two pair識別
	set tmpLine=%NumLine:2=%
	set tmpLen=0

	:LenLoop3
		if defined tmpLine (
			set tmpLine=%tmpLine:~1%
			set /a tmpLen+=1
			goto :LenLoop3
		)
		
		if %tmpLen% equ 11 (
			set Hand=Two_Pair
		) else if %tmpLen% equ 12 (
			rem ★one pair識別
			if not "%Hand%"=="Three_Card" (
				set Hand=One_Pair
				set /a Balance+=50
			rem ★full house識別
			) else (
				set Hand=Full_House
				set /a Balance+=1000
			)
		)


rem ★Flush識別
	set tmpLine=%SuitLine:5=%
	set tmpLen=0

	:LenLoop4
		if defined tmpLine (
			set tmpLine=%tmpLine:~1%
			set /a tmpLen+=1
			goto :LenLoop4
		)
		
		if %tmpLen% neq 4 (
			set Hand=Flush
			set /a Balance+=700
			set FlushFlg=1
			
		)


rem ★straight識別
	set tmpLine=%NumLine_S:11111=%
	set tmpLen=0

	:LenLoop5
		if defined tmpLine (
			set tmpLine=%tmpLine:~1%
			set /a tmpLen+=1
			goto :LenLoop5
		)
		
		if %tmpLen% neq 14 (
			set Hand=Straight
			set /a Balance+=500
			set StraightFlg=1
		)


rem ★straight Flush識別
	if %FlushFlg% equ 1 (
		if %StraightFlg% equ 1 (
			set Hand=Straight_Flush
			set /a Balance+=3800
		)
	)


rem ★loyal straight Flush識別
	if "%NumLine_S:~-5%"=="11111" (
		if %FlushFlg% equ 1 (
			set Hand=Loyal_Straight_Flush
			set /a Balance+=8800
			set AchievementFlag[1]=1
		)
	)

rem ********************** フェーズ7 **********************
rem                  結果の出力と再実行確認
rem *******************************************************

	:RTFLAG
	echo+
	echo *******************************************
	echo   Your Hand is "" %Hand% ""
	echo *******************************************
	echo+
	echo ------------------------------
	echo Balance : !Balance!
	echo ------------------------------
	pause
	echo+
	
	
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
		call :TitleCall
		call :CardListCall
		goto :RTFLAG
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

:AllCall
	call :TitleCall
	call :ChangeCall
	call :CardListCall
	
	exit /b

:TitleCall
	echo =====================================
	echo           ★ POKER GAME ★
	echo =====================================
	echo ------------------------------
	echo Balance : !Balance!
	echo ------------------------------
	exit /b

:ChangeCall
	echo+
	echo You can change your card three times. (%CNGCNT% times left.)
	echo+
	
	exit /b

:CardListCall
	for /l %%i in (0,1,4) do (
		set /a j=%%i + 1
		echo Selected_!j!: !card[%%i]!
	)
	
	exit /b