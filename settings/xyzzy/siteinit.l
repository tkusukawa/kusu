;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      siteinit.l
;; このファイルを修正した場合は XYZZYHOME/xyzzy.wxp（ダンプ）を
;; 一度消してxyzzyを再起動することで再作成するのだ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;(load-library "Gates");Gates が好きならファイルの先頭に

;;
;; Windows的にクリップボードを使ってカット、コピー、ペースト
;;
(defun copy-selection-or-region-to-clipboard () ; 選択範囲をコピー
	(interactive)
	(if (get-selection-type) 
		(copy-selection-to-clipboard) 
		(copy-region-to-clipboard (mark) (point)))
)
 
(defun kill-selection-or-region-to-clipboard () ; 選択範囲をカット
	(interactive "*")
	(if (get-selection-type) 
		(kill-selection-to-clipboard) 
		(kill-region-to-clipboard (mark) (point)))
)
 
(defun kill-end-of-line-to-clipboard () ; 行末までをカット
	(interactive "*p")
	(selection-end-of-line)
	(kill-selection-to-clipboard)
)
 
(defun kill-line-to-clipboard () ; 行をカット
	(interactive "*p")
	(kill-line)
	(yank-to-clipboard)
)

(global-set-key #\C-k 'kill-end-of-line-to-clipboard)         ; 行末までカット
(global-set-key #\C-w 'kill-selection-or-region-to-clipboard) ; 選択範囲をカット
(global-set-key #\M-w 'copy-selection-or-region-to-clipboard) ; 選択範囲をコピー
(global-set-key #\C-q 'copy-selection-or-region-to-clipboard) ; 選択範囲をコピー
(global-set-key #\C-y 'paste-from-clipboard)                  ; ペースト

;;
;; インクリメンタルサーチの強化
;;
;(require "igsearch") ; ni-autoloadしている人は不要
;(setf *igsearch-init-state* :migemo) ; 最初はmigemo
;(setf *igsearch-escape-sequence* t)  ; エスケープシーケンスを理解する
;(setf *igsearch-grep* nil)           ; 候補列挙はいらない

;;
;; お好みキーバインド
;;

(require "isearch")
(global-set-key #\F5 'goto-line)
(global-set-key #\F6 'grep-dialog)
(global-set-key #\M-% 'replace-dialog)
(global-set-key #\C-_ 'undo)
(global-set-key #\C-\\ 'redo)
;(define-key ctl-x-map #\F5 'undo)
;(global-set-key '(#\C-x #\F5) 'undo)
(global-set-key #\C-z 'undo)
(global-set-key #\End 'end-of-line)
(global-set-key #\Home 'beginning-of-line)
(global-set-key #\S-End 'selection-end-of-line)
(global-set-key #\S-Home 'selection-beginning-of-line)
(global-set-key #\C-Home 'beginning-of-buffer)
(global-set-key #\C-End 'end-of-buffer)
(global-set-key #\C-l 'indent-region)

(global-set-key #\C-s 'save-buffer)

(setf (svref *kbd-translate-table* (char-code #\C-i)) #\C-F13)
(global-set-key #\C-F13 'isearch-forward)
(define-key *isearch-map* #\C-F13 'isearch-repeat-forward)
;(define-key *isearch-map* #\C-f 'isearch-repeat-forward)

(global-set-key #\C-. 'editor::dabbrev-popup)

(global-set-key '(#\C-x #\C-c) 'quit) ;よく誤ってC-x C-cで落としてまうので無効化

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ruby ;;;;;;;;;;;;;;;;;;;;;;
(load-library "ruby-mode")
(push '("\\.rb$" . ruby-mode) *auto-mode-alist*)
; インデント量を変える。nilの時はタブを挿入
;(setq *ruby-indent-column* 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; rubyの昔の設定 ;;;;;;;;;;;;;;;;;;;;;;
;(load-library "ruby")
;(push '("\\.rb$" . ruby-mode) *auto-mode-alist*)
;; インデント量を変える
;;(setq *ruby-indent-column* 3)
;(load-library "ruby-lister")
;; rtags.rbまでのパス
;(setq *ruby-lister-rtags-path* "C:/ruby/rtags.rb")
;(load-library "ruby-debug")	;debugモードを使うなら
;(load-library "ruby-doc")	;rdモードを使うなら
;(load-library "ruby-misc")	;その他を使うなら
;; ri.rbまでのパス
;(setq *ruby-information-command* "C:/cygwin/usr/local/bin/ri.rb")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;; 括弧を強調表示するのだ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require "paren")
;(turn-on-global-paren)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; バイナリエディタにするのだ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; M-x hexl-find-file
;; または、ファイルを読みこんだ後で
;; M-x hexl-mode
;; とする
;;
;; 編集方法は ローカルのキー割り当てを見てください
;;

;; hexl.exe のあるディレクトリ（PATH が通っていれば要らない）
(setq hexl-exec-directory "c:/Progra~1/xyzzy/site-lisp/")

;; ロード
;(load-library "hexl")
;; オートロードにしたい場合
(autoload 'hexl-mode "hexl" t nil)
(autoload 'hexl-find-file "hexl" t nil)

;; お好みで
;(define-key *global-keymap* '(#\C-c #\C-h) 'hexl-find-file)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode & cc-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq c++-indent-level 4)
(setq c-indent-lebel 4)

;************* html mode
(export 'ed::html+-mode "ed")
(autoload 'html+-mode "html+-mode" t)
(pushnew '("\\.s?html?$" . html+-mode) *auto-mode-alist* :test 'equal)
(push '("\\.rhtml$" . html+-mode) *auto-mode-alist*)

(change-default-fileio-encoding *encoding-utf8n*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                             gtags の設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(export 'ed::gtags-mode "ed")
(autoload 'ed::gtags-mode "gtags/gtags" t)
(require "gtags/gtags-menu")

;;; Emacs Lisp 移植キット
(require "elisp")

;;; gtags-mode
(in-package "editor")
(setq *gtags-mode-hook*
      #'(lambda ()
          (local-set-key #\M-t 'gtags-find-tag)
          (local-set-key #\M-r 'gtags-find-rtag)
          (local-set-key #\M-s 'gtags-find-symbol)
          (local-set-key #\M-e 'gtags-find-tag-from-here)
          ;(local-set-key #\M-a 'gtags-pop-stack)
          (local-set-key #\C-t 'gtags-pop-stack)
          (local-set-key #\M-j 'gtags-find-with-grep)
          (local-set-key #\M-c 'gtags-find-file-ext)
          (local-set-key #\M-n 'gtags-find-next-tag)
          (local-set-key #\M-p 'gtags-find-previous-tag)
          ))

(setq *gtags-select-mode-hook*
      #'(lambda ()
          (local-set-key #\M-a 'gtags-pop-stack)
          (local-set-key #\PageUp 'previous-page-kept-selection)
          (local-set-key #\PageDown 'next-page-kept-selection)
          (local-set-key #\LBtnDown 'gtags-mouse-left-press)
          (local-set-key #\M-n #'(lambda ()
                                   (interactive)
                                   (next-virtual-line)
                                   (gtags-select-tag)))
          (local-set-key #\M-p #'(lambda ()
                                   (interactive)
                                   (previous-virtual-line)
                                   (gtags-select-tag)))
          ))

(add-hook '*c-mode-hook*
          #'(lambda ()
              (gtags-mode 1)
              ;(gtags-make-complete-list);未対応
              ))
(add-hook '*c++-mode-hook*
          #'(lambda ()
              (gtags-mode 1)))
(add-hook '*php-mode-hook*
          #'(lambda ()
              (gtags-mode 1)
			  (setq c-indent-level 4)))
(in-package "user")

;; メニューいらんよなの切り替えスイッチ
; by Tetsuya Kamei  [xyzzy:02412]
(let ((menu *app-menu*))
  (defun menu ()
        (interactive)
        (set-menu (setq menu
                        (unless menu *app-menu*)))))
(set-menu *app-menu*)

(load-library "php-mode")
(pushnew '("\\.php$" . php-mode) *auto-mode-alist*)


;;Grepをしたときに特定のディレクトは無視する設定 (2009-09-20)
;; → http://se-suganuma.blogspot.com/2007/12/xyzzygrep.html
(require "grepd")
(defvar *ignore-scan-dirs* (list ".svn" )) ;;対象外にするフォルダ
(defvar *org-scan-files-1* (function ed::scan-files-1)) ;; 元の関数
(defun ed::scan-files-1
  (sFile pattern buffer scanner)
  (let 
    (bSkip) 
    (dolist 
      (sDir *ignore-scan-dirs*) 
      (setq sDir (append-trail-slash sDir)) 
      (setq iPos (string-match sDir sFile)) 
      (when iPos (setq bSkip t) (return))
    ) 
    (unless bSkip (funcall *org-scan-files-1* sFile pattern buffer scanner))
  )
)
;;
;; 検索文字列を強調表示する
;;
(require "pickup-pattern")
(require "pickup-grep")
(add-hook '*show-match-hook* 'pickup-pattern-last-search)
(add-hook '*show-match-hook* 'ed::show-match)
