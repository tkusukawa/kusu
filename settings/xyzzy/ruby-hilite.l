;; Ruby Hilite Copyrite by Yukio Sakaue <yukimi_sake@mbi.nifty.com>

(setf
 ruby-str-fore-color  9         ;������̐F
 ruby-str-back-color  0
 ruby-comment-fore-color 10     ;�R�����g�̐F
 ruby-comment-back-color 0
 ruby-rd-fore-color   8         ;RD�̐F
 ruby-rd-back-color   7
 ruby-rgx-fore-color  2         ;���K�\���̐F
 ruby-rgx-back-color  0
 )

(setf
 ruby-bold-keywords (mapcar #'symbol-name
 '( ; �{�[���h�ɂ���L�[���[�h
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
	;�ϐ����̑��̋����\�� :bold���g���邪RD��string�ł�bold�̂܂܂Ȃ̂ŗv����
	(compile-regexp-keyword-list
	 '(
		 ("\$[0-9_\x7f-\xff]"  t (:keyword 2))             ;����ϐ�
		 ("\$[a-z_][a-z0-9_]*"  t (:keyword 2))            ;�O���[�o���ϐ�
		 ("@[a-z][a-z0-9_]+" t (:color 4))                 ;�C���X�^���X�ϐ�
		 ("\\<[+-]?[0-9]+\\.?[0-9]*\\>" t (:color 1))      ;���l���e����
		 ("\\<0[xX][0-9a-f]+\\>" t (:color 1))             ;16�i���e����
		 ("[^:]\\(:[a-z_][a-z0-9_]*\\)" t (:color 11 0 ) t 1)  ;�V���{��
		 )))
