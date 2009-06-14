/* 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 "なまずIME"
 disp_ime_status.ahk
   IME状態をキャレット付近に表示する。
   詳細は、
   http://www.tierra.ne.jp/~aki/diary/?date=20051204#p01
   を参照してください。

   ver1.02.01   05/12/16
   なまず

 ※このプログラムはなまずの著作物ですが、複製や改変は自由に行っていただいて
   結構です。また、再頒布(公衆送信)や商業利用を含む譲渡も、「なまず」の名前と、
   URL(http://www.tierra.ne.jp/~aki/diary/)を添えていただければ、ご自由に
   していただいて結構です。改変したものを再頒布(公衆送信)や譲渡する場合は、
   改変した旨を表記してください。
 ※このプログラムを利用して生じたいかなる損害に対しても、なまずは責任を負いま
   せん。あしからずご了承ください。

 変更履歴
 
 ver1.02.01   05/12/16
   gridが正しい座標に出ないバグがあり、対応した。

 ver1.02.00   05/12/14
   名前を付けた。
   トレイアイコン等のアプリ名のデフォルトを変更。
   リロード時にメニュー項目が変更できなかったので対処
   表示パラメータframeTypeを追加
   リロードと終了を指定するメッセージを受信できるようにした。

 ver1.01.00   05/12/9
   表示の大きさや色、フォントを変更できるように、表示パラメータを増やした。
   さらに、iniファイルでわかり易いパラメータ指定ができるように、iniファイルの
   値で直接IME状態の評価や表示をするのではなく、内部で使用する値の形に変換して
   から評価や表示をするようにした。そのために、表示パラメータと、条件パラメータ
   のAPIを追加した。

 ver1.00.01   05/12/5
   タイマ起動間隔を500msec以上にしないと、IEの画像のツールチップが出なくなる
   という問題の対処
   単独アプリの場合は、CAR_GetCaretPos()に指示して、常に共有状態を維持し、
   AttachThreadInputを減らして負荷を減らすようにした。
   上記に伴い、クリック時には、CAR_GetCaretPos()にリセットを指示して、
   共有状態を貼りなおすようにした。

 ver1.00.00   05/11/30
   最初のバージョン

 モジュール構成
 
 1.単独アプリ用初期化部
   単独の常駐アプリとして動作させる時のための初期化。クリックのフックや
   タスクトレイアイコンのメニューなど。
   autohotkey.iniに組み込む場合は、スキップされる。
   
 2.デフォルト値管理部
   デフォルト値を管理する。
   本アプリで使用する値は、以下のシステム管理部などの各種管理部で独立して管理
   されるが、それだと、デフォルト値を変更するときに、いちいち対応する管理部の
   定義部を探さなければならず、面倒。
   そこで、デフォルト値管理部では、各種の管理部で管理する値のデフォルト値を持ち、
   簡単にデフォルト値を設定できるようにしている。
   各管理部は、初期化時に、このデフォルト値管理部に、デフォルト値が定義されて
   いるかどうかたずね、定義があったらそれを使い、なかったら、自前でデフォルト値を
   設定する。だから、各管理部が管理する値のすべてのデフォルト値を
   このデフォルト値管理部が持つのではなく、代表的なものだけ持っている。
   
 3.システム管理部
   本アプリの初期化、メインルーチン(タイマハンドラ)、リロード、終了処理、
   システムパラメータの管理等を行う。
   
 4.iniファイル読み出し部
   設定定義用のiniファイルからパラメータを読み出す。
   
 5.条件管理部
   iniファイルを解析して親子関係等を読み出し、管理する。
   IME状態等に応じて条件を満たすセクションを決定し、パラメータ設定をする。
   
 6.表示管理部
   IME状態表示用の表示パラメータの管理と、その表示を行う。
   
 (7.キャレット関係)
   caret.ahkをinclude。
   キャレット座標を取り出す。
   
 (8.iniファイル管理部)
   ini_file.ahkをinclude。
   iniファイルの読み出しと、文法解釈
   
 接頭語
   DMS_
   本ファイルで定義されたグローバル名(関数、ラベル、グローバル変数)は、すべて
   "DMS_"という接頭語を持つ。
   
 グローバル変数
   「5.条件管理部」において、内部関数間の資源共有による効率化、およびラベル
   サブルーチンと引数と戻り値をやりとりするために、グローバル変数を用いている。
   それ以外は一切グローバル変数は使っていない。
   
 依存関係(以下のファイルが必須)
   caret.ahk
   ini_file.ahk
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/


/*
----------------------------------------------------------------------------
  1.単独アプリ用初期化部

   単独の常駐アプリとして動作させる時のための初期化。クリックのフックや
   タスクトレイアイコンのメニューなど。
   autohotkey.iniに組み込む場合は、スキップされる。

----------------------------------------------------------------------------
*/
#Persistent
  ; 初期化
  DMS_Init(true)

  ; 外部アプリからのメッセージを受け取るウインドウの作成
  apiwin_num := DMS_SystemParameters("apiwin_num")
  Gui, %apiwin_num%:+AlwaysOnTop +Disabled +ToolWindow
  Gui, %apiwin_num%:Show,NoActivate,DispIMEstatusApiWindow
  OnMessage(0x5555,"DMS_MessageHandle")

  ; ダブルクリック問題対処用フック
  ; 1.00.01では、ダブルクリック対処用ではなく、クリックで再度Attachして
  ; 正確なキャレット座標を得るため。
  Hotkey, ~LButton, DMS_Click_Sub
  Hotkey, ~RButton, DMS_Click_Sub

  ; トレイアイコンメニュー作成
;  DMS_Menu()
return



/*
------------------------------------------
  7.キャレット関係
------------------------------------------
*/
#include, caret.ahk

/*
------------------------------------------
  8.iniファイル管理部
------------------------------------------
*/
#include, ini_file.ahk


/*
----------------------------------------------------------------------------
  2.デフォルト値管理部

   デフォルト値を管理する。
   本アプリで使用する値は、以下のシステム管理部などの各種管理部で独立して管理
   されるが、それだと、デフォルト値を変更するときに、いちいち対応する管理部の
   定義部を探さなければならず、面倒。
   そこで、デフォルト値管理部では、各種の管理部で管理する値のデフォルト値を持ち、
   簡単にデフォルト値を設定できるようにしている。
   各管理部は、初期化時に、このデフォルト値管理部に、デフォルト値が定義されて
   いるかどうかたずね、定義があったらそれを使い、なかったら、自前でデフォルト
   値を設定する。だから、各管理部が管理する値のすべてのデフォルト値を
   このデフォルト値管理部が持つのではなく、代表的なものだけ持っている。

----------------------------------------------------------------------------
*/

/*
 ...............................................................

  デフォルト値を管理する。
  
  デフォルト値の初期化
  DMS_Default()
    引数:   
      なし
    戻り値: 
      なし
    動作:
      デフォルト値を初期化する
  
  デフォルト値の取り出し
  DMS_Default(paramName)
    引数:
      paramName : パラメータ名
    戻り値: 
      パラメータのデフォルト値
    動作:
      paramNameというパラメータのデフォルト値を取り出す

 ...............................................................
*/  
DMS_Default(method = false)
{
  static ini_file
  static string
  static ofst_x, ofst_y
  static trans
  static grid_x, grid_y
  static time
  static timeAfterClick
  static menu_reload
  static menu_end
  static title
  static gen_max
  static alwaysCaretOn
  static tooltip_num
  static normal
  static color
  static margin_x
  static margin_y
  static fontName
  static fontColor
  static fontSize
  static fontStyle
  static apiwin_num

  
  if(!method)
  {
    ; 引数がなかったので、デフォルト値初期化
    ini_file := "disp_ime_status.ini"
    string := ""
    ofst_x := -18
    ofst_y := -17
    trans  := 0
    grid_x  := 0
    grid_y  := 0
    time  := 500
    timeAfterClick := 300
    menu_reload := "iniファイル再読み込み(&R)"
    menu_end := "終了(&X)"
    title := "なまずIME"
    gen_max := 64
    alwaysCaretOn := ""
    tooltip_num := 19
    normal := 0
    color := ""
    margin_x := 2
    margin_y := 1
    fontName := ""
    fontColor := ""
    fontSize := ""
    fontStyle := ""
    frameStyle := 1
    apiwin_num := 18
    return
  }
  else
  {
    ; デフォルト値読み出し
    ; 未定義のデフォルト値だったら、NULLが帰る
    content := %method%
    return content
  }
}

/*
----------------------------------------------------------------------------
  3.システム管理部

   本アプリの初期化、メインルーチン(タイマハンドラ)、リロード、終了処理、
   システムパラメータの管理等を行う。

----------------------------------------------------------------------------
*/

/*
 ...............................................................................

  本アプリの初期化
  
  DMS_Init()
    引数:
      なし
    戻り値:
      なし
    動作:
      本アプリの初期化。autohotkey.iniから呼ぶときにこのスタイルで呼ぶ
      初期化に失敗した時(iniファイルにエラーがあった)は、単にリターンする。

  DMS_Init(independent)
    引数:   
      independent: trueなら、独立した常駐アプリ。
                   falseなら、他のスクリプトに組み込まれている
    戻り値: 
      なし
    動作:
      本アプリの初期化。初期化に失敗した時(iniファイルにエラーがあった)は、
      independentがtrueなら、本スレッドを停止させる。falseなら、単にリターンする
 ...............................................................................
*/
DMS_Init(independent = false)
{
  ; 終了条件の定義
  DMS_End("init", independent)

  ; デフォルト値の定義
  DMS_Default()
  
  ; システム部デフォルト値設定
  DMS_SystemParameters()
  
  ; 表示部デフォルト値設定
  DMS_DispParameters()

  ; 条件部内部クリア
  DMS_CondParameters()

  ; iniファイルの読み込み
  ini_file := DMS_Default("ini_file")
  if(!DMS_ReadIniFile(ini_file, message))
  {
    DMS_End("end", message)
    return
  }

  ; キャレット座標取得モード設定
  CAR_GetCaretPos(false,dummy,dummy,independent)

  ; タイマ関数設定
  time := DMS_SystemParameters("time")
  SetTimer, DMS_Main, %time%
  return
}

/*
 ...............................................................................

  タイマハンドラ
  DMS_MainFunc()を呼ぶだけ
 ...............................................................................
*/
DMS_Main:
  DMS_MainFunc()
return

/*
 ...............................................................................

  メインルーチン
  
  DMS_MainFunc()
    引数:
      なし
    戻り値:
      なし
    動作:
      タイマハンドラから呼ばれる。
      1. まず、リロードが要請されていたら、リロードする
      2. キャレットが出ているかどうか調べて、出てなかったらなにもせずリターン
      3. キャレットが出ていたら、現在のIME状態等を調べて、表示パラメータを設定
      4. 表示を行う
 ...............................................................................
*/

DMS_MainFunc()
{
  ; リロードが要請されていたら、リロード。失敗したら、リターン
  if(!DMS_Reload_main())
    return

  ; 次回のこの関数のタイマ設定を行う
  ; リロードで、タイマ間隔が変わったかもしれないし、timeAfterClickで
  ; タイマ間隔が変更されているかもしれないから。
  time := DMS_SystemParameters("time")
  SetTimer, DMS_Main, %time%


  ; とりあえず、アクティブウインドウを確認
  WinGet, actwin, ID, A
  if(!actwin)
  {
    ; アクティブウインドウがなかったら、キャレットが出てるわけない。
    ; 表示を消してリターン
    DMS_DispIMEsts(false)
    return
  }

  ; キャレットが出ているか確認
  alwaysCaretOn := DMS_SystemParameters("alwaysCaretOn")
  if(!CAR_GetCaretPos(actwin,  car_x,car_y, alwaysCaretOn))
  {
    ; キャレットが出てなければ表示を消してリターン
    DMS_DispIMEsts(false)
    return
  }

  ; パラメータ取得
  if(!DMS_SelectParameters(actwin, car_x, car_y))
  {
    DMS_DispIMEsts(false)
    return
  }

  ; IME状態表示
  DMS_DispIMEsts(true)

  return
}

/*
 ...............................................................................

  リロードの設定
  
  DMS_Reload()
    引数:
      なし
    戻り値:
      なし
    動作:
      リロード予約をする。そして、DMS_Mainをすぐ起動させる。
      実際のリロードはDMS_MainFuncの中で行わせる。現在処理中のパラメータが
      リロードによって変更されてしまっては、予期せぬバグを引き起こすから。
      だからここでは、予約だけしてリターンする。
 ...............................................................................
*/
DMS_Reload()
{
  ; リロード予約
  DMS_Reload_main(true)
  ; タイマハンドラをすぐ起動
  SetTimer, DMS_Main, 0
}

