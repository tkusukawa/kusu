;#include disp_ime_status.ahk


#IfWinActive ahk_class TSSHELLWND

$^p::
  send ^p
return

$^n::
  send ^n
return

$^f::
  send ^f
return

$^b::
  send ^b
return

$^a::
  send ^a
return

$^e::
  send ^e
return

$^y::
  send ^y
return

$^w::
  send ^w
return

$^q::
  send ^q
return

$^d::
  send ^d
return

$^o::
  send ^o
return

#IfWinActive ahk_class WindowsForms10.Window.8.app.0.a0f91b
$^p::
  send ^p
return

$^n::
  send ^n
return

$^f::
  send ^f
return

$^b::
  send ^b
return

$^a::
  send ^a
return

$^e::
  send ^e
return

$^y::
  send ^y
return

$^w::
  send ^w
return

$^q::
  send ^q
return

$^d::
  send ^d
return

$^o::
  send ^o
return

#IfWinActive xyzzy

$^p::
  send ^p
return

$^n::
  send ^n
return

$^f::
  send ^f
return

$^b::
  send ^b
return

$^a::
  send ^a
return

$^e::
  send ^e
return

$^y::
  send ^y
return

$^w::
  send ^w
return

$^d::
  send ^d
return

$^q::
  send ^q
return

#IfWinActive ahk_class SunAwtFrame

$^p::
  send ^p
return

$^n::
  send ^n
return

$^f::
  send ^f
return

$^b::
  send ^b
return

$^a::
  send ^a
return

$^e::
  send ^e
return

$^y::
  send ^y
return

$^w::
  send ^w
return

$^d::
  send ^d
return

$^q::
  send ^q
return

#IfWinActive ahk_class SunAwtDialog

$^p::
  send ^p
return

$^n::
  send ^n
return

$^f::
  send ^f
return

$^b::
  send ^b
return

$^a::
  send ^a
return

$^e::
  send ^e
return

$^y::
  send ^y
return

$^w::
  send ^w
return

$^d::
  send ^d
return

$^q::
  send ^q
return

#IfWinActive ahk_class cygwin/x X rl

$^p::
  send ^p
return

$^n::
  send ^n
return

$^f::
  send ^f
return

$^b::
  send ^b
return

$^a::
  send ^a
return

$^e::
  send ^e
return

$^y::
  send ^y
return

$^w::
  send ^w
return

$^d::
  send ^d
return

$^q::
  send ^q
return

#IfWinActive

$^p::
  send {up}
return

$^n::
  send {down}
return

$^f::
  send {right}
return

$^b::
  send {left}
return

$^a::
  send {home}
return

$^e::
  send {end}
return

$^y::
  send ^v
return

$^w::
  send ^x
return

$^q::
  send ^c
return

$^d::
  send {delete}
return

$^o::
  send {vkF4sc029}
return

$!f::
  send ^f
return

$!a::
  send ^a
return


;-----------------------------------------------------------
; PuTTYで複数行の貼り付け前には確認する
$RButton::
CoordMode,Mouse,Screen
MouseGetPos, x, y, win
WinGetClass, cls, ahk_id %win%
If(cls="PuTTY") {
	StringSplit, strout, clipboard, `n
	If(strout0>1 or InStr(clipboard, "sudo")>0) {
		MsgBox, 308, PuTTY貼り付け警告, ---------------------`n%clipboard%`n---------------------`n`nを貼り付けますか?
		IfMsgBox, Yes
		{
			MouseClick, RIGHT, %x%, %y%, 1, 0
		}
	} else {
		MouseClick, RIGHT, %x%, %y%, 1, 0
	}
} else {
	MouseClick, RIGHT, %x%, %y%, 1, 0
}
return
