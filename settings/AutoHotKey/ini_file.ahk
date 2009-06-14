/* 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
 ini_file.ahk
   iniファイルを扱うための汎用関数
   iniファイルは、Windowsで用いられる、古典的な、以下のような形式である。
   
   [セクション名１]
   エントリ1 = 値1
   エントリ2 = 値2

   [セクション名２]
   エントリ3 = 値3
   エントリ4 = 値4

   セクション名や各エントリは、必ず改行で終了する必要がある。
   行頭の空白は消去するので、字下げしてもかまわない。
   ;(セミコロン)以降はコメントとして、無視される。
   もし、;(セミコロン)を使いたかったら、';(シングルクオートセミコロン)と
   記述する。
   
   本モジュールで扱うiniファイルで日本語を使う場合は、Shift-JISか、EUCである
   必要がある。
   

   ver0.11.00   05/12/9
   なまず

 ※このプログラムはなまずの著作物ですが、複製や改変は自由に行っていただいて
   結構です。また、再頒布(公衆送信)や商業利用を含む譲渡も、「なまず」の名前と、
   URL(http://www.tierra.ne.jp/~aki/diary/)を添えていただければ、ご自由に
   していただいて結構です。改変したものを再頒布(公衆送信)や譲渡する場合は、
   改変した旨を表記してください。
 ※このプログラムを利用して生じたいかなる損害に対しても、なまずは責任を負いま
   せん。あしからずご了承ください。
   
 変更履歴

   ver0.11.00   05/12/9
   iniファイル書き込み用に、INI_WriteIniFile()を作成。
   あと、INI_AddIni()に、コメントを書き込めるようにした。

   ver0.10.00   05/11/30
   最初のバージョン



 接頭語
   INI_
   本ファイルで定義されたグローバル名(関数)は、すべて
   "INI_"という接頭語を持つ。
   
 グローバル変数
   一切グローバル変数は使っていない。
   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

/*
 ...............................................................

  iniファイルを読み出す
  
  INI_ReadIniFile(ini_file, ByRef raw_ini, ByRef message, 
                                       checkDupSection, checkDupEntry)
    引数:   
      ini_file        : iniファイルのファイル名
      raw_ini         : ini_fileの全内容を一つの文字列で表現したものが格納される
      message         : ini_fileにエラーがあった場合、エラーメッセージが入る
      checkDupSection : trueなら、セクション名の重複をチェックする。
                        falseならチェックしない。
                        省略した場合は、true
      checkDupEntry   : trueなら、同一セクション内のエントリー名の重複をチェック
                        falseならチェックしない。
                        省略した場合は、true
    戻り値: 
      ini_fileがエラーを含むもの(セクションかエントリの重複定義)だったら、false
      エラーがなかったら、trueを返す
    動作:
      ファイル先頭から最後まで一行ずつ読み込み、
      1)コメントの削除
      2)セクション名かどうか判断、セクション名を読み出し、保存
      3)エントリかどうか判断、エントリ名と値を読み出し、保存

      raw_iniは、以下のフォーマットを持つ
      
      raw_ini := section `n section `n section `n...
      
        section := section名 `v entry `a entry `a ...
        
          entry := entry名 `b 値


※ダメ文字対策について
  AutoHotkeyは英語圏のソフトなので、日本語と英語が混在した環境で文字列サーチを
  かますと、ダメ文字問題が発生する可能性がある。つまり、英語をサーチしたのに、
  日本語の1byteを引っ掛けてしまい、2byteの日本語が泣き別れ、と言う奴である。

  EUCは、必ず0x80以上なので、上記の問題は発生しない。
  Shift-JISの場合、2byte目が、0x40以上の値を使っているので、上記問題が発生する。
  
  本関数でサーチするのは、";"と、"="と、"'"と、"["である。
  このうち、";","=","'"は、0x3f以下の値なので、Shift-JISでは使われない。
  "["は、Shift-JISで使われる可能性があるので、文字列の先頭が"["であるかどうか
  判断するだけにとどめ、サーチを行わないことで、ダメ文字問題を回避した。

  まぁ、今回は上記対応でなんとかなったが、いちいち気にするのもアレだし、
  なんか考えたいですね。
 ...............................................................
*/  
INI_ReadIniFile(ini_file, ByRef raw_ini, ByRef message, checkDupSection = true, checkDupEntry = true)
{
  section := ""
  raw_ini := ""
  Loop, READ, %ini_file%
  {
    if(A_LoopReadLine == "")
      continue

    ; ';を、いったん`fに変換しておく
    StringReplace, com_line, A_LoopReadLine, `'`;, `f, All
  
    ; コメント";"以下を全消去
    StringSplit, tmp, com_line, `;, %A_Space%`t
    if(tmp1 == "")
    {
      continue
    }

    ; `fに退避しておいた';を、;に復帰する
    StringReplace, line, tmp1, `f, `;, All

    ; []で囲まれたセクション名を取り出す
    ; ダメ文字対策のため、先頭の一文字が[だったらセクションとし、
    ; 最後の1文字は]かどうかはわからないが、trimすることで対処する。
    StringGetPos, kakkoPos, line, [
    if(kakkoPos == 0)
    {
      ; 最初と最後の1文字をtrimする。
      StringTrimLeft, line, line, 1
      StringTrimRight, line, line, 1

      ; section名が見つかった
      raw_ini := raw_ini . "`n" . line . "`v"
      section := line

      continue
    }
    
    ; エントリの取り出し。最初に出てきた"="を検出する。
    StringGetPos, eqPos, line, `=
    if(ErrorLevel)
    {
      ; "="が見つからなかったら、無視する
      continue
    }
      
    StringLeft, entryName, line, %eqPos%
    if(entryName != "")
    {
      StringSplit, tmp, entryName, `f, %A_Space%`t  ; 空白の除去
      entryName := tmp1
    }

    if(entryName == "")
    {
      ; エントリの名前がNULLなら無視する
      ; 行頭に"="だけがあるような場合
      continue
    }

    eqPos++
    StringTrimLeft, entryVal, line, %eqPos%
    
    if(entryVal != "")
    {
      StringSplit, tmp, entryVal, `f, %A_Space%`t  ; 空白の除去
      entryVal := tmp1
    }
    
    ;これで、エントリが得られた。全体と結合する。
    if(section != "")
    {
      raw_ini := raw_ini . entryName . "`b" . entryVal . "`a"
    }
  }

  ; 多重定義の検出
  section_history := "`f"
  Loop, parse, raw_ini, `n
  {
    ; セクションごとのループ

    if(!A_LoopField)
      Continue
    
    StringSplit, tmp, A_LoopField, `v
    section := tmp1
    entries := tmp2

    ; セクション名の多重定義の検出
    if(checkDupSection)
    {
      IfInString, section_history, `f%section%`f
      {
        message = セクション[%section%]が、多重設定されています。
        return false
      }
      section_history := section_history . section . "`f"
    }

    entry_history := "`f"
    ; セクション内のエントリの多重定義の検出
    Loop, parse, entries, `a
    {
      if(!A_LoopField)
        Continue

      StringSplit, tmp, A_LoopField, `b
      entryName := tmp1

      if(checkDupEntry)
      {
        IfInString, entry_history, `f%entryName%`f
        {
          message := "セクション[" . section . "]の中のエントリー[" . entryName . "]が、多重設定されています。"
          return false
        }
        entry_history := entry_history . entryName . "`f"
      }
    }
  }
  return true
}