/*
 ...............................................................................

  リロード処理と予約
  
  リロード処理
  DMS_Reload_main()
    引数:
      なし
    戻り値:
      なし
    動作:
      リロード処理が入っていたら、リロードする。
      入ってなかったら、なにもせずリターンする。
      
  リロード予約
  DMS_Reload_main(true)
    引数:
      常にtrue
    戻り値:
      なし
    動作:
      リロード予約を入れ、リターンする。次回、DMS_Reload_main()がコールされたら、
      リロードが行われる。
 ...............................................................................
*/

DMS_Reload_main(reloadSignal = false)
{
  static reloadFlag

  ; 引数がtrueかどうかチェック。trueなら予約のみ
  if(reloadSignal)
  {
    ; 予約してリターン
    reloadFlag := true
    return
  }
  
  ; 予約が入ってなかったら、なにもせずリターン
  if(!reloadFlag)
    return true

  reloadFlag := false

  ; iniファイルのリロード
  ; システムパラメータの変更があるかもしれないので、システム関連の初期化は
  ; 同時に行う
  ; また、reload時は、iniファイルの記述にエラーがあっても、終了せずに、そのままに
  ; する。

  ; 終了条件の定義
  DMS_End("init", false)
  
  ; システム部デフォルト値設定
  DMS_SystemParameters()

  ; iniファイルの読み込み
  ini_file := DMS_Default("ini_file")
  if(!DMS_ReadIniFile(ini_file, message))
  {
    DMS_End("end", message)
    return false
  }

  ; メニューの再作成
  DMS_Menu()
  return true
}

/*
 ...............................................................................

  クリックフック用ハンドラ
  DMS_Click()を呼ぶだけ
 ...............................................................................
*/
DMS_Click_Sub:
  DMS_Click()
return

/*
 ...............................................................................

  クリックフックから呼ばれる処理
  
  DMS_Click()
    引数:
      なし
    戻り値:
      なし
    動作:
      DMS_Mainの起動を、timeAfterClickの時間だけ、後に設定する。
 ...............................................................................
*/
DMS_Click()
{
  ; clickで、いちど入力共有をデタッチする。そうしないと反映されないキャレット
  ; 座標がある。
  CAR_GetCaretPos(false,dummy,dummy,"",true)

  time := DMS_SystemParameters("timeAfterClick")
  SetTimer, DMS_Main, %time%
  return
}

/*
 ...............................................................................

  タスクトレイアイコンの右クリックメニュー作成
  
  DMS_Menu()
    引数:
      なし
    戻り値:
      なし
    動作:
      メニューの作成。メニュー項目が選択されたら、すべてDMS_MenuHandleに飛ぶ
 ...............................................................................
*/
DMS_Menu()
{
  ; 表示する文字列の取り出し
  reload := DMS_SystemParameters("menu_reload")
  end    := DMS_SystemParameters("menu_end")
  tip    := DMS_SystemParameters("title")

  ; メニューの作成
  Menu, TRAY, DeleteAll
  Menu, TRAY, NoStandard
  Menu, TRAY, Add, %reload%, DMS_MenuHandle
  Menu, TRAY, Add
  Menu, TRAY, Add, %end%, DMS_MenuHandle
  Menu, TRAY, Tip, %tip%
  return
}

/*
 ...............................................................................

  タクストレイアイコンのメニューが選択されたときの処理
  
    動作:
      メニュー項目の1が選択されたらリロード、3が選択されたらアプリを終了する。
 ...............................................................................
*/
DMS_MenuHandle:
  if(A_ThisMenuItemPos == 1)
  {
    DMS_Reload()
  }
  else
  if(A_ThisMenuItemPos == 3)
    ExitApp
return

/*
 ...............................................................................

  メッセージを送られたときの処理

  DMS_MessageHandle(wParam)
    引数:
      wParam: 動作を規定
              0 : リロード
              1 : 終了
    戻り値:
      なし
    動作:
      メッセージハンドラの定義は、初期化部で行っている。
      0x5555のメッセージを受け取ると、上記の動作を行う。
 ...............................................................................
*/
DMS_MessageHandle(wParam)
{
  if(wParam == 0)
    DMS_Reload()
  else
  if(wParam == 1)
    ExitApp
}

/*
 ...............................................................................

  終了処理
  
  DMS_End(method,param)
    引数:
      method: 動作を規定
              "init" : 初期化
              "end"  : 終了処理
      param:  "init"のときは、単独アプリなら、true,組み込みなら、false
              "end"のときは、終了時に出力するメッセージ
    戻り値:
      なし
    動作:
      "init"の場合は、paramの値を格納するだけでリターン
      "end"の場合は、paramの値をメッセージ出力し、単独アプリなら、
      アプリを終了させ、組み込みなら、タイマハンドラをOffにした後、リターンする。
 ...............................................................................
*/
DMS_End(method, param)
{
  static independent
  
  if(method == "init")
  {
    ; 初期化
    
    independent := param
  }
  else
  if(method == "end")
  {
    ; 終了処理
    
    
    if(param)
    {
      ; メッセージがあったら、ここで出力
      title := DMS_SystemParameters("title")
      MsgBox, 16,%title%, %param%
    }
    
    ; タイマハンドラオフ
    SetTimer, DMS_Main, Off
    
    ; 単独常駐アプリなら、アプリを終了する。
    if(independent)
      ExitApp
  }
}

/*
 ...............................................................................

  システムパラメータの管理
  
  デフォルト値設定
  DMS_SystemParameters()
    引数:
      なし
    戻り値:
      なし
    動作:
      システムパラメータを、すべてデフォルト値に設定する。

  パラメータ読み出し
  DMS_SystemParameters(paramName)
    引数:
      paramName: システムパラメータの名前
    戻り値:
      paramNmaeのシステムパラメータの値
    動作:
      paramNmaeのシステムパラメータの値を取り出す。
  
  パラメータ設定
  DMS_SystemParameters(paramName, paramVal, true)
    引数:
      paramName: システムパラメータの名前
      paramVal:  設定しようとする値
      true:      常にtrue
    戻り値:
      なし
    動作:
      paramNmaeのシステムパラメータに、値を設定する。
  
  パラメータ名のサポート確認
  DMS_SystemParameters(false, paramName)
    引数:
      false:     常にfalse
      paramName: 確認するパラメータ名
    戻り値:
      paramNameで指定されたパラメータ名が、本関数内で管理しているものならtrue、
      そうでなければfalse
    動作:
      paramNameで指定されたパラメータ名が、本関数内で管理しているものならtrue、
      そうでなければfalseを返す。
      
  パラメータの設定値確認
  DMS_SystemParameters(false, paramName, paramVal, true)
    引数:
      false:     常にfalse
      paramName: 確認するパラメータ名
      paramName: 確認するパラメータ値
      true:      常にtrue
    戻り値:
      paramNameで指定されたパラメータ名が、paramValで指定された値が設定できる
      ならNULL、そうでなければ、設定できない旨を示す文字列。
    動作:
      paramNameで指定されたパラメータ名が、paramValで指定された値が設定できる
      ならNULL、そうでなければ、設定できない旨を示す文字列を返す。
 ...............................................................................
*/
DMS_SystemParameters(val = false, param1=false, param2=false, param3=false)
{
  static time
  static timeAfterClick
  static menu_reload
  static menu_end
  static title
  static gen_max
  static alwaysCaretOn
  static tooltip_num
  static apiwin_num
  
  if(val)
  {
    ; 第１引数(パラメータ名)が指定されている

    if(param2)
    {
      ; 第３引数がtrueなので、第２引数は、設定しようとする値
      %val% := param1
      return
    }
    ; 第３引数がfalse(指定されてない)ので、値の読み出し
    content := %val%
    return content
  }
  else
  if(param1)
  {
    ; 第２引数がtrue
  
    if(param3)
    {
      ; 第４引数がtrue
      ; 設定できる値かどうかチェック
    
      if((param1 == "time" || param1 == "timeAfterClick") && param2 < 0)
        return "システムパラメータ[" . param1 . "]は、[" . param2 . "]という値は設定できません。設定できる値は、0以上です。"
      else
        return ""
    }

    ; 第２引数で指定されたパラメータをサポートしているかチェック
    check := ";time;timeAfterClick;menu_reload;menu_end;title;gen_max;alwaysCaretOn;tooltip_num;"
    IfInString, check, `;%param1%`;
      return true
    else
      return false
  }
  else
  {
    ; 第１、第２引数ともfalse
    ; デフォルト値の設定
    ; デフォルト値管理部に、デフォルト値が設定されているかたずね、設定されて
    ; なかったら、ここでデフォルト値を設定
  
    time            := DMS_Default("time")
    if(!time)
      time := 500

    timeAfterClick := DMS_Default("timeAfterClick")
    if(!timeAfterClick)
      timeAfterClick := 300

    menu_reload := DMS_Default("menu_reload")
    if(menu_reload == "")
      menu_reload := "iniファイル再読み込み(&R)"

    menu_end := DMS_Default("menu_end")
    if(menu_end == "")
      menu_end := "終了(&X)"

    title := DMS_Default("title")
    if(title == "")
      title := "なまずIME"

    gen_max := DMS_Default("gen_max")
    if(gen_max == "")
      gen_max := 64

    alwaysCaretOn := DMS_Default("alwaysCaretOn")
    if(alwaysCaretOn == "")
      alwaysCaretOn := ""

    tooltip_num := DMS_Default("tooltip_num")
    if(tooltip_num == "")
      tooltip_num := 19

    apiwin_num := DMS_Default("apiwin_num")
    if(apiwin_num == "")
      apiwin_num := 18

    return
  }
}

/*
----------------------------------------------------------------------------
 4.iniファイル読み出し部

   設定定義用のiniファイルからパラメータを読み出す。

----------------------------------------------------------------------------
*/

/*
 ...............................................................................

  iniファイルを読み出す
  
  DMS_ReadIniFile(ini_file, ByRef message)
    引数:
      ini_file:   iniファイルのファイル名
      message:    iniファイルにエラーがあったとき、エラー理由のメッセージが入る
    戻り値:
      trueなら、iniファイルの読み込み正常終了。falseなら、iniファイルにエラー
      があり、正常終了ではない。
    動作:
      一旦、すべてiniファイルから読み出した後に、システムパラメータのチェックと
      値の設定。
      その後、ParamBlock()をコールし、パラメータセクションの処理をする。
 ...............................................................................
*/
DMS_ReadIniFile(ini_file, ByRef message)
{
  ; とりあえず、ファイルからini情報を読み出す
  if(!INI_ReadIniFile(ini_file, raw_ini, message,true,false))
    return false
    
  ; まず、systemパラメータを取り出す
  parse_ini := raw_ini
  Loop
  {
    ; 1エントリごとに、値を取り出す。
    if(!INI_ParseIni(parse_ini, section, entryName, entryVal))
      break

    if(entryName == "")
      continue
      
    if(section == "system")
    {
      ; システムセクションだった。
      
      ; システムパラメータとして、サポートしているパラメータ名か？
      if(!DMS_SystemParameters(false, entryName))
      {
        message := "システムパラメータで、[" . entryName . "]というパラメータはサポートしてません。"
        return false
      }
      
      ; システムパラメータとして、設定可能な値か？
      message := DMS_SystemParameters(false, entryName, entryVal, true)
      if(message)
        return false
        
      ; システムパラメータ設定
      DMS_SystemParameters(entryName, entryVal, true)
    }
  }
  
  ; 次に、パラメータセクション(パラメータブロック)の処理
  message := DMS_ParamBlock(raw_ini)
  if(message)
    return false
    
  return true
}

/*
----------------------------------------------------------------------------
 5.条件管理部

   iniファイルを解析して親子関係等を読み出し、管理する。
   IME状態等に応じて条件を満たすセクションを決定し、パラメータ設定をする。

----------------------------------------------------------------------------
*/

