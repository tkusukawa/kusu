;#include disp_ime_status.ahk

~LButton::
  Sleep 5
  Send {Ctrl}
return

;~LButton UP::
;  Send {Ctrl}
;return

;-----------------------------------------------------------
; PuTTYで複数行の貼り付け前には確認する
$RButton::
CoordMode,Mouse,Screen
MouseGetPos, x, y, win
WinGetClass, cls, ahk_id %win%
Send {Ctrl}
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

;~RButton UP::
;  Send {Ctrl}
;return

;-----------------------------------------------------------
; shift スクロールを横スクロールにする
;+WheelUp::  ; Scroll left.
;ControlGetFocus, fcontrol, A
;Loop 1  ; <-- Increase this value to scroll faster.
;    SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 0 after it is SB_LINELEFT.
;return

;+WheelDown::  ; Scroll right.
;ControlGetFocus, fcontrol, A
;Loop 1  ; <-- Increase this value to scroll faster.
;    SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 is WM_HSCROLL and the 1 after it is SB_LINERIGHT.
;return

;+WheelUp::send {WheelLeft}
;+WheelDown::send {WheelRight}


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

#IfWinActive ahk_class PuTTY
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