/*
 ...............................................................

  iniファイル文字列のエントリを取り出す
  
  INI_ParseIni(ByRef parse_ini, ByRef section, ByRef entryName, ByRef entryVal)
    引数:   
      parse_ini       : iniファイルを1つの文字列にまとめたもの。INI_ReadIniFileの
                        出力。本関数で１エントリ取り出した後、その分、parse_iniは
                        短くなる。
      section         : セクション名
      entryName       : エントリ名
      entryVal        : エントリの値
    戻り値: 
      parse_iniがNULL(すべてのエントリを読み終えた)ならfalse。
      エントリ値が取り出せたらtrue
    動作:
      parse_iniは、エントリを取り出すごとに短くなる。だから、
      同じparse_iniを指定して、何度もINI_ParseIniを呼べば、iniファイルの
      エントリを順番に取り出すことができる。
      セクション名のみで、エントリがないセクションは、entryNameはNULLが
      入る。最初はエントリがあったセクションも、そのセクションを読み出して
      しまうと、エントリのないセクションになる。
      例えば、以下のようなセクションがあったとする。

      [サンプル1]
      エントリ1 = a

      このセクションを読み出すと、

        section =   サンプル1
        entryName = エントリ1
        entryVal  = a

      という値が得られる。そして、parse_iniは、

      [サンプル1]

      となる。これを次回読み出すと、

        section =   サンプル1
        entryName = ""
        entryVal  = ""

      となる。
      これを利用して、entryNameがNULLなのを検出して、セクションの最後で
      なにか処理を実行することができる。エントリの個数は読み出してみなければ
      わからない。だから、「これでこのセクションはおしまい」というタイミングは
      どうしても欲しいところ。それを、entryNameがNULLなのを検出することで、
      発見することができる。
 ...............................................................
*/  
INI_ParseIni(ByRef parse_ini, ByRef section, ByRef entryName, ByRef entryVal)
{

  find := false
  entryName := ""
  entryVal  := ""

  ; parse_iniは、後で、読み出したエントリ分を切り取って、短くする。
  ; そのとき、区切り記号`nや`aを見つけて、切り取り位置を検出するのだが、
  ; その際、何個目の`nや`aで切り取るかを、以下のカウンタで認識する。
  ; `nや`aは、処理の流れによっては、冗長に埋め込まれていることがある。
  ; それは、A_LoopFieldがNULLかどうかで読み飛ばすのだが、その際、読み飛ばした
  ; 回数を以下のカウンタで覚えておき、それで、切り取り位置を間違いのないものに
  ; するわけ。
  n_count := 0
  a_count := 0

  Loop, parse, parse_ini, `n
  {
    ; セクションごとのループ
  
    n_count++

    if(!A_LoopField)
      Continue

    ;セクション名と複数のエントリとを分離
    StringSplit, tmp, A_LoopField, `v
    section := tmp1
    entries := tmp2

    Loop, parse, entries, `a
    {
      ; エントリごとのループ

      a_count++

      if(!A_LoopField)
        Continue

      ;エントリ名と値を分離
      StringSplit, tmp, A_LoopField, `b
      entryName := tmp1
      entryVal := tmp2
      break
    }
    find := true
    break
  }
  
  if(find)
  {
    if(entryName == "")
    {
      ; エントリが一つもなかった。次回のセクションまで切り取る
      StringGetPos, pos, parse_ini, `n, L%n_count%
      pos++
      if(pos)
        StringTrimLeft, parse_ini, parse_ini, pos
      else
        ; 次の`nがなかった。つまり、このファイルはおしまい
        parse_ini := ""
    }
    else
    {
      ; 次のエントリまで切り取る
      StringGetPos, pos, parse_ini, `a, L%a_count%
      pos++
      StringTrimLeft, parse_ini, parse_ini, pos
      ; 今回のセクション名は頭につける
      parse_ini := section . "`v" . parse_ini
    }
    return true
  }
  else
    return false
}