/*
 ...............................................................................

  パラメータブロック(パラメータセクションを内部処理向けにまとめたもの)の
  作成と管理
  
  パラメータブロック取り出し
  DMS_ParamBlock()
    引数:
      なし
    戻り値:
      パラメータブロック全体
    動作:
      パラメータブロック全体を返す。以下のフォーマットを持つ。
      
      paramBlocks := blocks `b1b blocks `b1b blocks
       (`bとb(blother)で囲まれた世代番号によって、同じ世代のブロックが
        分割される)
        
      blocks := 親block `b1c 子blocks
       ( `bとc(child)で囲まれた世代番号によって、親と子が分割される)

      block  := 条件名1`a条件1`v条件名2`a条件2`n表示名1`a表示1`v表示名2`a表示2
       (`nによって、条件部と表示部が分かれる。
        条件部と表示部とも、個々のパラメータは`vで分割される。
        また、パラメータの名前と値は`aで分割される)

  パラメータブロック作成(一番最初)
  DMS_ParamBlock(raw_ini)
    引数:
      raw_ini:  iniファイルを一つの文字列にまとめたもの。
                INI_ReadIniFileからの出力
    戻り値:
      raw_iniにエラーがあった場合は、エラー理由を表す文字列
      エラーがなければNULL
    動作:
      raw_iniのパラメータセクションを解析し、評価をしやすい形にまとめた
      パラメータブロックを作成し、内部に保持する。DMS_ParamBlock()で取り出せる。
  
  パラメータブロック作成(再起呼び出しでコールされたとき)
  DMS_ParamBlock(false, parent, genCon, notErase, familyList)
    引数:
      false:     常にfalse
      parent:    この再起呼び出しの対象となる親セクション名
                 このセクション名を親とするセクションの処理を行う
      genCon:    世代番号。親がNULL(parentパラメータがない)のセクションは0。
                 その子は1、孫は2...
      notErase:  処理したセクションは、内部のraw_ini(parse_ini)から削除するが、
                 notEraseがtrueの場合は、削除しない。
                 親を二人以上持つ子の孫(ひ孫、やしゃご...)の処理の場合、notErase
                 をtrueにする。
      familyList:家計図。先祖代々のセクション名が'vで区切られて送られる。

    戻り値:
      raw_iniにエラーがあった場合は、エラー理由を表す文字列
      エラーがなければNULL
    動作:
      内部のparse_ini(最初はraw_ini)のパラメータセクションを解析し、
      評価をしやすい形にまとめたパラメータブロックを作成し、内部に保持する


 パラメータブロック作成の内部動作説明

 本関数は、下記の４つの機能を持つ
 1)指定された親を持つ(parentパラメータで指定された親が、引数で与えられた親と
   同じ)子を見つける。
 2)見つけた子の条件パラメータと表示パラメータを取り出し、paramBlocksに記録する。
   paramBlocksには、親→子→孫の順番で並ぶようにする。
 3)子パラメータの子(孫)を探すため、再起呼び出しする
 4)処理済の子セクションを削除する。

 4)の処理済とは、下記の二つの条件を満たすものである。
   A)親が、複数の親(おじいちゃん)を持っていない→notEraseがfalse
   B)親は今回指定された親一人だけ
 そうでなければ、処理済とはならず、3)で孫を探しにいくときも、notEraseをtrueに
 して再起呼び出しする必要がある。

 まず、1)と4)を行う。
 静的変数"parse_ini"をパースして、指定した親を持つ子を
 発見する。その際に、その子の名前と、その子が持つパラメータと、その子が処理済か
 どうかを記録するリストをつくる。
 また、その子が処理済になるのなら、parse_iniから、その子のセクションを消去する。
 と、いっても、ピンポイントで消去するのは大変なので、parse_iniをパース
 していく際に、処理済でないセクションを保存しておき(remain_ini)、それを最後に
 parse_iniとすることで、消去したことにする。
 また、親子無限ループを避けるために、家系リストを送り、発見された子が親で
 なかったかどうかチェックする。
 
 次に、2)と3)を行う。
 子の名前とパラメータのリストをパースする。
 パラメータをparamBlocksに記録し、さらに、子の名前の親を持つ子(孫)を探しに、
 再起呼び出しする。再起呼び出しのときに、処理済かそうでないかで、notEraseを
 変更する。さらに、家系リストに子の名前を追加して、再起呼び出しする。
 孫が発見されれば、paramBlocksには孫のパラメータが追加される。また、処理済と
 なれば、parse_iniはその分短くなる。

 もし、一番上の呼び出し(指定した親がヌル)だった場合は、parse_iniに最後に
 残ったセクションは、最後まで処理できなかった、つまり、親が存在しなかった、
 エラーセクションということになる。
 
 処理が終わったセクションを、parse_iniからどんどん減らしていくことで、
 再起呼び出ししてパースしなければならないセクションの数が減っていくので、
 全体の処理速度向上につながる。また、処理できなかったセクションを後でチェック
 することで、親が存在しないセクションのチェックを、特別なパースをすることなく、
 検出できる。これまた、処理速度向上に繋がる。
 
 当初のバージョンは、もっと単純なアルゴリズムでやっていたが、再起呼び出しに
 よるパースが階乗的に増えてしまい、シャレにならないほど重かったので、上記の
 ように書き換えた。ややこしいけれど、こらえてください。

 ...............................................................................
*/
DMS_ParamBlock(raw_ini = false, parent = "", genCon = 0, notErase = false, familyList = "")
{
  static paramBlocks
  static parse_ini

  ; DMS_ParamBlock()でコールされているなら、パラメータブロックを返す
  if(!raw_ini && !parent)
    return paramBlocks

  ; 親がNULL、つまり、一番最初のコールなので、paramBlockを初期化
  if(!parent)
    paramBlocks := ""
  
  ; raw_iniがNULLではないので、内部のparse_iniをraw_iniに保存
  if(raw_ini)
    parse_ini := raw_ini

  ; 家計図がNULLなら、最初の'vをいれておく。
  ; 上記のみっつのifは、すべて同じタイミングだが、念のために分けている
  if(familyList == "")
    familyList := "`v"

  ; AutoHotkeyの再起呼び出しに制限があるかもしれないので、
  ; 世代が深くなりすぎならないように制限する。
  if(genCon > DMS_SystemParameters("gen_max"))
    return "設定できる世代数は" . DMS_SystemParameters("gen_max") . "世代までです。[" . parent . "]"

  parent_num  := 0
  found := false
  section_in := false
  this_ini := ""
  remain_ini := ""
  childList := ""
  Loop
  {
    ; iniファイルから、1エントリ取り出す
    if(!INI_ParseIni(parse_ini, section, entryName, entryVal))
      break
      
    ; システムセクションではないか？
    if(section != "system")
    {
      ; このセクションになって初めてのエントリだったら、保存用ini(this_ini)に
      ; セクション名を保存
      if(!section_in)
        INI_AddIni(this_ini, section, "")
        
      section_in := true

      ; エントリ名があるか(なかったら、このセクションの最後)
      if(entryName)
      {
        ; 親パラメータか？
        if(entryName == "parent")
        {
          ; 親の個数カウントアップ
          parent_num++

          if(section == entryVal)
            return "自分自身を親にすることはできません。[" . section . "]"

          if(parent == entryVal)
          {
            ; 指定された親を持つ子を見つけた
            found := true
            ; notEraseでなければ、親パラメータを消去する
            if(notErase)
              INI_AddIni(this_ini, "", entryName, entryVal)
          }
          else
            INI_AddIni(this_ini, "", entryName, entryVal)
        }
        else
        {
          ; 親パラメータ以外
          ; とりあえず、this_iniに入れておく
          INI_AddIni(this_ini, "", entryName, entryVal)
        }
      }
      else
      {
        ; 本セクションの終わり
        section_in := false
        
        ; このパラメータブロックは、指定の親を持つ子ブロックだったか
        if(found || (parent_num == 0 && parent == ""))
        {
          ; まず、この子が、既に親だったことはないか(親子無限ループ)をチェック
          IfInString, familyList, `v%section%`v
            return "親子無限ループです。[" . parent . "," . section . "]"

          ; この子ブロックは、"未処理"かどうか
          ; "処理済"とは、notEraseが真でなく、親は一人だけ(あるいは0)の場合のみ
          if(!notErase && parent_num <= 1)
            notProcessed := false
          else
            notProcessed := true
            
          ; remain_ini書き換え
          ; このセクションが処理済みなら、remain_iniに加えない
          if(notProcessed)
            remain_ini := remain_ini . this_ini . "`n"

          condpar := ""
          disppar := ""
          ; このセクションのパラメータを取り出す
          Loop
          {
            if(!INI_ParseIni(this_ini, section, entryName, entryVal))
              break
      
            if(entryName == "")
              break ; 本当はすべてここで抜けてしまう。だから上記のifは意味がない

            if(entryName == "parent")
              Continue
    
            ; 条件パラメータか？
            if(DMS_CondParameters(false, false, entryName))
            {
              ; NULL文字列は指定できない
              if(entryVal == "")
                return "条件パラメータでは、NULL文字列は指定できません。[" . section . "," . entryName . "]"

              ; パラメータの値のチェック
              message := DMS_CondParameters(false, false, entryName, entryVal)
              if(message)
                return message
            
              ; パラメータの値の変換
              entryVal := DMS_CondParameters(false, false, entryName, entryVal,2)

              ; 条件パラメータの保存
              condpar := condpar . entryName . "`a" . entryVal .  "`v"
            }
            else ; 表示パラメータか？
            if(DMS_DispParameters(false, false, entryName))
            {
              ; パラメータの値のチェック
              message := DMS_DispParameters(false,false, entryName, entryVal,1)
              if(message)
                return message

              ; パラメータの値の変換
              entryVal := DMS_DispParameters(false, false, entryName, entryVal,2) 

              ; 表示パラメータの保存
              disppar := disppar . entryName . "`a" . entryVal .  "`v"
            }
            else ; 不明なパラメータ
              return "不明なパラメータです。[" . section . "," . entryName . "]"
          }
          ; 子リスト作成
          ; 子リスト = 子 `b 子 `b 子 `b...
          ; 子       = 名前 `f パラメータ `f 処理済フラグ
          childList := childList . section . "`f" . condpar . "`n" . disppar . "`f" . notProcessed . "`b"

        }
        else
        {
          ; 指定した親を持つセクションではなかった。つまり、未処理セクションで
          ; ある。remain_iniに加える
          remain_ini := remain_ini . this_ini . "`n"
        }
        
        ; 本セクションの情報をクリアする
        parent_num := 0
        found := false
        this_ini := ""
      }
    }
  }
  
  ; 処理済みブロックを消去したリストを、parse_iniに設定する
  parse_ini := remain_ini

  ; childListをパースして、パラメータの設定と、孫探しをする
  Loop, parse, childList , `b
  {
    if(!A_LoopField)
      Continue
      
    ; 子の名前と、パラメータと、処理済フラグを分離
    StringSplit, ch, A_LoopField , `f
    child := ch1
    param := ch2
    notProcessed := ch3

    ; パラメータの設定
    paramBlocks := paramBlocks . param . "`b" . genCon . "c"

    ; 孫探し(再帰呼び出し)
    message := DMS_ParamBlock("", child, genCon + 1, notProcessed, familyList . child . "`v")
    if(message)
      return message
   
    ; 次の追加のために
    paramBlocks := paramBlocks . "`b" . genCon . "b"
  }

  if(parent == "")
  {
    ; parentがヌルということは、一番頭のコールである。この時点で、
    ; parse_iniがヌルじゃないということは、親指定が解決されていない
    ; セクションがあるということ。エラーでリターンする。
    ; 実は親が存在しても、親の親指定が失敗していて、最後まで残っている
    ; ことも考えられる。そこで、本当に存在しない親指定をチェックする。
    check_ini := parse_ini
    Loop
    {
      if(!INI_ParseIni(check_ini, section, entryName, entryVal))
        break
      
      if(entryName == "parent")
      {
        check2_ini := parse_ini
        found := false
        Loop
        {
          if(!INI_ParseIni(check2_ini, tmp_sec, tmp_nme, tmp_val))
            break
            
          if(tmp_nme == "" && entryVal == tmp_sec)
          {
            found := true
            break
          }
        }
        
        if(!found)
          return "存在しない親セクションが指定されています。[" . section . "," . entryVal . "]"
      }
    }
  }
  
  return ""
}

/*
 ...............................................................................

  IME等の状態を調べて、パラメータセクションを選択し、表示パラメータを設定する
  
  DMS_SelectParameters(actwin, car_x, car_y)
    引数:
      actwin:   現在アクティブなウインドウのID
      car_x:    キャレットのx座標(スクリーン座標系)
      car_y:    キャレットのy座標(スクリーン座標系)
    戻り値:
      trueなら、条件にマッチしたパラメータセクションがあった。
      falseなら、一つも条件にマッチしたパラメータセクションがなかった。
    動作:
      ようするにDMS_SelectParamBlockをコールする。
 ...............................................................................
*/
DMS_SelectParameters(actwin, car_x, car_y)
{
  ; パラメータブロックのリストを取得
  paramBlocks := DMS_ParamBlock()
  
  ; 条件パラメータ選択初期化
  DMS_InitCondParameters(actwin, car_x, car_y)

  ; 表示パラメータ初期化
  DMS_InitDispParameters(actwin, car_x, car_y)
  
  ; パラメータ選択
  return DMS_SelectParamBlock(paramBlocks, 0)
}


