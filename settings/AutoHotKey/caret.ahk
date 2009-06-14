/* 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 caret.ahk
   キャレットを扱うための汎用関数

   ver0.11.01   05/12/16
   なまず

 ※このプログラムはなまずの著作物ですが、複製や改変は自由に行っていただいて
   結構です。また、再頒布(公衆送信)や商業利用を含む譲渡も、「なまず」の名前と、
   URL(http://www.tierra.ne.jp/~aki/diary/)を添えていただければ、ご自由に
   していただいて結構です。改変したものを再頒布(公衆送信)や譲渡する場合は、
   改変した旨を表記してください。
 ※このプログラムを利用して生じたいかなる損害に対しても、なまずは責任を負いま
   せん。あしからずご了承ください。

 変更履歴
 
 ver0.11.01   05/12/16
   コントロールローカル座標の取り出しにバグがあったのを修正
   マルチスレッドセーフになるように、static変数の扱いの調整
   エスケープ記号(バッククオート)を廃止

 ver0.11.00   05/12/5
   動作モード指定のAPIの追加
   前回のウインドウのリセットのAPIの追加

 ver0.10.00   05/11/30
   最初のバージョン

   
 接頭語
   CAR_
   本ファイルで定義されたグローバル名(関数)は、すべて
   "CAR_"という接頭語を持つ。
   
 グローバル変数
   一切グローバル変数は使っていない。
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

/*
 ...............................................................

  キャレット座標を読み出す

  actwinで指定されたウインドウのキャレット座標の読み出し
  CAR_GetCaretPos(actwin, ByRef car_x, ByRef car_y, alwaysCaretOn = false)
    引数:   
      actwin          : ウインドウID
      car_x           : キャレットx座標(スクリーン系)が格納される
      car_y           : キャレットy座標(スクリーン系)が格納される
      alwaysCaretOn   : 本アプリは、検出したキャレットの座標が(0,0)の場合は、
                        キャレットが表示されていない、と判断する。座標(0,0)だと、
                        キャレットがテキストボックスなどに張り付いてしまうので、
                        大抵は、キャレットは、(0,0)以外の座標値を持つ。しかし、
                        ごくまれに、キャレットが出ているのに、(0,0)の座標値を
                        持ってしまうアプリも存在する。その場合、キャレットを左上
                        に寄せたときだけ、IME表示が出なくなるという結果になる。
                        そのような場合に、このパラメータで、コントロールの名前
                        (ClassNN)に含まれる文字列を指定する。すると、ここで指定し
                        た文字列を含むコントロールにフォーカスがある場合は、
                        キャレットの座標に関わらず、キャレットが出ていると
                        判断する。","で区切って、複数指定することができる。
                        省略時は、NULL
    戻り値: 
      キャレットが出ていればtrue、そうでなければfalse
    動作:
      DllCallで、GetCaretPosを呼び出すことによって、キャレット座標を得る。
    既知の問題:
      ・以下の「動作モードの指定」で、alwaysAttachをtrueにしない場合は、
        ダブルクリックとこの関数のコールが重なると、ダブルクリックが検出できなく
        なる。また、タイマで高頻度で本関数を呼ぶと、IEの画像にカーソルを置いた
        時のツールチップが出なくなる等の副作用が出る。
      ・以下の「動作モードの指定」で、alwaysAttachをtrueにした場合は、
        本関数を呼び出すスクリプトがSendコマンドを使用すると、悪影響が出るという
        副作用がある。
      ・アプリによっては、キャレットが出ていないのに、キャレットが出ていると
        判断されてしまうことがある(例えば、Sleipnirで、Webのフォームでカーソル
        を出したあと、エクスプローラバーにフォーカスを持っていくと、キャレットが
        ないのに、キャレット座標が出ることがある)。
        現状、この問題は解決できてない。(当然、A_CaretXを使っても、この問題は
        発生する)
    マルチスレッド対応:
      本関数はマルチスレッドセーフである。
      複数のスレッドから同時にコールしても問題なく動作する。

  コントロール座標系のキャレット座標の取り出し
  CAR_GetCaretPos(false, ByRef car_x, ByRef car_y)
    引数:   
      false           : 常にfalse
      car_x           : キャレットx座標(コントロール系)が格納される
      car_y           : キャレットy座標(コントロール系)が格納される
    戻り値: 
      コントロールのウインドウIDが返る
    動作:
      前回、「actwinで指定されたウインドウのキャレット座標の読み出し」が
      成功した(trueで帰った)後のみ、本関数をコールする。それ以外のコールの時は、
      動作は保障しない。
      「actwinで指定されたウインドウのキャレット座標の読み出し」は、常に
      スクリーン座標系のキャレット座標が返るので、コントロール座標系では
      どうなってる、というのを後で知りたくなったときにコールする。
    マルチスレッド対応:
      ！！！本関数はマルチスレッドセーフではない！！！
      単一スレッドのみで使用すること

  動作モードの指定
  CAR_GetCaretPos(false, false, false, alwaysAttach)
    引数:   
      false           : 常にfalse
      false           : 常にfalse
      false           : 常にfalse
      alwaysAttach    : trueなら、常に、他のアプリの入力状態を共有している。
                        falseなら、座標取得のコールの度に、入力状態の共有と
                        解除を繰り返す。

    戻り値: 
      なし
    動作:
      本関数は、他のアプリのカーソル座標を取得するため、
      win32 APIのAttachThreadInputを呼ぶ。この呼び出しは、多用すると、
      ダブルクリックが検出できなくなったり、IEで、画像にマウスカーソルを
      持って行ったときに、ツールチップが出力されなくなったり、といった
      副作用が起こる。
      これらの副作用を防ぐには、アクティブウインドウの切替時に限り、
      AttachThreadInputを呼べばよい。つまり、常に他のアプリの入力状態を
      共有し続けるという状態になる。
      しかし、この場合、この関数が動作しているスクリプトが、Sendコマンド
      を発行すると、その動作に悪影響が出る場合がある。
      そこで、alwaysAttachをtrueにしたときは、常に共有状態にし、
      falseにしたときは、コールの度に共有とその解除を繰り返すようにする。
      前者は、スクリプトのほかの部分でSendコマンドなどを使わない場合に、
      後者は、他のスクリプト(autohotkey.iniなど)に組み込んで使う場合に、
      用いるとよい。
    マルチスレッド対応:
      本関数はマルチスレッドセーフである。
      複数のスレッドから同時にコールしても問題なく動作する。


  前回のウインドウのリセット
  CAR_GetCaretPos(false, false, false, "", true)
    引数:   
      false           : 常にfalse
      false           : 常にfalse
      false           : 常にfalse
      ""              : 常に""
      true            : 常にtrue
    戻り値: 
      なし
    動作:
      内部で保持している、前回のウインドウIDを消去する。
      次回、座標の取得を行うと、必ず現在の入力状態の共有を解除して、再度、
      共有をやり直す。
      そうしないと、正しいキャレット位置が得られないようなアプリ(パワポとか)
      に対して行う。
    マルチスレッド対応:
      本関数はマルチスレッドセーフである。
      複数のスレッドから同時にコールしても問題なく動作する。

 ...............................................................
*/  
CAR_GetCaretPos(actwin, ByRef car_x, ByRef car_y, always = "", reset = false)
{
  static myThreadID
  static localPoint
  static last_focus_cntrl
  static alwaysAttach
  static last_actwin
  static last_threadID

  ; スレッドセーフ対策
  ; 処理をしている最中に、別のスレッドで割り込まれて、staticの値を変えられると、
  ; 予期せぬバグを引き起こすので、処理に入らないうちに、ここでauto変数に
  ; コピーしておく。
  lastActWin := last_actwin
  lastThreadID := last_threadID
  alwysAtch := alwaysAttach

  if(!actwin)
  {
    if(always != "")
    {
      ; alwaysがNULLでないということは、alwaysは、alwaysAttachのことである。
      alwaysAttach := always
      return
    }

    if(reset)
      last_actwin := 0
    
    ; actwinがfalseなので、前回得られた座標をコントロール座標に戻し、
    ; その座標値を返す。

    ; POINT構造体から座標値の取り出し。
    ; POINT構造体は、本当は32bitのintのメンバで構成されているのだが、
    ; 本関数はデスクトップの座標に関する値を取り出すのであって、パソコンの
    ; デスクトップの解像度が16bit intの限界の3万を超えるとは当分考えられない
    ; ので、ちょっとでも効率を上げるために、16bit分の取り出ししかしていない。
    ; だって、4K2Kの普及だって、あと5年はかかるんじゃないですか？3万越えなんて、
    ; いつになるか。そんな未来に、こんなスクリプト、誰も使わないですよ。
    ptr := &localPoint

    car_x := *ptr | (*(ptr+1) << 8)
    if(car_x > 0x8000)
      car_x := -(0xffff - car_x + 1)

    ptr += 4
    car_y := *ptr | (*(ptr+1) << 8)
    if(car_y > 0x8000)
      car_y := -(0xffff - car_y + 1)
    
    DllCall("GetCaretPos\HookInstall", "Uint",actwin, "Str",point, "Uint")

    return last_focus_cntrl
  }

  ; 本スクリプトのスレッドIDをまだ取り出してなかったら、取り出し
  if(!myThreadID)
    myThreadID := DllCall("GetCurrentThreadId")

  if(actwin != lastActwin || !alwysAtch)
  {
    if(lastThreadID && alwysAtch)
    {
      DllCall("AttachThreadInput"
               , "Uint",myThreadID, "Uint",lastThreadID,"Uint",0)
    }
  
    ; 対象ウインドウのスレッドIDを取り出して、本スレッドと入力状態を共有する。
    actwinThreadID := DllCall("GetWindowThreadProcessId"
                               , "Uint",actwin, "Uint",0)
    DllCall("AttachThreadInput"
             , "Uint",myThreadID, "Uint",actwinThreadID,"Uint",1)
    last_actwin := actwin
    last_threadID := actwinThreadID
  }

  ; フォーカスがあるコントロールのIDを取り出す
  focus_cntrl := DllCall("GetFocus")
  last_focus_cntrl := focus_cntrl
  if(!focus_cntrl)
  {
    ; フォーカスがなかったら、入力状態共有を取りやめ、リターン
    if(!alwysAtch)
    {
      DllCall("AttachThreadInput"
              , "Uint",myThreadID, "Uint",actwinThreadID,"Uint",0)
    }
    return false
  }

  ; キャレット座標取り出し
  VarSetCapacity(point,8)
;  result := DllCall("GetCaretPos", "Str",point, "Uint")
  result := DllCall("GetCaretPos\fnGetCaretPos", "Uint",actwin, "Str",point, "Uint")

  ; 入力状態共有を取りやめ
  ; これをやっておかないと、このスクリプトのほかのところでのSendコマンドに
  ; 悪影響が出る。
  if(!alwysAtch)
  {
    DllCall("AttachThreadInput"
             , "Uint",myThreadID, "Uint",actwinThreadID,"Uint",0)
  }

  ; キャレット座標取り出しが失敗したら、リターン。(これ、機能してんのかな？)
  if(!result)
    return false

  ptr := &point
  
  if(!(*ptr) && !(*(ptr+1)) && !(*(ptr+4)) && !(*(ptr+5)))
  {
    ; 座標が(0,0)だった
  
    if(!always)
      return false
    
    ; alwaysCaretOnに値が指定されていたので、今のアクティブコントロールの
    ; クラス名が、ここで指定された文字列を含むか調べて、
    ; そうじゃなかったら、falseでリターン
    WinGetClass, cntrlClass, ahk_id %focus_cntrl%
    found := false
    dlmt := ","
    Loop, parse, always, %dlmt%
    {
      IfInString, cntrlClass, %A_LoopField%
      {
        found := true
        break
      }
    }
    if(!found)
      return false
  }

  ; コントロールローカル座標を退避
  VarSetCapacity(localPoint,8)
  DllCall("RtlMoveMemory", "Str",localPoint, "Str",point,"Uint",8)

  ; スクリーン座標に変換
  DllCall("ClientToScreen","Uint",focus_cntrl,"Str",point)

  ; 構造体から座標値の取り出し
  ; 16bit分しか取り出してない(上記参照)
  car_x := *ptr | (*(ptr+1) << 8)
  if(car_x > 0x8000)
    car_x := -(0xffff - car_x + 1)

  ptr += 4
  car_y := *ptr | (*(ptr+1) << 8)
  if(car_y > 0x8000)
    car_y := -(0xffff - car_y + 1)

;  MsgBox, 16,%car_x%, %car_y%

  return true
}