/*
 ...............................................................

  iniファイル文字列を作成する。
  
  INI_AddIni(ByRef this_ini, section, entryName = "", entryVal = "",
                                                         comment = "")
    引数:   
      this_ini        : iniファイル文字列
      section         : セクション名
      entryName       : エントリ名。省略したらNULL
      entryVal        : エントリの値。省略したらNULL
      comment         : エントリ行に対するコメント。省略したらNULL
    戻り値: 
      なし
    動作:
      this_iniに、セクション名とエントリを追加する。
      sectionをNULLにすると、エントリだけ追加する。つまり、すでに
      セクション名をthis_iniに追加していて、エントリだけ追加したい
      時は、sectionをNULLにする。sectionがNULLじゃないと、新しい
      セクションとして追加してしまうので、注意。
      コメントは、INI_ParseIni()では読み飛ばされるが、INI_WriteIniFileでは、
      ファイルに書き込まれる。
 ...............................................................
*/  
INI_AddIni(ByRef this_ini, section, entryName = "", entryVal = "", comment = "")
{
  if(section != "")
    this_ini := this_ini . "`n" . section . "`v"
    
  if(entryName != "")
    this_ini := this_ini . entryName . "`b" . entryVal

  if(comment != "")
    this_ini := this_ini . "`b" . comment . "`a"
  else
    this_ini := this_ini . "`a"
    
}

/*
 ...............................................................

  iniファイルを作成する
  
  INI_WriteIniFile(ini_file, raw_ini, ByRef message,comment = "")

    引数:   
      ini_file        : iniファイルのファイル名
      raw_ini         : ini_fileの全内容を一つの文字列で表現したもの。
                      ; INI_AddIni()の出力
      message         : 書き込み、あるいはファイルの削除にエラーがあった場合、
                      ; エラーメッセージが入る
      comment         ; ファイルの先頭に書き込むコメント。省略時はなし

    戻り値: 
      ファイル作成成功ならtrue、失敗はfalseが返る
    動作:
      1)ini_fileが存在するなら、消去
      2)raw_iniをパースして、ini_fileに書き込み

 ...............................................................
*/  
INI_WriteIniFile(ini_file, raw_ini, ByRef message,comment = "")
{
  IfExist, %ini_file%
  {
    FileDelete, %ini_file%
    if(ErrorLevel)
    {
      message = [%ini_file%]の削除に失敗しました
      return false
    }
  }

  err_mes = [%ini_file%]の書き込みに失敗しました

  ; ファイルの先頭のコメントの入力
  if(comment != "")
  {
     FileAppend , `; %comment%`n, %ini_file%
    if(ErrorLevel)
    {
      message = err_mes
      return false
    }
  }
  
  Loop, parse, raw_ini, `n
  {
    ; セクションごとのループ

    if(!A_LoopField)
      Continue

    ;セクション名と複数のエントリとを分離
    StringSplit, tmp, A_LoopField, `v
    section := tmp1
    entries := tmp2

    ; セクション名の書き込み
    FileAppend , [%section%]`n, %ini_file%
    if(ErrorLevel)
    {
      message = err_mes
      return false
    }

    Loop, parse, entries, `a
    {
      ; エントリごとのループ

      if(!A_LoopField)
        Continue

      ;エントリ名と値を分離
      tmp3 := ""
      StringSplit, tmp, A_LoopField, `b
      entryName := tmp1
      entryVal := tmp2
      comment := tmp3

      FileAppend , %entryName% = %entryVal% , %ini_file%
      if(ErrorLevel)
      {
        message = err_mes
        return false
      }
      
      if(tmp3 != "")
      {
        FileAppend , %A_Space%`; %comment%, %ini_file%
        if(ErrorLevel)
        {
          message = err_mes
          return false
        }
      }
      FileAppend , `n, %ini_file%
      if(ErrorLevel)
      {
        message = err_mes
        return false
      }
    }
  }

  return true
}