/*
 ...............................................................................

  条件を満たすパラメータセクション(をまとめたパラメータブロック)を選択し、
  その中の表示パラメータを、DMS_DispParameters()に設定する。
  
  DMS_SelectParamBlock(paramBlocks, genCon)
    引数:
      paramBlocks:  パラメータブロック。下記のフォーマットを持つ

      paramBlocks := blocks `b1b blocks `b1b blocks
       (`bとb(blother)で囲まれた世代番号によって、同じ世代のブロックが
        分割される)
        
      blocks := 親block `b1c 子blocks
       ( `bとc(child)で囲まれた世代番号によって、親と子が分割される)

      block  := 条件名1`a条件1`v条件名2`a条件2`n表示名1`a表示1`v表示名2`a表示2
       (`nによって、条件部と表示部が分かれる。
        条件部と表示部とも、個々のパラメータは`vで分割される。
        また、パラメータの名前と値は`aで分割される)
        
      genCon:       世代番号。

    戻り値:
      trueなら、条件にマッチしたパラメータセクションがあった。
      falseなら、一つも条件にマッチしたパラメータセクションがなかった。
    動作:
      まず、兄弟を分割して、兄から弟へ、条件をチェック。
      すべて満たすものがあったら、その中の表示パラメータをDMS_DispParameters()
      に設定。そのあと、その兄弟の子を取り出し、世代番号を+1して、再起呼び出し
 ...............................................................................
*/
DMS_SelectParamBlock(paramBlocks, genCon)
{
  ; この世代の世代番号の兄弟を分割
  ; ['b世代番号b]を、一旦'fで置き換える
  StringReplace, brotherBlocks, paramBlocks, `b%genCon%b, `f, All

  ; 兄弟の数だけのループ
  ; 条件を満たすブロックが見つかったら、本関数から抜ける
  Loop, parse, brotherBlocks, `f
  {
    if(!A_LoopField)
      Continue
      
    ; 親blockと子blocksを分割
    StringReplace, parChiBlocks, A_LoopField, `b%genCon%c, `f, All
    StringSplit, parChi, parChiBlocks , `f
    parentBlock := parChi1
    childBlocks := parchi2

    ; 親blockの条件部と表示部を分割
    StringSplit, condDisp, parentBlock , `n
    condPars := condDisp1
    dispPars := condDisp2

    ; 条件の数のループ
    ; 条件を満たせかったら、ループから抜ける
    not_meet := false
    Loop, parse, condPars, `v
    {
      if(!A_LoopField)
        Continue

      ; 条件名と条件値を分割
      StringSplit, nameVal, A_LoopField , `a

      ; 条件ルーチン呼び出し
      if(!DMS_CondParameters(nameVal1,nameVal2))
      {
        not_meet := true
        ; break →ブロックの全条件は一応評価することに
      }
    }
    
    if(!not_meet)
    {
      ; 全条件に合うブロックが見つかった
      ; 表示パラメータの設定
      Loop, parse, dispPars, `v
      {
        if(!A_LoopField)
          Continue

        ; 表示名と表示値を分割
        StringSplit, nameVal, A_LoopField , `a

        ; 設定関数呼び出し
        DMS_DispParameters(nameVal1,nameVal2,true)
      }
      
      ; 子ブロックの検査
      ; 本関数を再起呼び出しする
      genCon++
      DMS_SelectParamBlock(childBlocks, genCon)
      return true
    }
  }

  ; この世代の兄弟では、ひとつも条件にあうブロックがなかった
  return false
}


/*
 ...............................................................................

  条件パラメータの初期化
  本アプリが0.3秒とかのタイマ起動時に一度コールされる。
  このあと、iniファイルの条件パラメータの設定に従い、何度もIME状態等のチェック
  があるので、このタイミングで現在の状態を取得しておくとよい。
  
  DMS_InitCondParameters(actwin, car_x, car_y)
    引数:
      actwin:   現在アクティブなウインドウのID
      car_x:    キャレットのx座標(スクリーン座標系)
      car_y:    キャレットのy座標(スクリーン座標系)
    戻り値:
      なし
    動作:
      DMS_CondParameters(false, actwin, car_x, car_y)をコールするだけ

 ...............................................................................
*/
DMS_InitCondParameters(actwin, car_x, car_y)
{
  DMS_CondParameters(false, actwin, car_x, car_y)
}

/*
 ...............................................................................

  条件パラメータの保持と、条件の評価

  内部状態の完全クリア
  DMS_CondParameters()
    引数:
      なし
    戻り値:
      なし
    動作:
      本アプリ起動時に一度だけコールされる。
      内部状態をすべてクリアする。

  内部状態を初期化(IME等状態取得)
  DMS_CondParameters(false, actwin, dsp_x, dsp_y)
    引数:
      false:    常にfalse
      actwin:   現在アクティブなウインドウのID
      car_x:    キャレットのx座標(スクリーン座標系)
      car_y:    キャレットのy座標(スクリーン座標系)
    戻り値:
      なし
    動作:
      本アプリが0.3秒とかのタイマ起動時に一度コールされる。
      下記の「条件のサポート確認」の際に問い合わされたcondNameを保存した
      initCondListに従い、各パラメータの初期化を行う。
      このあと、iniファイルの条件パラメータの設定に従い、
      何度もIME状態等のチェックがあるので、このタイミングで現在の状態を
      取得しておくとよい(かもしれない) 。

  条件評価
  DMS_CondParameters(condName, val)
    引数:
      condName: 条件パラメータ名
      val:      条件値。
    戻り値:
      現在のIME等の状態が、condNameの条件パラメータ=valであったら、true
      そうでなければ、false
    動作:
      上記の「内部状態を初期化」が呼ばれたあと、iniファイルの設定に従い、
      何度もこの「条件評価」が呼ばれる。
      実際には、個々の条件パラメータに対応する、下記の「条件パラメータパック」を
      呼ぶ

  条件名のサポート確認
  DMS_CondParameters(false, false, condName)
    引数:
      false:    常にfalse
      false:    常にfalse
      condName: 条件パラメータ名
    戻り値:
      condNameがサポートしている条件パラメータ名であったらtrue、
      そうでなければ、false
    動作:
      下記の「条件パラメータパック」に、condNameの定義があるかどうか調べて
      (ラベルがあるかどうかisLabelで調べる)、あればtrue、なければfalseを返す。
      その際、サポート確認に来たcondNameを、内部のinitCondListに保存しておく。

  条件の評価値確認
  DMS_CondParameters(false, false, paramName, paramVal)
    引数:
      false:     常にfalse
      false:     常にfalse
      paramName: 条件パラメータ名
      paramVal:  設定しようとする値
    戻り値:
      condNameという名前の条件パラメータが、paramValという値を設定できれば
      NULL,そうでなければ、設定できない旨を示す文字列
    動作:
      paramNameの「条件パラメータパック」に、paramValが対応可能か聞く

  条件の評価値の変換
  DMS_CondParameters(false, false, paramName, paramVal, 2)
    引数:
      false:     常にfalse
      false:     常にfalse
      paramName: 条件パラメータ名
      paramVal:  設定しようとする値
      2:         常に2
    戻り値:
      paramValの値を内部で使用する値に変換し、その値を返す。
      「条件評価」をコールするときは、この値でコールしなければならない。
    動作:
      上記の通り

 ...............................................................................
*/
DMS_CondParameters(val = false, param1 = false, param2 = "", param3 = "",param4 = false)
{
  global DMS_CondParam1,DMS_CondParam2,DMS_CondParam3,DMS_CondResult
  static initCondList

  if(val)
  {
    ; 条件評価を行う
    ; 対応する「条件パラメータパック」をコール
    vector = DMS_Cond_%val%
    DMS_CondParam1 := param1
    GoSub, %vector%
    return DMS_CondResult
  }
  else
  if(param1)
  {
    ; 内部状態初期化
    ; initCondListに保存された条件パラメータを一つづつコールする
    DMS_CondParam1 := param1
    DMS_CondParam2 := param2
    DMS_CondParam3 := param3
    
    Loop, parse, initCondList, `,
    {
      if(!A_LoopField)
        break
      GoSub, %A_LoopField%
    }
      
    return
  }
  else
  if(param2 != "")
  {
    if(param3 != "")
    {
      ; 条件評価値確認(あと、内部使用の値への変換も
      vector = DMS_Cond_%param2%_check
      DMS_CondParam1 := param3
      DMS_CondParam2 := param4
      GoSub, %vector%
      return DMS_CondResult
    }
    else
    {
      ; 条件名確認(初期化用ベクタテーブル作成)
      vector = DMS_Cond_%param2%_init
      if(IsLabel(vector))
      {
        IfNotInString, initCondList, %vector%
          initCondList := initCondList . vector . "`,"
        return true
      }
      else
        return false
    }
  }
  else
    initCondList := ""
}

/*
 ...............................................................................

  条件パラメータパック
  
  個々の条件パラメータは、下記に説明する、共通するインタフェースを必ず
  持たなければならない。
  逆に言うと、このインタフェースを持つことで、他のコードは一切変更することなく、
  条件パラメータを自由に増やすことができる。
  つまり、iniファイルに書かれた条件パラメータは、その名前をそのまま使って
  下記のラベルをコールすることで、if文を用いずに、パラメータに応じた評価を
  行うようになっている。だから、下記で定義するインタフェースを持つサブルーチン
  を加えるだけで、条件パラメータ追加ができるようになっている。
  
  ※下記の「xxxx」は、個々の条件パラメータ名が入る。「IMEopen」とか。
  ※下記はすべて、サブルーチンラベルである。関数ではないので注意

  条件評価
  DMS_Cond_xxxx
    引数:  
      DMS_CondParam1(グローバル変数)
        評価したい値
    戻り値:
      DMS_CondResult(グローバル変数)
        現在の状態が、引数で与えた値を満たすものであれば、true、そうでなければ
        falseを返す
    動作:
      xxxxの条件パラメータの状態を調べ、引数で渡された値であったら、trueを返す。
      例えば、xxxxがIMEopenであったら、IMEの状態を調べ、1であったとき、
      DMS_CondParam1も1であったら、DMS_CondResultにtrueを格納し、リターンする。

  初期化
  DMS_Cond_xxxx_init
    引数:  
      DMS_CondParam1(グローバル変数)
        アクティブなウインドウのID
      DMS_CondParam2(グローバル変数)
        キャレットx座標
      DMS_CondParam3(グローバル変数)
        キャレットy座標
    戻り値:
      なし
    動作:
      例えば0.3秒に一回本アプリのタイマハンドラが起動したとき、
      上記の「条件評価」に先立ち、一回だけ、この「初期化」がコールされる。
      上記の「条件評価」は、iniファイルの記述に従い、何度でもコールされる
      可能性がある。しかし、この「初期化」は、必ず一回しかコールされない。
      したがって、「条件評価」に先立ち、この「初期化」のタイミングでIME状態等を
      取得しておき、それを内部変数に保存しておいて、「条件評価」のときは、それと
      引数とを比較するだけ、という実装にすれば、IME状態等を調べる負荷が減り、
      全体を軽くできる可能性がある。
      しかし、上記の実装のデメリットとしては、この「初期化」は、
      iniファイルのどこかでxxxxの条件パラメータが記述されていたら、
      必ず一回はコールされてしまうことである。iniファイルの評価の流れからすると、
      xxxxに関する「条件評価」は、一回もコールされない可能性もある。そのような
      場合、上記の実装では、一回も評価しないのに、IME状態等の取得は必ずやって
      しまい、かえって負荷が重くなるという可能性もある。
      この問題を避けるためには、この「初期化」では、「初期化」が呼ばれたという
      記録だけしておき、「初期化」後の初めての「条件評価」で、一回だけ、
      IME状態等の取得を行う、というやり方が考えられる。これなら、
      IME状態等の取得は常に最小ですむ。しかし、if文が増えてややこしくなるという
      デメリットもある。
      一応、本アプリでは、上記の考えで実装している。

  条件の評価値確認
  DMS_Cond_xxxx_check
    引数:  
      DMS_CondParam1(グローバル変数)
        チェックしたい値
      DMS_CondParam2(グローバル変数)
        NULLか、2
    戻り値:
      DMS_CondResult(グローバル変数)
        DMS_CondParam2がNULLだったら、xxxxのパラメータのチェック値として、
        引数の値が有効ならNullそうでなければ、エラー理由を示す文字列が返る
        DMS_CondParam2が2だったら、xxxxのパラメータのチェック値として、
        引数の値を内部で使う値に変換して、その値が返る。
    動作:
      上記の通り

 ...............................................................................
*/




/*
 ...............................................................................

  条件パラメータパック"IMEopen"
 ...............................................................................
*/
DMS_Cond_IMEopen:
  DMS_CondResult := DMS_Cond_IMEopen_f(DMS_CondParam1)
return

DMS_Cond_IMEopen_init:
  DMS_CondResult := DMS_Cond_IMEopen_f("", DMS_CondParam1)
return

DMS_Cond_IMEopen_check:
  DMS_CondResult := DMS_Cond_IMEopen_f("", false, DMS_CondParam1,DMS_CondParam2)
return


/*
 ...............................................................................

  条件パラメータ"IMEopen"に関する処理

  条件評価
  DMS_Cond_IMEopen_f(param1)
    引数:
      param1:   評価したい値。0か1か
    戻り値:
      現在のIMEopenの値がparam1と同じならtrue,そうでなければfalse
    動作:
      保存した値がなければ、IME状態を調べ、その値を保存した
      のち、param1と比較。保存した値があれば、単に保存した値とparam1を
      比較するだけ。

  初期化
  DMS_Cond_IMEopen_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      保存した値を消去する

  条件の評価値確認
  DMS_Cond_IMEopen_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。0か1か
    戻り値:
      param3の値が0か1だったらNULL、そうでなければ、サポートできない旨の
      メッセージ文字列
    動作:
      上記の通り

  条件の評価値の変換
  DMS_Cond_IMEopen_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り


 ※他のIME系のパラメータパックと、IMEウインドウのID(DMS_CondIMEwin)をグローバル
   変数で共有している。
   また、TimeAfterChangeIMEopenと、保存値(DMS_CondIMEopen)をグローバル変数で
   共有している。
 ...............................................................................
*/
DMS_Cond_IMEopen_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEopen
  static actwin
  
  if(param1 !="")
  {
    ; 条件評価

    if(DMS_CondIMEopen == "")
    {
      ; 保存値がなかった

      if(!DMS_CondIMEwin)
      {
        ; IMEウインドウのIDも消されていた

        DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
      }

      ; IME openの状態を取得
      DetectHiddenWindows, On
      SendMessage, 0x283, 5, 0, , ahk_id %DMS_CondIMEwin%
      DMS_CondIMEopen := ErrorLevel
    }
    
    ; 評価
    if(param1 == DMS_CondIMEopen)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化
  
    ; 保存値を消去
    DMS_CondIMEopen := ""
    
    if(actwin != param2)
    {
      ; 前回と今回でアクティブウインドウも変わっていた。IMEウインドウIDも消去
      DMS_CondIMEwin := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; 評価値チェック

    if(param3 == 0 || param3 == 1)
      return ""
    else
      return "表示パラメータ[IMEopen]は、[" . param3 . "]という値は設定できません。が設定できる値は0か1です。"
  }
}


/*
 ...............................................................................

  条件パラメータパック"IMEconv"
 ...............................................................................
*/

DMS_Cond_IMEconv:
  DMS_CondResult := DMS_Cond_IMEconv_f(DMS_CondParam1)
return

DMS_Cond_IMEconv_init:
  DMS_CondResult := DMS_Cond_IMEconv_f("", DMS_CondParam1)
return

DMS_Cond_IMEconv_check:
  DMS_CondResult := DMS_Cond_IMEconv_f("", false, DMS_CondParam1,DMS_CondParam2)
return


/*
 ...............................................................................

  条件パラメータ"IMEconv"に関する処理

  条件評価
  DMS_Cond_IMEconv_f(param1)
    引数:
      param1:   評価したい値。1から5まで
    戻り値:
      現在のIME conversion(入力モード)の値がparam1と同じならtrue,
      そうでなければfalse。
    動作:
      保存した値がなければ、IME状態を調べ、その値を保存した
      のち、param1と比較。保存した値があれば、単に保存した値とparam1を
      比較するだけ。
      IMEの入力モードとparam1とは、以下に対応する。
        半英数            16
        半ｶﾅ              19
        全英数            24
        ひらがな          25
        全カタカナ        27

  初期化
  DMS_Cond_IMEconv_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      保存した値を消去する

  条件の評価値確認
  DMS_Cond_IMEconv_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。1から5まで
    戻り値:
      param3の値が1から5だったらNULL、そうでなければ、サポートできない旨の
      メッセージ文字列
    動作:
      上記の通り

  条件の評価値の変換
  DMS_Cond_IMEconv_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3の1から5までの値を、16,19,24,25,27の値に変換する。
    動作:
      上記の通り


 ※他のIME系のパラメータパックと、IMEウインドウのID(DMS_CondIMEwin)をグローバル
   変数で共有している。
   また、TimeAfterChangeIMEconvと、保存値(DMS_CondIMEconv)をグローバル変数で
   共有している。
 ...............................................................................
*/
DMS_Cond_IMEconv_f(param1, param2 = false, param3 = false, param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEconv
  static actwin
  
  if(param1 !="")
  {
    ; 条件評価

    if(DMS_CondIMEconv == "")
    {
      ; 保存値がなかった

      if(!DMS_CondIMEwin)
      {
        ; IMEウインドウのIDも消されていた

        DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
      }

      ; IME conversionの状態を取得
      DetectHiddenWindows, On
      SendMessage, 0x283, 1, 0, , ahk_id %DMS_CondIMEwin%

      DMS_CondIMEconv := ErrorLevel & 0xff
    }

    ; 評価
    if(param1 == DMS_CondIMEconv)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化
  
    ; 保存値を消去
    DMS_CondIMEconv := ""
    
    if(actwin != param2)
    {
      ; 前回と今回でアクティブウインドウも変わっていた。IMEウインドウIDも消去

      DMS_CondIMEwin := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
    {
      ; conversion(入力モード)は、以下の値を持つみたいなので、1から5に直す
;      code := "16,19,24,25,27"
      code := "0,3,8,9,11,16,19,24,25,27"
      Loop, parse, code, `,
      {
        if(param3 == A_Index)
        {
          param3 := A_LoopField
          break
        }
      }
      return param3
    }
    ; 評価値チェック
;    if(param3 >= 1 && param3 <= 5)
    if(param3 >= 1 && param3 <= 10)
      return ""
    else
      return "表示パラメータ[IMEconv]は、[" . param3 . "]という値は設定できません。が設定できる値は1から5までです。"
  }
}


/*
 ...............................................................................

  条件パラメータパック"IMEsentence"
 ...............................................................................
*/

DMS_Cond_IMEsentence:
  DMS_CondResult := DMS_Cond_IMEsentence_f(DMS_CondParam1)
return

DMS_Cond_IMEsentence_init:
  DMS_CondResult := DMS_Cond_IMEsentence_f("", DMS_CondParam1)
return

DMS_Cond_IMEsentence_check:
  DMS_CondResult := DMS_Cond_IMEsentence_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  条件パラメータ"IMEsentence"に関する処理

  条件評価
  DMS_Cond_IMEsentence_f(param1)
    引数:
      param1:   評価したい値。1から4の整数
    戻り値:
      現在のIME sentence(変換モード)の値がparam1と同じならtrue,
      そうでなければfalse
    動作:
      保存した値がなければ、IME状態を調べ、その値を保存した
      のち、param1と比較。保存した値があれば、単に保存した値とparam1を
      比較するだけ。
      IMEの変換モードとparam1とは、以下に対応する。
        無変換            0
        人名/地名         1
        一般              8
        話し言葉優先      16

  初期化
  DMS_Cond_IMEsentence_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      保存した値を消去する

  条件の評価値確認
  DMS_Cond_IMEsentence_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。1から4までの整数
    戻り値:
      param3の値が1から4だったらNULL、そうでなければ、サポートできない旨の
      メッセージ文字列
    動作:
      上記の通り

  条件の評価値の変換
  DMS_Cond_IMEsentence_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3の1から4までの整数を、0,1,8,16の値に変換する。
    動作:
      上記の通り


 ※他のIME系のパラメータパックと、IMEウインドウのID(DMS_CondIMEwin)をグローバル
   変数で共有している。
   また、TimeAfterChangeIMEsentenceと、保存値(DMS_CondIMEsentence)を
   グローバル変数で共有している。
 ...............................................................................
*/
DMS_Cond_IMEsentence_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEsentence
  static actwin
  
  if(param1 !="")
  {
    ; 条件評価

    if(DMS_CondIMEsentence == "")
    {
      ; 保存値がなかった

      if(!DMS_CondIMEwin)
      {
        ; IMEウインドウのIDも消されていた

        DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
      }

      ; IME sentenceの状態を取得
      DetectHiddenWindows, On
      SendMessage, 0x283, 3, 0, , ahk_id %DMS_CondIMEwin%
      DMS_CondIMEsentence := ErrorLevel & 0xff
    }

    ; 評価
    if(param1 == DMS_CondIMEsentence)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化
  
    ; 保存値を消去
    DMS_CondIMEsentence := ""
    
    if(actwin != param2)
    {
      ; 前回と今回でアクティブウインドウも変わっていた。IMEウインドウIDも消去

      DMS_CondIMEwin := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
    {
      ; sentence(変換モード)は、以下の値を持つみたいなので、1から4を変換する
      code := "0,1,8,16"
      Loop, parse, code, `,
      {
        if(param3 == A_Index)
        {
          param3 := A_LoopField
          break
        }
      }
      return param3
    }

    ; 評価値チェック

    if(param3 >= 1 && param3 <= 4)
      return ""
    else
      return "表示パラメータ[IMEsentence]は、[" . param3 . "]という値は設定できません。が設定できる値は1から4までです。"
  }
}

/*
 ...............................................................................

  条件パラメータパック"WinTitle"
 ...............................................................................
*/
DMS_Cond_WinTitle:
  DMS_CondResult := DMS_Cond_WinTitle_f(DMS_CondParam1)
return

DMS_Cond_WinTitle_init:
  DMS_CondResult := DMS_Cond_WinTitle_f("", DMS_CondParam1)
return

DMS_Cond_WinTitle_check:
  DMS_CondResult := DMS_Cond_WinTitle_f("", false, DMS_CondParam1,DMS_CondParam2)
return


/*
 ...............................................................................

  条件パラメータ"WinTitle"に関する処理

  条件評価
  DMS_Cond_WinTitle_f(param1)
    引数:
      param1:   ウインドウのタイトルに含まれる文字列
    戻り値:
      現在のアクティブウインドウのタイトルにparam1が含まれるならtrue、
      そうでないならfalse
    動作:
      保存したウインドウタイトルがなければ、現在アクティブのウインドウタイトルを
      調べ、その値を保存したのち、param1と比較。保存したウインドウタイトルが
      あれば、単に保存した値とparam1を比較するだけ。

  初期化
  DMS_Cond_WinTitle_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      保存した値を消去するだけ。

  条件の評価値確認
  DMS_Cond_WinTitle_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。任意の文字列
    戻り値:
      常にNULLを返す。
    動作:
      「ウインドウのタイトルに含まれる文字列」は、どのようなものも考えられる
      ので、確認ができない。すべて問題なしとしている。

  条件の評価値の変換
  DMS_Cond_WinTitle_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り

 ...............................................................................
*/
DMS_Cond_WinTitle_f(param1, param2 = false, param3 = false,param4 = false)
{
  static actwin
  static wintitle
  
  if(param1 != "")
  {
    ; 条件評価

    if(!wintitle)
    {
      ; 保存値がなかったので、ウインドウタイトルを取得して、保存
      WinGetTitle, wintitle, ahk_id %actwin%
    }

    ; 評価
    IfInString, wintitle, %param1%
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化

    if(actwin != param2)
    {
      ; 前回と今回でアクティブウインドウも変わっていたら、
      ; 保存しておいたウインドウタイトルを消去
      wintitle := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
      return param3

    ; 評価値のチェックは、常に「問題なし」でリターン
    return ""
  }
}

/*
 ...............................................................................

  条件パラメータパック"WinClass"
 ...............................................................................
*/
DMS_Cond_WinClass:
  DMS_CondResult := DMS_Cond_WinClass_f(DMS_CondParam1)
return

DMS_Cond_WinClass_init:
  DMS_CondResult := DMS_Cond_WinClass_f("", DMS_CondParam1)
return

DMS_Cond_WinClass_check:
  DMS_CondResult := DMS_Cond_WinClass_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  条件パラメータ"WinClass"に関する処理

  条件評価
  DMS_Cond_WinClass_f(param1)
    引数:
      param1:   ウインドウのクラス名に含まれる文字列
    戻り値:
      現在のアクティブウインドウのクラス名にparam1が含まれるならtrue、
      そうでないならfalse
    動作:
      保存したクラス名がなければ、現在アクティブのウインドウクラス名を
      調べ、その値を保存したのち、param1と比較。保存したクラス名が
      あれば、単に保存した値とparam1を比較するだけ。

  初期化
  DMS_Cond_WinClass_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      保存した値を消去するだけ。

  条件の評価値確認
  DMS_Cond_WinClass_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。任意の文字列
    戻り値:
      常にNULLを返す。
    動作:
      「ウインドウのクラス名に含まれる文字列」は、どのようなものも考えられる
      ので、確認ができない。すべて問題なしとしている。

  条件の評価値の変換
  DMS_Cond_WinClass_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り

 ...............................................................................
*/
DMS_Cond_WinClass_f(param1, param2 = false, param3 = false,param4 = false)
{
  static actwin
  static winclass
  
  if(param1 != "")
  {
    ; 条件評価

    if(!winclass)
    {
      ; 保存値がなかったので、クラス名を取得して、保存
      WinGetClass, winclass, ahk_id %actwin%
    }

    ; 評価
    IfInString, winclass, %param1%
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化

    if(actwin != param2)
    {
      ; 前回と今回でアクティブウインドウも変わっていたら、
      ; 保存しておいたウインドウタイトルを消去
      winclass := false
      actwin := param2
    }
    return
  }
  else
  {
    if(param4 == 2)
      return param3

    ; 評価値のチェックは、常に「問題なし」でリターン
    return ""
  }
}

/*
 ...............................................................................

  条件パラメータパック"Control"
 ...............................................................................
*/
DMS_Cond_Control:
  DMS_CondResult := DMS_Cond_Control_f(DMS_CondParam1)
return

DMS_Cond_Control_init:
  DMS_CondResult := DMS_Cond_Control_f("", DMS_CondParam1)
return

DMS_Cond_Control_check:
  DMS_CondResult := DMS_Cond_Control_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  条件パラメータ"Control"に関する処理

  条件評価
  DMS_Cond_Control_f(param1)
    引数:
      param1:   ClassNNに含まれる文字列
    戻り値:
      現在のアクティブコントロールの名前(ClassNN)にparam1が含まれるならtrue、
      そうでないならfalse
    動作:
      保存したClassNNがなければ、現在アクティブのコントロールのClassNNを
      調べ、その値を保存したのち、param1と比較。保存したウインドウタイトルが
      あれば、単に保存した値とparam1を比較するだけ。

  初期化
  DMS_Cond_Control_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      保存した値を消去するだけ。

  条件の評価値確認
  DMS_Cond_Control_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。任意の文字列
    戻り値:
      常にNULLを返す。
    動作:
      「ClassNNに含まれる文字列」は、どのようなものも考えられる
      ので、確認ができない。すべて問題なしとしている。

  条件の評価値の変換
  DMS_Cond_Control_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り

 ...............................................................................
*/
DMS_Cond_Control_f(param1, param2 = false, param3 = false,param4 = false)
{
  static actwin
  static cntrl
  
  if(param1 != "")
  {
    ; 条件評価

    if(!cntrl)
    {
      ; 保存値がなかったので、ClassNNを取得して、保存
      ;ControlGetFocus, cntrl, ahk_id %actwin%
      ; ここでControlGetFocusを使うと、このコマンドは、内部でAttachThreadInput
      ; を呼ぶので、負荷が高くなる。
      ; そこで、CAR_GetCaretPos()で得られたコントロールのIDをもらうことで、
      ; ControlGetFocusをコールすることを回避する。
      cntrl_id := CAR_GetCaretPos(false,dummy,dummy)
      WinGetClass, cntrl, ahk_id %cntrl_id%
    }

    ; 評価
    IfInString, cntrl, %param1%
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化
    ; とにかく、保存したClassNNを消去

    cntrl := false
    actwin := param2
    return
  }
  else
  {
    if(param4 == 2)
      return param3
      
    ; 評価値のチェックは、常に「問題なし」でリターン
    return ""
  }
}

/*
 ...............................................................................

  条件パラメータパック"TimeAfterChangeIMEopen"
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEopen:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEopen_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEopen_init:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEopen_f("", DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEopen_check:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEopen_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  条件パラメータ"TimeAfterChangeIMEopen"に関する処理

  条件評価
  DMS_Cond_TimeAfterChangeIMEopen_f(param1)
    引数:
      param1:   評価したい値。0以上(ミリ秒)
    戻り値:
      現在のIMEopenの値が、昔のIMEopenの値と同じで、昔のIMEopenのときからの
      経過時間が、param1よりも大きかったら、true、そうでなければfalseを返す。
    動作:
      現在のIMEopenの値(=nowIMEopen)が保存してなければ、
      まず、IME状態を調べ、その値を保存する。そのときに、現在の時間も保存
      (nowTime)
      昔のIMEopenの値(=lastIMEopen)とnowIMEopenが異なる、あるいは、昔の時間
      (lastTime)が保存されてなかったら、lastIMEopenと、lastTimeを、現在のものに
      設定。
      それから、nowTimeとlastTimeの差が、param1より大きいかどうかチェックして、
      大きかったら、trueを返し、そうでなければfalseを返す。

  初期化
  DMS_Cond_TimeAfterChangeIMEopen_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      nowIMEopenを消去する。
      さらに、初期化されたあとに、一度でも上記の「条件評価」が呼ばれたかを
      あらわす"evaluated"がfalseだったら、lastTimeも消去する。

  条件の評価値確認
  DMS_Cond_TimeAfterChangeIMEopen_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。ミリ秒
    戻り値:
      param3の値が0以上だったらNULL、マイナスだったら、サポートできない旨の
      メッセージ文字列
    動作:
      上記の通り

  条件の評価値の変換
  DMS_Cond_TimeAfterChangeIMEopen_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り

 ※他のIME系のパラメータパックと、IMEウインドウのID(DMS_CondIMEwin)をグローバル
   変数で共有している。
   また、IMEopenと、保存値(DMS_CondIMEopen)をグローバル変数で共有している。
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEopen_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEopen
  static lastIMEopen
  static nowIMEopen
  static lastTime
  static nowTime
  static actwin
  static evaluated
  
  if(param1 !="")
  {
    ; 条件評価

    if(nowIMEopen == "")
    {
      ; 現在のIME状態を保存した保存値がなかった。
      if(DMS_CondIMEopen == "")
      {
        ; "IMEopen"と共有している保存値も空だった。ここで調べなくちゃいけない
        if(!DMS_CondIMEwin)
          ; IMEウインドウも空だった。ここで取得
          DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
  
        ; IMEのopen状態を取得
        DetectHiddenWindows, On
        SendMessage, 0x283, 5, 0, , ahk_id %DMS_CondIMEwin%
        DMS_CondIMEopen := ErrorLevel
      }
      
      ; 現在のIME状態を、共有IMEopen値(DMS_CondIMEopen)に設定
      nowIMEopen := DMS_CondIMEopen
      ; 現在の時刻を計測
      nowTime := A_TickCount
    }
    
    if(!lastTime || lastIMEopen != nowIMEopen)
    {
      ; 過去と現在でIME状態が違う、あるいは、過去の時刻が記録されてない。
      ; 過去の値の設定(現在と同じにする)
      lastTime := nowTime
      lastIMEopen := nowIMEopen
    }

    ; 「条件評価」が行われたことをしめす変数をtrueに
    evaluated := true

    ; 評価
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化

    ; 保存値をクリア
    DMS_CondIMEopen := ""
    nowIMEopen := ""
    
    if(actwin != param2)
    {
      ; アクティブウインドウが変わっていたときは、IMEウインドウももう無効なので
      ; クリア。当然、過去の計測時間も無効なのでクリア
      DMS_CondIMEwin := false
      actwin := param2
      lastTime := false
    }
    
    if(!evaluated)
    {
      ; 一度も「条件評価」がコールされてなかった。時間計測を打ち切るために、
      ; 過去時間をクリアする。
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; 評価値のチェック。正の値なら問題なし
    if(param3 >= 0)
      return ""
    else
      return "表示パラメータ[TimeAfterChangeIMEopen]は、[" . param3 . "]という値は設定できません。設定できる値は0以上です。"
  }
}

/*
 ...............................................................................

  条件パラメータパック"TimeAfterChangeIMEconv"
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEconv:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEconv_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEconv_init:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEconv_f("", DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEconv_check:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEconv_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  条件パラメータ"TimeAfterChangeIMEconv"に関する処理

  条件評価
  DMS_Cond_TimeAfterChangeIMEconv_f(param1)
    引数:
      param1:   評価したい値。0以上(ミリ秒)
    戻り値:
      現在のIMEconvの値が、昔のIMEconvの値と同じで、昔のIMEconvのときからの
      経過時間が、param1よりも大きかったら、true、そうでなければfalseを返す。
    動作:
      現在のIMEconvの値(=nowIMEconv)が保存してなければ、
      まず、IME状態を調べ、その値を保存する。そのときに、現在の時間も保存
      (nowTime)
      昔のIMEconvの値(=lastIMEconv)とnowIMEconvが異なる、あるいは、昔の時間
      (lastTime)が保存されてなかったら、lastIMEconvと、lastTimeを、現在のものに
      設定。
      それから、nowTimeとlastTimeの差が、param1より大きいかどうかチェックして、
      大きかったら、trueを返し、そうでなければfalseを返す。

  初期化
  DMS_Cond_TimeAfterChangeIMEconv_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      nowIMEconvを消去する。
      さらに、初期化されたあとに、一度でも上記の「条件評価」が呼ばれたかを
      あらわす"evaluated"がfalseだったら、lastTimeも消去する。

  条件の評価値確認
  DMS_Cond_TimeAfterChangeIMEconv_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。ミリ秒
    戻り値:
      param3の値が0以上だったらNULL、マイナスだったら、サポートできない旨の
      メッセージ文字列
    動作:
      上記の通り

  条件の評価値の変換
  DMS_Cond_TimeAfterChangeIMEconv_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り


 ※他のIME系のパラメータパックと、IMEウインドウのID(DMS_CondIMEwin)をグローバル
   変数で共有している。
   また、IMEconvと、保存値(DMS_CondIMEconv)をグローバル変数で共有している。
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEconv_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEconv
  static lastIMEconv
  static nowIMEconv
  static lastTime
  static nowTime
  static actwin
  static evaluated
  
  if(param1 !="")
  {
    ; 条件評価

    if(nowIMEconv == "")
    {
      ; 現在のIME状態を保存した保存値がなかった。
      if(DMS_CondIMEconv == "")
      {
        ; "IMEconv"と共有している保存値も空だった。ここで調べなくちゃいけない
        if(!DMS_CondIMEwin)
          ; IMEウインドウも空だった。ここで取得
          DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)
  
        ; IMEの入力モードを取得
        DetectHiddenWindows, On
        SendMessage, 0x283, 1, 0, , ahk_id %DMS_CondIMEwin%
        
        ; 入力モードを、1から5の値に変換
;        code := "16,19,24,25,27"
        code := "0,3,8,9,11,16,19,24,25,27"
        org_code := ErrorLevel & 0xff
        Loop, parse, code, `,
        {
          if(org_code == A_LoopField)
          {
            DMS_CondIMEconv := A_Index
            break
          }
        }
      }

      ; 現在の値と時刻を記録
      nowIMEconv := DMS_CondIMEconv
      nowTime := A_TickCount
    }

    if(!lastTime || lastIMEconv != nowIMEconv)
    {
      ; 過去と現在でIME状態が違う、あるいは、過去の時刻が記録されてない。
      ; 過去の値の設定(現在と同じにする)
      lastTime := nowTime
      lastIMEconv := nowIMEconv
    }
      
    ; 「条件評価」が行われたことをしめす変数をtrueに
    evaluated := true

    ; 評価
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化

    ; 保存値をクリア
    DMS_CondIMEconv := ""
    nowIMEconv := ""
    
    if(actwin != param2)
    {
      ; アクティブウインドウが変わっていたときは、IMEウインドウももう無効なので
      ; クリア。当然、過去の計測時間も無効なのでクリア

      DMS_CondIMEwin := false
      actwin := param2
      lastTime := false
    }
    
    if(!evaluated)
    {
      ; 一度も「条件評価」がコールされてなかった。時間計測を打ち切るために、
      ; 過去時間をクリアする。
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3

    ; 評価値のチェック。正の値なら問題なし
    if(param3 >= 0)
      return ""
    else
      return "表示パラメータ[TimeAfterChangeIMEconv]は、[" . param3 . "]という値は設定できません。設定できる値は0以上です。"
  }
}

/*
 ...............................................................................

  条件パラメータパック"TimeAfterChangeIMEsentence"
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEsentence:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEsentence_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEsentence_init:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEsentence_f("", DMS_CondParam1)
return

DMS_Cond_TimeAfterChangeIMEsentence_check:
  DMS_CondResult := DMS_Cond_TimeAfterChangeIMEsentence_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  条件パラメータ"TimeAfterChangeIMEsentence"に関する処理

  条件評価
  DMS_Cond_TimeAfterChangeIMEsentence_f(param1)
    引数:
      param1:   評価したい値。0以上(ミリ秒)
    戻り値:
      現在のIMEsentenceの値が、昔のIMEsentenceの値と同じで、
      昔のIMEsentenceのときからの経過時間が、param1よりも大きかったら、
      true、そうでなければfalseを返す。
    動作:
      現在のIMEsentenceの値(=nowIMEsentence)が保存してなければ、
      まず、IME状態を調べ、その値を保存する。そのときに、現在の時間も保存
      (nowTime)
      昔のIMEsentenceの値(=lastIMEsentence)とnowIMEsentenceが異なる、
      あるいは、昔の時間(lastTime)が保存されてなかったら、lastIMEsentenceと、
      lastTimeを、現在のものに設定。
      それから、nowTimeとlastTimeの差が、param1より大きいかどうかチェックして、
      大きかったら、trueを返し、そうでなければfalseを返す。

  初期化
  DMS_Cond_TimeAfterChangeIMEsentence_f("", param2)
    引数:
      "":       常にNULL
      param2:   アクティブなウインドウのID
    戻り値:
      なし
    動作:
      nowIMEsentenceを消去する。
      さらに、初期化されたあとに、一度でも上記の「条件評価」が呼ばれたかを
      あらわす"evaluated"がfalseだったら、lastTimeも消去する。

  条件の評価値確認
  DMS_Cond_TimeAfterChangeIMEsentence_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。ミリ秒
    戻り値:
      param3の値が0以上だったらNULL、マイナスだったら、サポートできない旨の
      メッセージ文字列
    動作:
      上記の通り

  条件の評価値の変換
  DMS_Cond_TimeAfterChangeIMEsentence_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り

 ※他のIME系のパラメータパックと、IMEウインドウのID(DMS_CondIMEwin)をグローバル
   変数で共有している。
   また、IMEsentenceと、保存値(DMS_CondIMEsentence)をグローバル変数で共有している。
 ...............................................................................
*/
DMS_Cond_TimeAfterChangeIMEsentence_f(param1, param2 = false, param3 = false,param4 = false)
{
  global DMS_CondIMEwin
  global DMS_CondIMEsentence
  static lastIMEsentence
  static nowIMEsentence
  static lastTime
  static nowTime
  static actwin
  static evaluated
  
  if(param1 !="")
  {
    ; 条件評価

    if(nowIMEsentence == "")
    {
      ; 現在のIME状態を保存した保存値がなかった。
      if(DMS_CondIMEsentence == "")
      {
        ; "IMEconv"と共有している保存値も空だった。ここで調べなくちゃいけない
        if(!DMS_CondIMEwin)
          ; IMEウインドウも空だった。ここで取得
          DMS_CondIMEwin := DllCall("imm32\ImmGetDefaultIMEWnd", "Uint",actwin)

        ; IMEの変換モードを取得
        DetectHiddenWindows, On
        SendMessage, 0x283, 3, 0, , ahk_id %DMS_CondIMEwin%
        
        ; 変換モードを、1から4の値に変換
        code := "0,1,8,16"
        org_code := ErrorLevel & 0xff
        Loop, parse, code, `,
        {
          if(org_code == A_LoopField)
          {
            DMS_CondIMEsentence := A_Index
            break
          }
        }
      }

      ; 現在の値と時刻を記録
      nowIMEsentence := DMS_CondIMEsentence
      nowTime := A_TickCount
    }
    
    if(!lastTime || lastIMEsentence != nowIMEsentence)
    {
      ; 過去と現在でIME状態が違う、あるいは、過去の時刻が記録されてない。
      ; 過去の値の設定(現在と同じにする)
      lastTime := nowTime
      lastIMEsentence := nowIMEsentence
    }

    ; 「条件評価」が行われたことをしめす変数をtrueに
    evaluated := true

    ; 評価
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化

    ; 保存値をクリア
    DMS_CondIMEsentence := ""
    nowIMEsentence := ""
    
    if(actwin != param2)
    {
      ; アクティブウインドウが変わっていたときは、IMEウインドウももう無効なので
      ; クリア。当然、過去の計測時間も無効なのでクリア
      DMS_CondIMEwin := false
      actwin := param2
      lastTime := false
    }
    
    if(!evaluated)
    {
      ; 一度も「条件評価」がコールされてなかった。時間計測を打ち切るために、
      ; 過去時間をクリアする。
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; 評価値のチェック。正の値なら問題なし
    if(param3 >= 0)
      return ""
    else
      return "表示パラメータ[TimeAfterChangeIMEsentence]は、[" . param3 . "]という値は設定できません。設定できる値は0以上です。"
  }
}

/*
 ...............................................................................

  条件パラメータパック"TimeAfterStopCaret"
 ...............................................................................
*/
DMS_Cond_TimeAfterStopCaret:
  DMS_CondResult := DMS_Cond_TimeAfterStopCaret_f(DMS_CondParam1)
return

DMS_Cond_TimeAfterStopCaret_init:
  DMS_CondResult := DMS_Cond_TimeAfterStopCaret_f("", DMS_CondParam2,DMS_CondParam3)
return

DMS_Cond_TimeAfterStopCaret_check:
  DMS_CondResult := DMS_Cond_TimeAfterStopCaret_f("", false, DMS_CondParam1,DMS_CondParam2)
return

/*
 ...............................................................................

  条件パラメータ"TimeAfterStopCaret"に関する処理

  条件評価
  DMS_Cond_TimeAfterStopCaret_f(param1)
    引数:
      param1:   評価したい値。0以上(ミリ秒)
    戻り値:
      現在のキャレットの座標値が、昔のキャレットの座標値と同じで、
      昔のキャレットの座標値のときからの経過時間が、param1よりも大きかったら、
      true、そうでなければfalseを返す。
    動作:
      現在の時間が保存されてなかったら、まずそれを設定(nowTime)
      現在のキャレットの座標値が、昔のキャレットの座標値と異なる
      あるいは、昔の時間(lastTime)が保存されてなかったら、昔のキャレット座標値と
      lastTimeを、現在のものに設定。
      それから、nowTimeとlastTimeの差が、param1より大きいかどうかチェックして、
      大きかったら、trueを返し、そうでなければfalseを返す。

  初期化
  DMS_Cond_TimeAfterStopCaret_f("", param2, param3)
    引数:
      "":       常にNULL
      param2:   キャレットx座標
      param3:   キャレットy座標
    戻り値:
      なし
    動作:
      現在時刻(nowTime)をクリアする。そして、引数を、現在のキャレット値に
      設定する。
      さらに、初期化されたあとに、一度でも上記の「条件評価」が呼ばれたかを
      あらわす"evaluated"がfalseだったら、lastTimeも消去する。

  条件の評価値確認
  DMS_Cond_TimeAfterStopCaret_f("", false, param3)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   チェックしたい値。ミリ秒
    戻り値:
      param3の値が0以上だったらNULL、マイナスだったら、サポートできない旨の
      メッセージ文字列
    動作:
      上記の通り

  条件の評価値の変換
  DMS_Cond_TimeAfterStopCaret_f("", false, param3, 2)
    引数:
      "":       常にNULL
      false:    常にfalse
      param3:   変換したい値
      2:        常に2
    戻り値:
      param3の値を内部で使用する値に変換する。
      本関数では、param3をそのまま返す。
    動作:
      上記の通り

 ...............................................................................
*/
DMS_Cond_TimeAfterStopCaret_f(param1, param2 = false, param3 = false,param4 = false)
{
  static lastDsp_x
  static lastDsp_y
  static lastTime
  static nowTime
  static nowDsp_x
  static nowDsp_y
  static evaluated
  
  if(param1 !="")
  {
    ; 条件評価

    if(!nowTime)
      ; 現在時刻が計測されてなかったので、ここで計測
      nowTime := A_TickCount

    if(!lastTime || lastDsp_x != nowDsp_x || lastDsp_y != nowDsp_y)
    {
      ; 過去の座標と現在の座標が異なる
      ; 現在の座標を過去の座標として、さらに、過去の時間を現在の時間に設定
      lastTime := nowTime
      lastDsp_x := nowDsp_x 
      lastDsp_y := nowDsp_y
    }
      
    ; 「条件評価」が行われたことをしめす変数をtrueに
    evaluated := true

    ; 評価
    if(param1 < nowTime - lastTime)
      return true
    else
      return false
  }
  else
  if(param2)
  {
    ; 初期化

    ; 保存値をクリア
    nowTime := false
    ; 引数の座標を、現在の座標として保存する
    nowDsp_x := param2
    nowDsp_y := param3

    if(!evaluated)
    {
      ; 一度も「条件評価」がコールされてなかった。時間計測を打ち切るために、
      ; 過去時間をクリアする。
      lastTime := false
    }
      
    evaluated := false
    return
  }
  else
  {
    if(param4 == 2)
      return param3
  
    ; 評価値のチェック。正の値なら問題なし
    if(param3 >= 0)
      return ""
    else
      return "表示パラメータ[TimeAfterStopCaret]は、[" . param3 . "]という値は設定できません。設定できる値は0以上です。"
  }
}

/*
----------------------------------------------------------------------------
 6.表示管理部

   IME状態表示用の表示パラメータの管理と、その表示を行う。

----------------------------------------------------------------------------
*/

/*
 ...............................................................

  IME状態を表示する。
  
  DMS_DispIMEsts(disp)
    引数:   
      disp:    trueで表示、falseで非表示
    戻り値: 
      なし
    動作:
      dispがfalseなら、ツールチップを消す
      trueなら、DMS_DispParameters()に保存された表示パラメータを読み出し、
      それに従い表示を行う

 ...............................................................
*/  
DMS_DispIMEsts(disp)
{
  static last_disp, last_string, last_dsp_x, last_dsp_y, last_trans
  static last_grid_x, last_grid_y
  static last_normal, last_color,last_margin_x,last_margin_y,last_fontName
  static last_fontColor,last_fontSize,last_fontStyle,last_frameStyle

  tooltip_num := DMS_SystemParameters("tooltip_num")

  ; 現在の表示パラメータを読み出す(1)
  ; まずstringを読んでみて、NULLだったら、表示のしようがないので、
  ; 消してリターンする。
  string := DMS_DispParameters("string")
  if(string == "" || !disp)
  {
    if(last_disp)
    {
      if(last_normal)
        ToolTip, , , ,%tooltip_num%
      else
        Gui, %tooltip_num%:Hide
    }
    last_disp := false
    return
  }



  
  ; 現在の表示パラメータを読み出す(2)
  dsp_x := DMS_DispParameters("dsp_x")
  dsp_x := dsp_x + DMS_DispParameters("ofst_x")

  dsp_y := DMS_DispParameters("dsp_y")
  dsp_y := dsp_y + DMS_DispParameters("ofst_y")

  trans := DMS_DispParameters("trans")

  grid_x := DMS_DispParameters("grid_x")
  grid_y := DMS_DispParameters("grid_y")

  normal := DMS_DispParameters("normal")
  ; normalじゃない場合のみ、カスタム表示のパラメータ読み出し
  if(!normal)
  {
    color  := DMS_DispParameters("color")
    margin_x := DMS_DispParameters("margin_x")
    margin_y := DMS_DispParameters("margin_y")
    fontName := DMS_DispParameters("fontName")
    fontColor:= DMS_DispParameters("fontColor")
    fontSize := DMS_DispParameters("fontSize")
    fontStyle := DMS_DispParameters("fontStyle")
    frameStyle := DMS_DispParameters("frameStyle")
    
    ; 表示内容が変化したかチェックして、変化していたら、新しいGuiを作成する
    if(last_color != color || last_margin_x != margin_x || last_margin_y != margin_y || last_fontName != fontName || last_fontColor != fontColor || last_fontSize != fontSize || last_fontStyle != fontStyle || last_string!=string || last_normal!=normal || last_frameStyle != frameStyle)
    {
      ; 新しいGuiを作成する。
      Gui, %tooltip_num%:Destroy

      Gui, %tooltip_num%:Margin, %margin_x%,%margin_y%
      Gui, %tooltip_num%:Color, %color%
      Gui, %tooltip_num%:Font, %fontStyle%
      if(fontColor != "")
        Gui, %tooltip_num%:Font, C%fontColor%
      if(fontSize != "")
        Gui, %tooltip_num%:Font, S%fontSize%
      if(fontName != "")
        Gui, %tooltip_num%:Font, , %fontName%
      Gui, %tooltip_num%:Add, Text,,%string%
      Gui, %tooltip_num%:+AlwaysOnTop +Disabled +ToolWindow %frameStyle%
      
      ; この場合、必ず表示しなければならないので、last_dispをfalseにする。
      ; この時点でdispはtrueなので、この下で絶対に表示してくれる
      last_disp := false
    }
  }
  
  ; 過去の表示パラメータと比較して、変化がなかったら、なにもせずリターン
  if(last_dsp_x == dsp_x && last_dsp_y == dsp_y && last_disp == disp && last_string == string && last_trans == trans && last_grid_x == grid_x && last_grid_y == grid_y && last_normal == normal)
    return


  ; もし、normalが変わっていたら、前の表示は消しておかないといけない
  if(last_normal != normal)
  {
    if(last_normal)
      ToolTip, , , ,%tooltip_num%
    else
      Gui, %tooltip_num%:Hide
  }

  ; 過去の表示パラメータを現在の表示パラメータに設定
  last_disp := disp  ; 必ずtrueになる
  last_string := string
  last_dsp_x := dsp_x
  last_dsp_y := dsp_y
  last_trans := trans
  last_grid_x := grid_x
  last_grid_y := grid_y
  last_normal := normal
  
  if(!normal)
  {
    last_color := color
    last_margin_x := margin_x
    last_margin_y := margin_y
    last_fontName := fontName
    last_fontColor:= fontColor
    last_fontSize := fontSize
    last_fontStyle := fontStyle
    last_frameStyle := frameStyle
  }

  if(grid_x || grid_y)
  {
    ; グリッド表示が指定されていた。
    
    ; コントロール原点のキャレット座標を取得
    CAR_GetCaretPos(false, org_x, org_y)
    ; フォーカスのあるコントロールの座標と大きさを取得
    actwin := DMS_DispParameters("actwin")
    ControlGetFocus, cntrl, ahk_id %actwin%
    ControlGetPos, cx,cy,cw,ch, %cntrl%, ahk_id %actwin%
    
    ; アクティブウインドウの座標を取得→コントロール座標をスクリーン座標に
    ; するのに使う
    WinGetPos, wx,wy,,,ahk_id %actwin%

    if(grid_x)
    {
      ; コントロールの幅をgrid_xで割り、格子の横幅を得る。
      grid := Round(cw / grid_x)
      
      ; 0除算を避けるためのチェックのあと、一番近い格子座標を計算
      if(grid > 1)
        dsp_x := wx + cx + grid * Round(org_x / grid) + DMS_DispParameters("ofst_x")
    }
      
    if(grid_y)
    {
      ; grid_xの場合とやってることは同じ。
      grid := Round(ch / grid_y)
      if(grid > 1)
        dsp_y := wy + cy + grid * Round(org_y / grid) + DMS_DispParameters("ofst_y")
    }
  }

  if(normal)
  {
    ; キャレット座標はスクリーン座標系なので、スクリーン座標系でツールチップを
    ; 出力

    CoordMode,ToolTip,Screen
    ToolTip, %string%, %dsp_x%, %dsp_y%,%tooltip_num%

    dispWin := "ahk_class tooltips_class32"
  }
  else
  {
    Gui, %tooltip_num%:Show,X%dsp_x% Y%dsp_y% NoActivate,DispIMEstatus
    dispWin := "DispIMEstatus"
  }

; 透明指定がされていたら、WinSetで透明化。されてなかったら、透明指定Off
  if(trans)
    WinSet,Trans,%trans%,%dispWin%
  else
    WinSet,Trans,Off,%dispWin%

}

/*
 ...............................................................................

  表示パラメータの初期化(デフォルト値に設定)
  本アプリが0.3秒とかのタイマ起動時に一度コールされる。
  
  DMS_InitDispParameters(actwin, car_x, car_y)
    引数:
      actwin:   現在アクティブなウインドウのID
      car_x:    キャレットのx座標(スクリーン座標系)
      car_y:    キャレットのy座標(スクリーン座標系)
    戻り値:
      なし
    動作:
      DMS_DispParameters(false, actwin, car_x, car_y)をコールするだけ

 ...............................................................................
*/
DMS_InitDispParameters(actwin, car_x, car_y)
{
  DMS_DispParameters(false, actwin, car_x, car_y)
  return
}

/*
 ...............................................................................

  表示パラメータの保持

  デフォルト値設定
  DMS_DispParameters()
    引数:
      なし
    戻り値:
      なし
    動作:
      本アプリ起動時に一度だけコールされる。
      デフォルト値管理部(DMS_Default())に設定された値を取り出し、内部の
      デフォルト値として設定する。

  内部状態をデフォルトにリセット
  DMS_DispParameters(false, actwin, dsp_x, dsp_y)
    引数:
      false:    常にfalse
      actwin:   現在アクティブなウインドウのID
      car_x:    キャレットのx座標(スクリーン座標系)
      car_y:    キャレットのy座標(スクリーン座標系)
    戻り値:
      なし
    動作:
      本アプリが0.3秒とかのタイマ起動時に一度コールされる。
      内部の表示パラメータを、デフォルト値に設定する。
      (その他、表示に必要なactwinやキャレット座標も保存しておく)
      このまま、iniファイルでなんの表示パラメータの指定もなかったら、
      このデフォルト値が、表示されるというわけ。
      実際には、この後、下記の「パラメータ設定」が何度もコールされて、
      表示パラメータが更新されていく。更新されなかった表示パラメータは、
      デフォルトのままである。

  パラメータ設定
  DMS_DispParameters(paramName, paramVal, true)
    引数:
      paramName: 表示パラメータ名
      paramVal:  パラメータの値
      true:      常にtrue
    戻り値:
      なし
    動作:
      表示パラメータparamNameを、paramValに設定する。

  パラメータ読み出し
  DMS_DispParameters(paramName)
    引数:
      paramName: 表示パラメータ名
    戻り値:
      paramNameのパラメータの値を返す
    動作:
      paramNameのパラメータの値を返す

  パラメータ名のサポート確認
  DMS_DispParameters(false, false, paramName)
    引数:
      false:     常にfalse
      false:     常にfalse
      paramName: 表示パラメータ名
    戻り値:
      paramNameがサポートしている表示パラメータ名であったらtrue、
      そうでなければ、false
    動作:
      paramNameの名前のパラメータ名が内部であるかどうかチェックする。

  パラメータの設定値確認
  DMS_DispParameters(false, false, paramName, paramVal, 1)
    引数:
      false:     常にfalse
      false:     常にfalse
      paramName: 表示パラメータ名
      paramVal:  設定しようとする値
      1:         つねに1
    戻り値:
      paramNameという名前の表示パラメータが、paramValという値を設定できれば
      NULL、設定できなければ、それを示す文字列を返す。
    動作:
      paramNameごとに、設定値の範囲を確認する。

  パラメータ値の変換
  DMS_DispParameters(false, false, paramName, paramVal, 2)
    引数:
      false:     常にfalse
      false:     常にfalse
      paramName: 表示パラメータ名
      paramVal:  設定しようとする値
      2:         つねに2
    戻り値:
      iniファイルに書かれたparamValを、内部で使用する値に変換した値を返す。
    動作:
      iniファイルは利用者が書くもので、あまり内部に依存したわかりにくい値を
      要求するのは酷というもの。
      しかし、実際のIME状態表示時に、値の変換をやっていたのでは、効率が悪い。
      そこで、この関数で、あらかじめ、内部で利用しやすい値に変換してparamBlockに
      保存しておいてもらい、実際のIME状態表示時は、その値を使ってもらうことに
      する。

 ...............................................................................
*/
DMS_DispParameters(val=false, param1=false, param2=false, param3=false, param4=false)
{
  static string, string_def
  static ofst_x, ofst_x_def
  static ofst_y, ofst_y_def
  static trans,  trans_def
  static grid_x,  grid_x_def
  static grid_y,  grid_y_def
  static normal,  normal_def
  static color,  color_def
  static margin_x,  margin_x_def
  static margin_y,  margin_y_def
  static fontName,  fontName_def
  static fontColor,  fontColor_def
  static fontSize,  fontSize_def
  static fontStyle,  fontStyle_def
  static frameStyle,  frameStyle_def

  static actwin
  static dsp_x, dsp_y
  
  if(val)
  {
    if(param2)
    {
      ; 値の設定
      %val% := param1
      return
    }
    ; 値の読み出し
    content := %val%
    return content
  }
  else
  if(param1)
  {
    ; 内部状態をデフォルトにリセット
    string := string_def
    ofst_x := ofst_x_def
    ofst_y := ofst_y_def
    trans  := trans_def
    grid_x := grid_x_def
    grid_y := grid_y_def
    normal := normal_def
    color  := color_def
    margin_x := margin_x_def
    margin_y := margin_y_def
    fontName := fontName_def
    fontColor:= fontColor_def
    fontSize := fontSize_def
    fontStyle:= fontStyle_def
    frameStyle:= frameStyle_def

    actwin := param1
    dsp_x  := param2
    dsp_y  := param3
    return
  }
  else
  if(param2)
  {
    if(param4 == 1)
    {
      ; パラメータの設定値確認
      if(param2 == "trans" && (param3 < 0 || param3 > 255))
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、0-255です。"
      else
      if(param2 == "grid_x" && (param3 < 0))
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、0以上です。"
      else
      if(param2 == "grid_y" && (param3 < 0))
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、0以上です。"
      else
      if(param2 == "normal" && (param3 != 0 && param3 != 1))
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、0か1です。"
      else
      if((param2 == "color" || param2 == "fontColor") && param3 != "")
      {
        ; ,(カンマ)を含むものであったら、個々の値が、0～255かどうかチェック
        IfInString, param3, `,
        {
          count := 0
          Loop, parse, param3, `, ,%A_Space%`t
          {
            If A_LoopField is not integer
              return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、R,G,Bのフォーマットで、0-255の10進数です。"
            if(A_LoopField < 0 || A_LoopField > 255)
              return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、R,G,Bのフォーマットで、0-255の10進数です。"
            count++
          }
          if(count != 3)
            return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、R,G,Bのフォーマットで、0-255の10進数です。"
        }
        else
        if(StrLen(param3) != 6)
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、RRGGBBのフォーマットの16進数6文字です。"
        else
        {
          tmp = 0x%param3%
          If tmp is not integer
            return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、RRGGBBのフォーマットの16進数6文字です。"
        }
      }
      else
      if((param2 == "margin_x" || param2 == "margin_y") && param3 < 0)
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、0以上です。"
      if(param2 == "fontSize" && param3 != "" && param3 <= 0)
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、1以上です。"
      else
      if(param2 == "fontStyle")
      {
        check := "`fBold`fItalic`fStrike`fUnderline`f"
        Loop, parse, param3, `, ,%A_Space%`t
        {
          IfNotInString, check, `f%A_LoopField%`f
            return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、Bold,Italic,Strike,Underlineのいずれかの単語を、カンマで並べた文字列です。"
        }
      }
      else
      if(param2 == "frameStyle" && (param3 <0 || param3 > 3))
      {
          return "表示パラメータ[" . param2 . "]は、[" . param3 . "]という値は設定できません。設定できる値は、0-3の整数です。"
      }

      return ""
    }
    else
    if(param4 == 2)
    {
      ; 内部使用の値に変換
      if((param2 == "color" || param2 == "fontColor") && param3 != "")
      {
        ; ,(カンマ)を含むものであったら、16進数の値に変換する
        IfInString, param3, `,
        {
          StringSplit, tmp, param3, `,, %A_Space%`t
          SetFormat, INTEGER, H
          ; RGBを24bit16進数に。
          ; 最上位桁はダミー。AHKのSetFormatは桁をそろえてくれないから。
          param3 := 1 * 0x1000000 + tmp1 * 0x10000 + tmp2 * 0x100 + tmp3
          SetFormat, INTEGER, D
          ; 最上位桁も含めてTrim
          StringTrimLeft, param3, param3, 3
        }
      }
      else
      if(param2 == "fontStyle")
      {
        ; ,(カンマ)を半角スペースに変換
        StringReplace, param3, param3, `,, %A_Space%, All
      }
      else
      if(param2 == "frameStyle")
      {
        ; 0,1,2,3を、対応するGuiオプションに変換する
        code := "-Caption,-Caption +0x00800000,-Border,-Border +E0x00000200"
        param3++
        Loop, parse, code, `,
        {
          if(param3 == A_Index)
          {
            param3 := A_LoopField
            break
          }
        }
      }
      
      return param3
    }

    ; パラメータ名のサポート確認
    check := ";string;ofst_x;ofst_y;trans;grid_x;grid_y;normal;color;margin_x;margin_y;fontName;fontColor;fontSize;fontStyle;frameStyle;"
    IfInString, check, `;%param2%`;
      return true
    else
      return false
  }
  else
  {
    ; デフォルト値設定
    ; DMS_Default()にデフォルト値があるかどうか聞き、なかったら、ここで、
    ; デフォルト値nを設定する。
    ; 当然ながら、DMS_Default()で設定された値の方が優先される。
    
    string_def := DMS_Default("string")
    if(string_def == "")
      string_def := ""
      
    ofst_x_def := DMS_Default("ofst_x")
    if(ofst_x_def == "")
      ofst_x_def := -18
      
    ofst_y_def := DMS_Default("ofst_y")
    if(ofst_y_def == "")
      ofst_y_def := -17
      
    trans_def := DMS_Default("trans")
    if(trans_def == "")
      trans_def := 0
      
    grid_x_def := DMS_Default("grid_x")
    if(grid_x_def == "")
      grid_x_def := 0

    grid_y_def := DMS_Default("grid_y")
    if(grid_y_def == "")
      grid_y_def := 0

    normal_def := DMS_Default("normal")
    if(normal_def == "")
      normal_def := 0

    color_def  := DMS_Default("color")
    if(color_def == "")
      color_def := ""

    margin_x_def := DMS_Default("margin_x")
    if(margin_x_def == "")
      margin_x_def := 2

    margin_y_def := DMS_Default("margin_y")
    if(margin_y_def == "")
      margin_y_def := 1

    fontName_def := DMS_Default("fontName")
    if(fontName_def == "")
      fontName_def := ""

    fontColor_def:= DMS_Default("fontColor")
    if(fontColor_def == "")
      fontColor_def := ""

    fontSize_def := DMS_Default("fontSize")
    if(fontSize_def == "")
      fontSize_def := ""

    fontStyle_def := DMS_Default("fontStyle")
    if(fontStyle_def == "")
      fontStyle_def := ""

    frameStyle_def := DMS_Default("frameStyle")
    if(frameStyle_def == "")
      frameStyle_def := "-Caption +0x00800000"

    return
  }
}

