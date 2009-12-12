;; Ruby Hilite Copyrite by Yukio Sakaue <yukimi_sake@mbi.nifty.com>

(setf
 ruby-str-fore-color  9         ;文字列の色
 ruby-str-back-color  0
 ruby-comment-fore-color 10     ;コメントの色
 ruby-comment-back-color 0
 ruby-rd-fore-color   8         ;RDの色
 ruby-rd-back-color   7
 ruby-rgx-fore-color  2         ;正規表現の色
 ruby-rgx-back-color  0
 )

(setf
 ruby-bold-keywords (mapcar #'symbol-name
 '( ; ボールドにするキーワード
	 BEGIN
	 END
	 alias
	 and
	 begin
	 break
	 case
	 class
	 def
	 defined?
	 do
	 else
	 elsif
	 end
	 ensure
	 false
	 for
	 if
	 in
	 module
	 next
	 nil
	 not
	 or
	 raise
	 redo
	 rescue
	 retry
	 return
	 self
	 super
	 then
	 true
	 undef
	 unless
	 until
	 when
	 while
	 yield
	 attr
	 extend
	 include
	 require
	 )))

(defvar *ruby-variables-regexp* 
	;変数その他の強調表示 :boldも使えるがRDやstringでもboldのままなので要注意
	(compile-regexp-keyword-list
	 '(
		 ("\$[0-9_\x7f-\xff]"  t (:keyword 2))             ;特殊変数
		 ("\$[a-z_][a-z0-9_]*"  t (:keyword 2))            ;グローバル変数
		 ("@[a-z][a-z0-9_]+" t (:color 4))                 ;インスタンス変数
		 ("\\<[+-]?[0-9]+\\.?[0-9]*\\>" t (:color 1))      ;数値リテラル
		 ("\\<0[xX][0-9a-f]+\\>" t (:color 1))             ;16進リテラル
		 ("[^:]\\(:[a-z_][a-z0-9_]*\\)" t (:color 11 0 ) t 1)  ;シンボル
		 )))

