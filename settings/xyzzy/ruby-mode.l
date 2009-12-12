;;; -*- Mode: Lisp; Package: EDITOR -*-
;;;
;;; This file is not part of xyzzy.
;;;
; $Id: ruby-mode.l,v 040408 2004/04/08 00:00:00 Yukimi_Sake $
;
; ruby-mode for xyzzy
;
; original by HATTORI Masashi San <gyo@he.mirai.ne.jp>
;
; modified by Yukio Sakaue <yukimi_sake@mbi.nifty.com>

(provide "ruby-mode")

(in-package "editor")

(require "ruby-hilite")

(export '(ruby-mode
					ruby-interaction-mode
					ruby-refresh
					perform-replace
					*ruby-prog* *ruby-tab-always-indent*
					*ruby-keyword-file* *ruby-mode-hook*
					*ruby-mode-syntax-table* *ruby-mode-map*
					*ruby-mode-abbrev-table*
					*ruby-indent-column*
					*ruby-reference-html-help-file*
					*ruby-save-bufer-before-run*
					replace-string query-replace replace-regexp query-replace-regexp
					))

(defvar *ruby-prog* "ruby")
(defvar *ruby-tab-always-indent* t)
(defvar *ruby-mode-hook* nil)
(defvar *ruby-keyword-hash-table* nil)
(defvar *ruby-keyword-file* "Ruby")
(defvar *ruby-completion-list* nil)
(defvar *ruby-indent-column* 2)
(defvar *ruby-reference-html-help-file* "rubymanjp.chm")
(defvar *ruby-save-bufer-before-run* nil)

(defvar *ruby-mode-syntax-table* nil)
(unless *ruby-mode-syntax-table*
  (setq *ruby-mode-syntax-table* (make-syntax-table))
;	(do ((x #x21 (1+ x)))((>= x #x7f))
;		(let ((c (code-char x)))
;			(unless (alphanumericp c)
;				(set-syntax-punctuation *ruby-mode-syntax-table* c))))
  (set-syntax-escape *ruby-mode-syntax-table* #\\)
  (set-syntax-symbol *ruby-mode-syntax-table* #\_)
  (set-syntax-symbol *ruby-mode-syntax-table* #\?)
  (set-syntax-symbol-prefix *ruby-mode-syntax-table* #\$)
  (set-syntax-symbol-prefix *ruby-mode-syntax-table* #\@)
  (set-syntax-match *ruby-mode-syntax-table* #\( #\))
  (set-syntax-match *ruby-mode-syntax-table* #\{ #\})
  (set-syntax-match *ruby-mode-syntax-table* #\[ #\])
)

(defvar *ruby-mode-map* nil)
(unless *ruby-mode-map*
	(setq *ruby-mode-map* (make-sparse-keymap))
	(define-key *ruby-mode-map* #\{ 'ruby-electric-insert)
;	(define-key *ruby-mode-map* #\: 'ruby-electric-insert)
	(define-key *ruby-mode-map* #\F1 'ruby-reference-show-html-help)
	(define-key *ruby-mode-map* #\} 'ruby-electric-close)
	(define-key *ruby-mode-map* #\C-h 'backward-delete-char-untabify-or-selection)
	(define-key *ruby-mode-map* #\TAB 'ruby-tab-and-indent)
	(define-key *ruby-mode-map* #\F20 'ruby-completion)
	(define-key *ruby-mode-map* #\RET 'ruby-newline-and-indent)
	(cond
	 ((find "Gates" *modules* :test #'string=)
		(define-key *ruby-mode-map* '(#\C-F5) 'ruby-interaction-mode)
		(define-key *ruby-mode-map* '(#\F12) 'list-function)
		(define-key *ruby-mode-map* '(#\F5) 'ruby-run-script-immediate)
		(define-key *ruby-mode-map* '(#\S-F5) 'ruby-run-script-with-args)
		(define-key *ruby-mode-map* '(#\S-F12) 'ruby-refresh))
	 
	 (t
		(define-key *ruby-mode-map* '(#\C-c #\i) 'ruby-interaction-mode)
		(define-key *ruby-mode-map* '(#\C-c #\l) 'list-function)
		(define-key *ruby-mode-map* '(#\C-c #\C-x) 'ruby-run-script-immediate)
		(define-key *ruby-mode-map* '(#\C-c #\x) 'ruby-run-script-with-args)
		(define-key *ruby-mode-map* '(#\C-c #\r) 'ruby-refresh)
		)))

(set-extended-key-translate-table exkey-S-space #\F20)

(defvar *ruby-mode-abbrev-table* nil)
(unless *ruby-mode-abbrev-table*
  (define-abbrev-table '*ruby-mode-abbrev-table*))

(defun ruby-tab-and-indent ()
	(interactive "*p")
	(enable-post-buffer-modified-hook nil)
	(ruby-indent-line)
	(enable-post-buffer-modified-hook t)
	)

(defun ruby-newline-and-indent (&optional (arg 1))
  (interactive "*p")
	(enable-post-buffer-modified-hook nil)
  (delete-trailing-spaces)
	(let ((n 0))
		(setq n (ruby-indent-line t))
		(insert #\LFD arg)
		(when (and n (<=  0  n ))
			(if *ruby-indent-column* 
					(insert " " (* n *ruby-indent-column*))
				(insert "\t" n))))
;	(message "~A ~A" (1- (point))(point))
	(save-excursion(modify-rb-attributes (1- (point))(point)))
	(enable-post-buffer-modified-hook t)
	)

;;; Ruby Interaction Mode ;;;

(defvar-local *ruby-interaction-mode* nil)
;(defvar-local irb-process nil)
(defvar *ruby-interaction-mode-map* nil)
(unless *ruby-interaction-mode-map*
	(setq *ruby-interaction-mode-map* (make-sparse-keymap))
	(define-key *ruby-interaction-mode-map* #\C-j 'irb-eval-paragraph)
	)

(defun ruby-interaction-mode (&optional (arg nil sv))
  (interactive "p")
  (toggle-mode '*ruby-interaction-mode* arg sv)
  (if *ruby-interaction-mode*(setq mode-name "Ruby-Interaction")
		(setq mode-name "Ruby"))
  (update-mode-line t)
  (if *ruby-interaction-mode*
      (progn
				(set-minor-mode-map *ruby-interaction-mode-map*)
				(irb-start)
				)
    (progn
			(unset-minor-mode-map *ruby-interaction-mode-map*)
			(irb-quit)
			(sit-for 0.1)
			(delete-other-windows)
			))
	t)

(setq irb-start-script "\"
module IRB
  def IRB.setup(ap_path)
    IRB.init_config(ap_path)
    IRB.init_error
    IRB.conf[:PROMPT][:XYZZY_PROMPT] = {
      :PROMPT_I => nil,
      :PROMPT_S => nil,
      :PROMPT_C => nil,
      :RETURN => '==>%s\n'
    }
    IRB.conf[:PROMPT_MODE] = :XYZZY_PROMPT
    IRB.run_config
  end
end
IRB.start
\"")

;;;

(defun ruby-electric-insert (&optional (arg 1)) ;from ruby.l by HATTORI San
  (interactive "*p")
  (self-insert-command arg)
  (ruby-indent-line))

(defun ruby-electric-close (&optional (arg 1)) ;from ruby.l by HATTORI San
  (interactive "*p")
  (self-insert-command arg)
  (ruby-indent-line)
  (save-excursion
    (forward-char -1)
    (and (goto-matched-parenthesis)
	 (show-matched-parenthesis)))
  t)

(defun ruby-indent-line (&optional new-line)
  (interactive "*")
	(if (or (not (interactive-p))
					*ruby-tab-always-indent*
					(save-excursion
						(skip-chars-backward " \t")
						(bolp)))
			(let ((column 0)(n0 nil)(n1 nil))
				(multiple-value-setq (n0 n1) (rb-count-indent new-line))
				(when (and (integerp n0)(<= 0 n0))
					(save-excursion
						(goto-bol)
						(delete-region (point)
													 (progn
														 (skip-chars-forward " \t")
														 (point)))
						(if *ruby-indent-column*
								(insert " " (* n0 *ruby-indent-column*))
							(insert "\t" n0)
							)))
				(if (and (bolp) n0)
						(skip-chars-forward " \t"))
				(return-from ruby-indent-line n1))
		(insert "\t"))
	t)

(defun ruby-completion () ;from ruby.l by HATTORI San
  (interactive)
  (or *ruby-completion-list*
      (setq *ruby-completion-list*
						(make-list-from-keyword-table *ruby-keyword-hash-table*))
      (return-from ruby-completion nil))
  (let ((opoint (point)))
    (when (skip-syntax-spec-backward "w_")
      (let ((from (point)))
	(goto-char opoint)
	(do-completion from opoint :list *ruby-completion-list*)))))

(defun tags-find-ruby-point (class name functionp point)
	;from ruby.l by HATTORI San
  (goto-char (- point *jump-tag-limit*))
  (and (scan-buffer (concat "^[ \t]*\\(def\\|class\\|module\\|attr\\)[ \t]+"
			    (regexp-quote name)
			    "\\($\\|[ \t\r\n\f#]\\)")
		    :regexp t :limit (+ point *jump-tag-limit*))
       (point)))

(defun ruby-mode () ;from ruby.l by HATTORI San
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "Ruby")
  (setq buffer-mode 'ruby-mode)
  (use-syntax-table *ruby-mode-syntax-table*)
  (use-keymap *ruby-mode-map*)
  (make-local-variable 'mode-specific-indent-command)
  (setq mode-specific-indent-command #'ruby-indent-line)
  (make-local-variable 'paragraph-start)
  (setq paragraph-start "^$\\|\f")
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
;  (make-local-variable 'indent-tabs-mode)
;  (setq indent-tabs-mode nil)
  (make-local-variable 'tags-find-target)
  (setq tags-find-target #'tags-find-target-simple)
  (make-local-variable 'tags-find-point)
  (setq tags-find-point #'tags-find-ruby-point)
  (make-local-variable 'build-summary-function)
  (setq build-summary-function 'ruby-build-summary-of-functions)
  (and *ruby-keyword-file*
       (null *ruby-keyword-hash-table*)
       (setq *ruby-keyword-hash-table*
	     (load-keyword-file *ruby-keyword-file*)))
  (when *ruby-keyword-hash-table*
    (make-local-variable 'keyword-hash-table)
    (setq keyword-hash-table *ruby-keyword-hash-table*))
  (make-local-variable 'regexp-keyword-list)
  (setq regexp-keyword-list *ruby-variables-regexp*)
  (setq *local-abbrev-table* *ruby-mode-abbrev-table*)
  (run-hooks '*ruby-mode-hook*)
	(enable-post-buffer-modified-hook t)
	(add-hook 'post-buffer-modified-hook 'ruby-buffer-modified-hook)
	(save-excursion
		(clear-all-text-attributes)
		(modify-rb-attributes (point-min) (point-max))))

(pushnew '(ruby-maketags "*.rb") *maketags-list* :key #'car)

(defun ruby-maketags (file count) ;from ruby.l by HATTORI San
  (goto-char (point-min))
  (while (scan-buffer "^[ \t]*\\(def\\|class\\|module\\|attr\\)[ \t]+"
											:regexp t :tail t)
    (do-events)
    (let ((type (match-string 1))
	  (opoint (point)))
      (when (and (string= type "attr")
		 (looking-at "[ \t]+:"))
	(goto-char (match-end 0))
      )
      (skip-chars-forward "A-Za-z0-9_")
      (unless (= opoint (point))
	(format t "~A~A~D" (buffer-substring opoint (point)) file opoint)
	(setq count (1+ count)))))
  count)

(defun ruby-buffer-modified-hook (buffer operation from to undo-p)
	(cond
	 ((eq buffer-mode 'ruby-mode)
		(save-excursion
			(modify-rb-attributes from to)))
	 ))

(setf
 rb-special-regexp (compile-regexp "[\"\'\`\/\#\}\=]")
 rd-end-regexp (compile-regexp "^=end")
 rd-keyword-regexp
 (compile-regexp
	(format nil "\\<~A\\>~{\\|\\<~A\\>~}" (car ruby-bold-keywords)
					(cdr ruby-bold-keywords)))
 rb-block-mid-regexp
 (compile-regexp
	(concat "^[ \t]*then\\|^[ \t]*else\\|^[ \t]*elsif\\|^[ \t]*when\\|"
					"^[ \t]*rescue\\|^[ \t]*ensure"))
 rb-token-regexp
 (compile-regexp
	"[\"\'\`\#\}\/]\\|^=begin\\|[\@\$\.]?[a-zA-Z_][a-zA-Z0-9_]+\\>")
 rb-token-regexp2
 (compile-regexp
	"[\"\'\`\/\#\{\}]\\|^=begin\\|[\@\$\.]?[a-zA-Z_][a-zA-Z0-9_]+\\>")
 rb-then-regexp
 (compile-regexp
	"\\<then\\($\\|[^a-zA-Z0-9_].*[\;\#]?\\)")
 rb-while-until-for-regexp
 (compile-regexp
	"\\(^\\|;\\)[ \t]*\\(while\\|until\\|for\\)\\($\\|[^a-zA-Z0-9_]\\)")
 rb-bold-keywords
 (append ruby-bold-keywords '("{" "}" "\"" "\'" "\`" "\#" "#{" "\/"))
 rb-be-keywords
 '( "=begin" "=end" "begin" "case" "class" "def" "do" "end" "for" "if"
	 "module" "unless" "until" "while" "{" "}" "\"" "\'" "\`" "\/" "\#")
 rd-end-regexp
 (compile-regexp "^=end")
 )

(defun modify-rb-attributes (rb-from rb-to)
	(refresh-screen)
	(let((rb-from-bol (progn (goto-char rb-from)(goto-bol)(point)))
			 (rb-to-eol (progn (goto-char rb-to)(goto-eol)(point)))
			 (rb-eof (point-max))
			 (rb-bol 0)(rb-eol 0)(ke 0)(c1 0)(n1 0)
			 (rb-str nil)(rd-lin nil)(rb-rgx nil)(rb-exp nil)(rb-cmt nil)
			 (opoint 0)(mb 0)(me 0)(ms nil))
		;point-min to before rb-from check attributes
		(goto-char (point-min))
		(while (scan-buffer rb-special-regexp :limit rb-from-bol :tail t)
			(setq mb (match-beginning 0) me (match-end 0) ms (match-string 0))
			(cond
			 ((and (save-excursion (backward-char)(bolp))(string= ms "=")
						 (looking-for "begin")(not(or rb-str rd-lin)))
				(if (scan-buffer rd-end-regexp :limit rb-from-bol)
						(goto-eol)
					(setq rd-lin t)))
			 ((and (string= ms "\#")(not(or rb-str rd-lin)));comment
				(goto-char mb) ;check escape character
				(if (and
						 (not(looking-back "?"))
						 (progn (skip-chars-backward "\\")(evenp (- mb (point)))))
						(goto-eol)
					(goto-char me)))
			 ((and
				 (not(or rd-lin rb-str))
				 (string= ms "\'")
				 (save-excursion (goto-char mb)
					 (not(or(looking-back "\$")(looking-back "?"))))
				 (save-excursion ;check escape character
					 (goto-char mb)
					 (skip-chars-backward "\\")
					 (evenp (- mb (point)))))
				(unless
						(while (scan-buffer ms :limit rb-from-bol :tail t)
							(when (save-excursion
											(goto-char (setq mb(match-beginning 0)))
											(skip-chars-backward "\\")
											(evenp (- mb (point))))
								(return t)))
					(setq rb-str ms)
					);unless
				)
			 ((and
				 (not(or rd-lin rb-str))
				 (find ms '("\"" "\`" "\/" "\}") :test #'string=)
				 (save-excursion (goto-char mb)
					 (not(or(looking-back "\$")(looking-back "?"))))
				 (save-excursion ;check escape character
					 (goto-char mb)
					 (skip-chars-backward "\\")
					 (evenp (- mb (point))))
				 (save-excursion
					 (or (not (string= ms "\/"))
							 (progn(goto-char mb)(skip-chars-backward " \t")
								 (setq opoint(point))nil)
							 (or
								(bolp)
								(looking-back "=~")
								(looking-back "=>")
								(looking-back  "<<")
								(skip-chars-backward "=[;({|," )
								(and
								 (skip-syntax-spec-backward "w_")
								 (or
									(find (buffer-substring (point) opoint)
												'( "begin" "do" "else" "elsif" "ensure""if"
													"rescue""then""unless" "until" "while" "when")
												:test #'string=)
									(and
									 (skip-chars-backward "." )
									 (skip-syntax-spec-backward "w_")
									 (progn
										 (skip-chars-backward " \t")
										 (or (bolp) (looking-back ";"))))
									)))
							 ))
				 (if (string= ms "\}")
						 (and rb-exp (prog1(setq ms rb-exp)(setq rb-exp nil)))
					 t)
				 );and
				(unless
						(while
								(scan-buffer (concat ms "\\|#{" )
														 :limit rb-from-bol :tail t :regexp t)
							(when
									(save-excursion
										(goto-char (setq me (match-end 0) mb (match-beginning 0)))
										(skip-chars-backward "\\")
										(evenp (- mb (point))))
								(when (string= (match-string 0) "#{")
									(setq rb-exp ms))
								(setq rb-str nil)
								(return t)))
					(setq rb-str ms)
					);unless
				)
			 );cond
			);while
		(goto-char rb-from-bol)
		;at modified lines, set ruby attributes
		(loop
			(setf rb-bol (point) ke (point) rb-eol (progn(goto-eol)(point))rb-cmt nil)
			(goto-bol)
			(cond
			 ((and (not rd-lin)(not rb-str)(looking-for "=begin"))
				(setq rd-lin t)
				(set-rd-line-attr ruby-rd-fore-color ruby-rd-back-color (1+ rb-eol))
				(goto-eol)(setq ke (1+ (point)))
				);rd begin
			 ((and rd-lin (not rb-str)(looking-for "=end"))
				(setq rd-lin nil)
				(goto-bol)
				(set-rd-line-attr ruby-rd-fore-color ruby-rd-back-color (1+ rb-eol))
				(goto-eol)(setq ke (1+ (point)))
				);rd end
			 ((and rd-lin (not rb-str))
				(set-rd-line-attr ruby-rd-fore-color ruby-rd-back-color (1+ rb-eol))
				(goto-eol)(setq ke (point))
				);rd lin
			 (t
				(while (scan-buffer rb-token-regexp :limit rb-eol :tail t)
					(setq c1 nil)
					(when (find (match-string 0) rb-bold-keywords :test #'string=)
						(setf
						 n1 (point)
						 c1 (match-string 0)
						 mb (match-beginning 0)
						 me (match-end 0))
						(cond
						 ((and (string= c1 "\#")
									 (save-excursion
										 (goto-char mb)
										 (and (not (looking-back "?"))
													(progn
														(skip-chars-backward "\\")
														(evenp (- mb (point))))))
									 (or (not rb-str) (not (looking-for "{"))))
							(if rb-str
									(progn
										(if (string= rb-str "\/")
												(set-text-attribute ke me 'non-kwd
																						:foreground ruby-rgx-fore-color
																						:background ruby-rgx-back-color)
											(set-text-attribute ke me 'non-kwd
																					:foreground ruby-str-fore-color
																					:background ruby-str-back-color))
										(setq ke me))
								(progn
									(if rb-cmt
											(set-text-attribute ke mb 'non-kwd
																					:foreground ruby-comment-fore-color
																					:background ruby-comment-back-color)
										(set-text-attribute ke mb 'non-kwd))
									(set-text-attribute mb me 'non-kwd
																			:foreground ruby-comment-fore-color
																			:background ruby-comment-back-color)
									(setq ke me)
									(setq rb-cmt t))))
						 (rb-cmt
								(set-text-attribute ke mb  'non-kwd
																		:foreground ruby-comment-fore-color
																		:background ruby-comment-back-color)
								(set-text-attribute mb me 'kwd
																		:foreground ruby-comment-fore-color
																		:background ruby-comment-back-color)
								(setq ke me))
						 ((save-excursion (goto-char mb)
								(and
								 (not rb-rgx)
								 (string= c1 "\'");if single quatation
								 (or rb-str (not (or(looking-back "\$")(looking-back "?"))))
								 (progn
									 (skip-chars-backward "\\") ;check escape character
									 (evenp (- mb (point))))
								 (or (not rb-str)(string= c1 rb-str))
								 ))
								(cond
								 (rb-str
									(set-text-attribute ke mb 'non-kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color)
									(set-text-attribute mb me 'non-kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color)
									(setq rb-str nil)
									(setq ke me))
								 (t
									(set-text-attribute ke mb 'non-kwd)
									(set-text-attribute mb me 'non-kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color)
									(setq rb-str c1)
									(setq ke  me)))
							);toggle quatation flag
						 
						 ((save-excursion (goto-char mb)
								(and
								 (find c1 '("\"""\`""\/""#" "}") :test #'string=) ;if quatation
								 (or rb-str (not (or(looking-back "\$")(looking-back "?"))))
								 (progn
									 (skip-chars-backward "\\") ;check escape character
									 (evenp (- mb (point))))
								 (or (not(string= c1 "}")) rb-exp)
								 (or rb-str (not (string= c1 "\/"))
										 (progn(goto-char mb)(skip-chars-backward " \t")
											 (setq opoint(point))nil)
										 (or
											(bolp)
											(looking-back "=~")
											(looking-back "=>")
											(looking-back  "<<")
											(skip-chars-backward "=[;({|," )
											(and
											 (skip-syntax-spec-backward "w_")
											 (or
												(find (buffer-substring (point) opoint)
															'( "begin" "do" "else" "elsif" "ensure""if"
																"rescue""then""unless" "until" "while" "when")
															:test #'string=)
												(and
												 (skip-chars-backward "." )
												 (skip-syntax-spec-backward "w_")
												 (progn
													 (skip-chars-backward " \t")
													 (or (bolp) (looking-back ";"))))
												))))
								 (progn (goto-char me)
									 (or (not rb-str)
											 (string= c1 rb-str)
											 (and
												(not(string= rb-str "\'"))
												(string= c1 "#")
												(looking-for "{")
												)))
								 ))
							(cond
							 (rb-str
								(when (string= c1 "#")
									(setq rb-exp rb-str)
									(forward-char)
									(setq me (point)))
								(cond
								 ((string= rb-str "\/")
									(set-text-attribute ke mb 'non-kwd
																			:foreground ruby-rgx-fore-color
																			:background ruby-rgx-back-color)
									(set-text-attribute mb me 'non-kwd
																			:foreground ruby-rgx-fore-color
																			:background ruby-rgx-back-color))
								 (t
									(set-text-attribute ke mb 'non-kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color)
									(set-text-attribute mb me 'non-kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color))
								 )
								(setq rb-str nil)
								(setq ke me))
							 (t
								(if (string= c1 "}")
										(progn(setq rb-str rb-exp)(setq rb-exp nil))
									(setq rb-str c1))
								(set-text-attribute ke mb 'non-kwd)
								(if (string= rb-str "\/")
										(set-text-attribute mb me 'non-kwd
																				:foreground ruby-rgx-fore-color
																				:background ruby-rgx-back-color)
									(set-text-attribute mb me 'non-kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color)
									)
								(setq ke me)))
							);toggle quatation flag
						 (t ;else it's keyword
							(cond
							 (rb-str
								;if in string, change tag and color
								(cond
								 ((string= rb-str "\/")
									(set-text-attribute ke mb  'non-kwd
																			:foreground ruby-rgx-fore-color
																			:background ruby-rgx-back-color)
									(set-text-attribute mb me 'kwd
																			:foreground ruby-rgx-fore-color
																			:background ruby-rgx-back-color))
								 (t
									(set-text-attribute ke mb  'non-kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color)
									(set-text-attribute mb me 'kwd
																			:foreground ruby-str-fore-color
																			:background ruby-str-back-color)))
								(setq ke me))
							 (t
								;else change keyword to bold
								(cond
								 ((find c1 '("\"""\'""\`""\}""\/""\#" ) :test #'string=)
									(set-text-attribute ke mb  'non-kwd)
									(set-text-attribute mb me 'non-kwd)
									)
								 (t
									(set-text-attribute ke mb  'non-kwd)
									(set-text-attribute mb me 'kwd :bold t))
								 )
								(setq ke me));t
							 )))));end while
				;line termination
				(cond
				 (rb-cmt
								(set-text-attribute  ke (1+ rb-eol)  'non-kwd
																		:foreground ruby-comment-fore-color
																		:background ruby-comment-back-color))
				 (rb-str
					(cond
					 ((string= rb-str "\/")
						(set-text-attribute ke (1+ rb-eol) 'non-kwd
																:foreground ruby-rgx-fore-color
																:background ruby-rgx-back-color))
					 (t
						(set-text-attribute ke (1+ rb-eol) 'non-kwd
																:foreground ruby-str-fore-color
																:background ruby-str-back-color))
					 )
					)
				 (t
					(unless rd-lin (set-text-attribute ke (1+ rb-eol) 'non-kwd )))
				 )
				(goto-eol)
				(setq ke (point))
				)
			 )
			(if (or (>= (point) rb-to-eol) (not(forward-line))) (return))
			);loop
		(when (eolp)(forward-char))
		;at remained line, modify ruby attributes
		(while (scan-buffer rb-special-regexp :limit rb-eof :tail t)
			(setq mb (match-beginning 0) me (match-end 0) ms (match-string 0))
			(cond
			 ((and (save-excursion (backward-char)(bolp))
						 (string= ms "=")
						 (looking-for "begin")
						 (not(or rb-str rd-lin)))
				(modify-text-attributes 'kwd :start ke :end mb :bold t)
				(modify-text-attributes 'non-kwd :start ke :end mb)
				(setq ke mb)
				(if (scan-buffer rd-end-regexp :limit rb-eof)
						(progn
							(goto-eol)
							(modify-text-attributes 'kwd :start ke :end (1+ (point))
																			:foreground ruby-rd-fore-color
																			:background ruby-rd-back-color :extend t)
							(modify-text-attributes 'non-kwd :start ke :end (1+ (point))
																			:foreground ruby-rd-fore-color
																			:background ruby-rd-back-color :extend t)
							(setq ke (1+ (point))))
					(setq rd-lin t)))
			 ((and (save-excursion (backward-char)(bolp))
						 (string= ms "=")
						 (looking-for "end")
						 rd-lin
						 (not rb-str))
				(goto-eol)
				(modify-text-attributes 'kwd :start ke :end (1+ (point))
																:foreground ruby-rd-fore-color
																:background ruby-rd-back-color :extend t)
				(modify-text-attributes 'non-kwd :start ke :end (1+ (point))
																:foreground ruby-rd-fore-color
																:background ruby-rd-back-color :extend t)
				(setq ke (1+ (point)))
				(setq rd-lin nil))
			 ((and
				 (string= ms "\#")
				 (not (or rb-str rd-lin)));comment
				(goto-char mb) ;check escape character
				(if (and
						 (not(looking-back "?"))
						 (progn (skip-chars-backward "\\")(evenp (- mb (point)))))
						(progn
							(goto-char mb)
							(modify-text-attributes 'kwd :start ke :end mb :bold t)
							(modify-text-attributes 'non-kwd :start ke :end mb)
							(setq ke mb)(goto-eol)
							(modify-text-attributes 'kwd :start ke :end (point)
																			:foreground ruby-comment-fore-color
																			:background ruby-comment-back-color)
							(modify-text-attributes 'non-kwd :start ke :end (point)
																			:foreground ruby-comment-fore-color
																			:background ruby-comment-back-color)
							(setq ke (point))
							)
					(progn (setq ke me)(goto-char me))))
			 ((and (not(or rd-lin rb-str))
						 (string= ms "\'")
						 (save-excursion (goto-char mb)(not(or(looking-back "\$")(looking-back "?"))))
						 (save-excursion (goto-char mb)
							 (skip-chars-backward "\\") ;check escape character
							 (evenp (- mb (point)))))
				(unless
						(progn
							(modify-text-attributes 'kwd :start ke :end mb :bold t)
							(modify-text-attributes 'non-kwd :start ke :end mb)
							(setq ke mb)
							(while (scan-buffer ms :limit rb-eof :tail t)
								(when (save-excursion
												(goto-char (setq me (match-end 0) mb (match-beginning 0)))
												(skip-chars-backward "\\")
												(evenp (- mb (point))))
									(modify-text-attributes 'kwd :start ke :end me
																					:foreground ruby-str-fore-color
																					:background ruby-str-back-color)
									(modify-text-attributes 'non-kwd :start ke :end me
																					:foreground ruby-str-fore-color
																					:background ruby-str-back-color)
									(setq rb-str nil)
									(setq ke me)
									(return t)
									)))
					(setq rb-str ms))
				)
			 ((and
				 (not(or rd-lin rb-str))
				 (or (find ms '("\"" "\`""\/") :test #'string=)
						 (and rb-exp (string= ms "}")))
				 (save-excursion (goto-char mb)
					 (not(or(looking-back "\$")(looking-back "?"))))
				 (save-excursion ;check escape character
					 (goto-char mb)
					 (skip-chars-backward "\\")
					 (evenp (- mb (point))))
				 (save-excursion
					 (or (not (string= ms "\/"))
							 (progn(goto-char mb)(skip-chars-backward " \t")
								 (setq opoint(point))nil)
							 (or
								(bolp)
								(looking-back "=~")
								(looking-back "=>")
								(looking-back  "<<")
								(skip-chars-backward "=[;({|," )
								(and
								 (skip-syntax-spec-backward "w_")
								 (or
									(find (buffer-substring (point) opoint)
												'( "begin" "do" "else" "elsif" "ensure""if"
													"rescue""then""unless" "until" "while" "when")
												:test #'string=)
									(and
									 (skip-chars-backward "." )
									 (skip-syntax-spec-backward "w_")
									 (progn
										 (skip-chars-backward " \t")
										 (or (bolp) (looking-back ";"))))
									)))
							 ))				 
;				 (or (not (string= ms "\}"))
;						 (if rb-exp (prog1(setq ms rb-exp)(setq rb-exp nil)) nil))
				 )
				(unless
						(progn
							(when (string= ms "}")
								(setq ms rb-exp)(setq rb-exp nil))
							(modify-text-attributes 'kwd :start ke :end mb :bold t)
							(modify-text-attributes 'non-kwd :start ke :end mb)
							(setq ke mb)
							(while
									(scan-buffer (concat ms "\\|#{" )
															 :limit rb-eof :tail t :regexp t)
								(when
										(save-excursion
											(goto-char (setq me (match-end 0) mb (match-beginning 0)))
											(skip-chars-backward "\\")
											(evenp (- mb (point))))
									(cond
									 ((string= ms "\/")
										(modify-text-attributes 'kwd :start ke :end me
																						:foreground ruby-rgx-fore-color
																						:background ruby-rgx-back-color)
										(modify-text-attributes 'non-kwd :start ke :end me
																						:foreground ruby-rgx-fore-color
																						:background ruby-rgx-back-color))
									 (t
										(modify-text-attributes 'kwd :start ke :end me
																						:foreground ruby-str-fore-color
																						:background ruby-str-back-color)
										(modify-text-attributes 'non-kwd :start ke :end me
																						:foreground ruby-str-fore-color
																						:background ruby-str-back-color))
									 )
									(when (string= (match-string 0) "#{") (setq rb-exp ms))
									(setq rb-str nil)
									(setq ke me)
									(return t)
									)))
					(setq rb-str ms))
				)
			 ((and (not rd-lin)
						 (or
							(string= ms rb-str)
							(and (not(string= rb-str "\'"))
									 (string= ms "\#")
									 (looking-for "\{")
									 ))
						 (save-excursion(goto-char mb)
							 (skip-chars-backward "\\")(evenp (- mb (point)))))
				(when (string= ms "\#")
					(setq rb-exp rb-str)
					(forward-char)
					(setq me (point)))
				(cond
				 ((string= rb-str "\/")
					(modify-text-attributes 'kwd :start ke :end me
																	:foreground ruby-rgx-fore-color
																	:background ruby-rgx-back-color)
					(modify-text-attributes 'non-kwd :start ke :end me
																	:foreground ruby-rgx-fore-color
																	:background ruby-rgx-back-color)
					)
				 (t
					(modify-text-attributes 'kwd :start ke :end me
																	:foreground ruby-str-fore-color
																	:background ruby-str-back-color)
					(modify-text-attributes 'non-kwd :start ke :end me
																	:foreground ruby-str-fore-color
																	:background ruby-str-back-color)
					)
				 )
				(setq rb-str nil ke me))
			 ;(t (goto-char me))
			 );cond
			);while
		;terminate to EOF
		(cond
		 (rb-str
			(cond
			 ((string= rb-str "\/")
				(modify-text-attributes 'kwd :start ke :end (point-max)
																:foreground ruby-rgx-fore-color
																:background ruby-rgx-back-color)
				(modify-text-attributes 'non-kwd :start ke :end (point-max)
																:foreground ruby-rgx-fore-color
																:background ruby-rgx-back-color))
			 (t
				(modify-text-attributes 'kwd :start ke :end (point-max)
																:foreground ruby-str-fore-color
																:background ruby-str-back-color)
				(modify-text-attributes 'non-kwd :start ke :end (point-max)
																:foreground ruby-str-fore-color
																:background ruby-str-back-color))
			 ))
		 (rd-lin
			(modify-text-attributes 'kwd :start ke :end (point-max)
															:foreground ruby-rd-fore-color
															:background ruby-rd-back-color
															:extend t)
			(modify-text-attributes 'non-kwd :start ke :end (point-max)
															:foreground ruby-rd-fore-color
															:background ruby-rd-back-color
															:extend t))
		 (t 
			(modify-text-attributes 'kwd :start ke :end (point-max) :bold t)
			(modify-text-attributes 'non-kwd :start ke :end (point-max)))
		 )
		);let
	);modify-rb-attributes

(defun set-rd-line-attr (ruby-rd-fore-color ruby-rd-back-color rd-eol)
	(let ((ke (point))(mb (point))(me (point)))
		(while (scan-buffer rd-keyword-regexp :limit rd-eol :tail t)
			(setq mb (match-beginning 0) me (match-end 0))
			(set-text-attribute ke mb 'non-kwd
													:foreground ruby-rd-fore-color
													:background ruby-rd-back-color :extend t)
			(set-text-attribute mb me 'kwd
													:foreground ruby-rd-fore-color
													:background ruby-rd-back-color :extend t)
			(setq ke me))
		(set-text-attribute ke rd-eol 'non-kwd
												:foreground ruby-rd-fore-color
												:background ruby-rd-back-color :extend t)))

(defun rb-count-indent (&optional new-line)
	(let ((b0 0)(n0 0)(n 0)(s nil)(limit 0)(rb-str nil)(rd-lin nil)(rb-exp nil))
		(save-excursion
			(goto-bol)
			(setq b0 (point))
			(setq limit (point))
			(goto-char (point-min))
			(while
					(prog1(multiple-value-setq (s rb-str rd-lin rb-exp)
									(scan-skip-non-ruby-exp limit rb-exp))
						)
				(when (or rb-str rd-lin)(return))
				(if (or (string= s "end")(string= s "\}"))
						(decf n) (incf n)))
			(setq n0 n))
		(save-excursion
			(save-restriction 
				(unless new-line (goto-eol))
				(narrow-to-region b0 (point))
				(setq limit (point))
				(goto-char (point-min))
				(when rd-lin
					(when (looking-at "^=end")
						(return-from rb-count-indent (values nil n)))
					(return-from rb-count-indent (values nil nil)))
				(when rb-str
					(setq n0 nil)
					(unless (scan-buffer rb-str :tail t)
											 (return-from rb-count-indent (values nil nil))))
				(when (or (looking-at "^[ \t]*end\\($\\|[^a-zA-Z0-9_]\\)\\|^[ \t]*\}") 
						(scan-buffer rb-block-mid-regexp :tail t)) (decf n0))
				(while (multiple-value-setq (s rb-str rd-lin rb-exp)
								 (scan-skip-non-ruby-exp limit rb-exp))
					(when (or rb-str rd-lin)(return))
					(if (or (string= s "end")(string= s "}"))
							(decf n) (incf n)))
				(when rd-lin
					(return-from rb-count-indent (values nil nil)))
				(when rb-str
					(when (progn (goto-bol)(skip-chars-forward " \t")
									(string= rb-str (buffer-substring (point)(1+ (point)))))
						(return-from rb-count-indent (values nil nil)))
					(return-from rb-count-indent (values n nil)))
				))
		(values n0 n)))

(defun scan-skip-non-ruby-exp (limit-pos rb-exp)
	(let ((opoint 0)(mb 0)(me 0)(ms nil)
				(rb-str nil)(rd-lin nil)
				(rb-bol 0)(rb-eol 0))
		(while (progn (setq ms nil)
						 (scan-buffer rb-token-regexp2 :limit limit-pos :tail t))
			(when (find (match-string 0) rb-be-keywords :test #'string=)
				(setq mb (match-beginning 0) me (match-end 0) ms (match-string 0))
				(cond
				 ((and (string= ms "=begin") (not(or rb-str rd-lin)))
					(if (scan-buffer rd-end-regexp :limit limit-pos)
							(goto-eol)
						(setq rd-lin t)))
				 ((and (string= ms "\#")(not(or rb-str rd-lin)));comment
					(goto-char mb) ;check escape character
					(if (and
							 (not(looking-back "?"))
							 (progn (skip-chars-backward "\\")(evenp (- mb (point)))))
							(goto-eol)(goto-char me)))
				 ((and
					 (not rd-lin)
					 (string= ms "\'")
					 (save-excursion
						 (goto-char mb)
						 (and
							(or rb-str (not(or(looking-back "\$")(looking-back "?"))))
							(progn (skip-chars-backward "\\")
								(evenp (- mb (point)))))));it's single quotation
					(if rb-str
							(setq rb-str nil)
						(unless
							(while (scan-buffer ms :limit limit-pos :tail t)
								(when
										(save-excursion
											(goto-char (setf me (match-end 0) mb (match-beginning 0)))
											(skip-chars-backward "\\")
											(evenp (- mb (point))))
									(return t)))
							(progn (goto-char limit-pos)
								(setq rb-str ms)(return nil)));unless
						);if
					);is string
				 ((and
					 (not rd-lin)
					 (find ms '("\"" "\`" "\/""\}") :test #'string=)
					 (save-excursion (goto-char mb)
						 (and
							(or rb-str (not(or(looking-back "\$")(looking-back "?"))))
							(progn(skip-chars-backward "\\")(evenp (- mb (point))))
							(or (not (string= ms "\/"))
									(progn (skip-chars-backward " \t")(setq opoint(point))nil)
									(or
									 (bolp)
									 (looking-back "=~")
									 (looking-back "=>")
									 (looking-back  "<<")
									 (skip-chars-backward "=[;({|," )
									 (and
										(skip-syntax-spec-backward "w_")
										(or
										 (find (buffer-substring (point) opoint)
													 '( "begin" "do" "else" "elsif" "ensure""if"
														 "rescue""then""unless" "until" "while" "when")
													 :test #'string=)
										 (and
											(skip-chars-backward "." )
											(skip-syntax-spec-backward "w_")
											(progn
												(skip-chars-backward " \t")
												(or (bolp) (looking-back ";"))))
										 ))))
							(if (string= ms "\}")
									(and rb-exp (prog1(setq ms rb-exp)(setq rb-exp nil))) t )
							)));it's quotation
					(if rb-str
							(when(string= rb-str ms)(setq rb-str nil))
						(unless
							(while (scan-buffer (concat ms "\\|#{" )
																	:limit limit-pos :tail t :regexp t)
								(when
										(save-excursion
											(goto-char (setf me (match-end 0) mb (match-beginning 0)))
											(skip-chars-backward "\\")
											(evenp (- mb (point)))
											)
									(when (string= (match-string 0) "#{")
										(setq rb-exp ms))
									(return t)))
							(progn (goto-char limit-pos)
								(setq rb-str ms)(return nil)));unless
						);if
					);is string
				 ((find ms '("if" "unless" "while" "until" "rescue") :test #'string= )
					(save-excursion
						(goto-eol)(setq rb-eol (point))
						(if	(progn
									(goto-char (match-beginning 0))
									(skip-chars-backward " \t")
									(or (bolp)
											(string= ";" (buffer-substring (1- (point)) (point)))))
								(progn
									(return ms))
							(progn
								(goto-char (match-end 0))
								(when (scan-buffer rb-then-regexp :limit rb-eol)(return ms))
								(setq ms nil)))))
				 ((and (not rb-str)(not rd-lin)(find ms '("do" "\{" ) :test #'string=))
					(save-excursion
						(setq opoint (point))
						(goto-bol) (setq rb-bol (point)) (goto-char opoint)
						(if (scan-buffer rb-while-until-for-regexp
														 :limit rb-bol :reverse t)
								(setq ms nil)
							(return ms))))
				 ((and
					 (not rb-str)
					 (not rd-lin)
					 (find
						ms '("begin" "case" "class" "def" "end" "for" "if" "module" "}")
						:test #'string=))
					(return)
					)
				 );cond
				);when
			);while
		(values ms rb-str rd-lin rb-exp)
		);let
	)

(defun ruby-reference-show-html-help ()
  (interactive)
  (html-help (merge-pathnames *ruby-reference-html-help-file* (etc-path))
		 (get-winhelp-topic)))

(defun ruby-run-script-immediate ()
	(interactive)
	(rb-run "")
	)

(defun ruby-run-script-with-args (&optional args)
	(interactive "sARGS: ")
	(unless (interactive-p)
		(setq args (read-string "ARGS: "))
		)
	(rb-run args)
	)

(defun rb-run (args)
	(if *ruby-save-bufer-before-run*
			(progn
				(save-buffer)
				(command-execution (concat *ruby-prog* " "
																	(get-buffer-file-name) " " args)))
		(let
				((tempfile (make-temp-file-name
										"__temp_" "rb" (default-directory))))
			(with-open-file(rb-stream tempfile :direction :output)
				(princ (buffer-substring (point-min)(point-max)) rb-stream )
				)
			(command-execution (concat *ruby-prog* " \"" tempfile "\" " args))
			(delete-file tempfile :if-does-not-exist :skip)
			)
		)
	)

(defun command-execution (command)
	(interactive "sCmmand:")
	(let ((proc nil)(buffer (selected-buffer)))
		(with-output-to-temp-buffer ("*cmd*" 5)
			(unwind-protect
					(setq proc (make-process
											command
											:output(selected-buffer)
											:exec-directory (default-directory buffer)))
				))
		(while (eq :run (process-status proc))
			(sit-for 0.05)(do-events))
		(if (= 0 (point-max))
				(let ((buff (selected-buffer)))
					(other-window)
					(delete-buffer buff)
					(delete-other-windows))
			(other-window))
		(message (concat " '" command "' ended.")))
	)

(defun irb-start ()
	(interactive)
		(with-output-to-temp-buffer("*Result*" 8)
			(setf irb-result-buffer (selected-buffer)
						irb-count-send 0)
			(set-process-filter
			 (setq irb-process
						 (make-process (concat "ruby -r irb -e " irb-start-script )
													 :output irb-result-buffer)) 'irb-filter-func)
			(other-window)
			))

(defun irb-filter-func (process str)
	(save-window-excursion
		(set-buffer irb-result-buffer)
		(goto-char (point-max))
		(insert (substring str irb-count-send (length str)))
		)
	(other-window)
	(goto-char (point-max))
	(refresh-screen)
	(other-window)
	(refresh-screen)
	)

(defun send-to-irb (str)
	(setq irb-count-send (length str))
	(process-send-string irb-process str))

(defun irb-quit ()
	(send-to-irb"quit\n"))

(defun irb-eval-paragraph ()
	(interactive)
	(let ((opoint (point)(rb-eol opoint)(rb-start opoint)))
	(save-excursion
		(setq rb-bol (progn (goto-bol)(point)))
		(setq rb-eol (progn (goto-eol)(point)))
		(if (scan-buffer "\\(^\\|;\\)[ \t]*end\\([ \t]*\\|#.*\\)$"
										 :regexp t :reverse t :limit rb-bol)
				(progn
					(setq rb-start (irb-serch-paragraph rb-eol))
					(unless rb-start (return-from irb-eval-paragraph)))
			(setq rb-start (progn(goto-bol)(point))))
		(send-to-irb (concat (buffer-substring rb-start rb-eol) "\n" ))
		)))

(defun irb-serch-paragraph (limit)
	(let ((b0 0)(p1 0)(n 0)(s nil)(rb-str nil)(rd-lin nil)(rb-exp))
		(save-excursion
			(goto-char (point-min))
			(while (multiple-value-setq (s rb-str rd-lin rb-exp)
							 (scan-skip-non-ruby-exp limit rb-exp))
				(when (or rb-str rd-lin)(return))
				(if (or (string= s "end")(string= s "\}"))
						(decf n)
					(progn
						(incf n)
						(when (= n 1) (save-excursion (goto-bol)(setq p1 (point))))
						)))
			(unless (= n 0) (msgbox "定義の終端じゃないっす！")
				(return-from irb-serch-paragraph  nil))
			)
		p1
		))

(defun ruby-build-summary-of-functions ()
	(let ((result nil)(n 0)(s nil)(rb-str nil)(rd-lin nil)(rb-exp))
    (save-excursion
      (goto-char (point-min))
			(while (multiple-value-setq (s rb-str rd-lin rb-exp)
							 (scan-skip-non-ruby-exp (point-max) rb-exp))
				(when (or rb-str rd-lin)(return))
				(if (or (string= s "end")(string= s "\}"))
						(decf n)
					(progn
						(when (find s '("def" "class" "module") :test #'string=)
							(looking-at "[ \t]+\\([^ \t\n{(]+\\)")
							(push (list
										 (current-line-number)
										 (concat
											(let ((r nil))(dotimes (x n r)(setq r (concat r "  "))))
											s " "(match-string 1))
										 ) result))
						(incf n)
						)))
			(nreverse result)
			)))

(defun ruby-refresh ()
	(interactive)
	(save-excursion (modify-rb-attributes (point-min) (point-max)))
	)

(defun perform-replace (pattern replacement query regexp interactive-p noerror)
	; from "search.l" modified by yukimi_sake@mbi.nifty.com
  (let ((literal (null regexp))
	(count 0)
	(nodup nil)
	(opoint (point))
	(not-found t)
        (def nil)
	(last-match nil)
	(last-match-char nil)
	(undo-bound (or interactive-p query)))
    (undo-boundary)
    (when interactive-p
      (if regexp
	  (setq *last-search-regexp* pattern
		*last-replace-regexp* replacement)
	(setq *last-search-string* pattern
	      *last-replace-string* replacement)))
    (if regexp
	(setq pattern (compile-regexp pattern *case-fold-search*)))
		(if (eq buffer-mode 'ruby-mode)(enable-post-buffer-modified-hook nil))
    (loop
      (unless query
	(long-operation
	  (setq count (+ count
			 (replace-buffer pattern
					 replacement
					 :regexp regexp
					 :no-dup nodup
					 :last-match (cons last-match last-match-char)
					 :case-fold *case-fold-search*
					 :left-bound *word-search*
					 :right-bound *word-search*
					 :literal literal))))
	(when not-found
	  (setq not-found (zerop count)))
	(return))
      (unless (scan-buffer pattern
			   :regexp regexp
			   :no-dup nodup
			   :last-match (cons last-match last-match-char)
			   :case-fold *case-fold-search*
			   :left-bound *word-search*
			   :right-bound *word-search*)
	(return))
      (if (and (eql (match-beginning 0) (match-end 0))
	       (eql last-match (match-beginning 0)))
	  (setq nodup t)
	(progn
	  (setq not-found nil)
	  (show-match)
	  (unless (pos-visible-in-window-p (point))
	    (recenter))
	  (refresh-screen)
	  (message (if (eq def 'help)
		       "(y)置換, (n)スキップ, (!)残り全部, (u)アンドゥ, (C-g)中止, (.)中止して戻る"
		     "置換する?"))
	  (setq def (lookup-keymap *query-replace-map* (read-char *keyboard*) t))
	  (when (cond ((eq def 'act)
		       t)
		      ((eq def 'skip)
		       (setq nodup t)
		       nil)
		      ((eq def 'automatic)
		       (setq query nil)
		       t)
		      ((eq def 'undo)
		       (and (plusp count)
			    (undo)
			    (setq count (1- count)))
		       (setq nodup nil)
		       nil)
		      ((eq def 'quit-and-back)
		       (goto-char opoint)
		       (setq def 'quit)
		       (return))
		      ((eq def 'quit)
		       (return))
		      ((eq def 'recenter)
		       (recenter)
		       (setq nodup nil)
		       nil)
		      ((and (consp def)
			    (eq (car def) 'throw))
		       (throw (cdr def) count))
		      (t (setq def 'help)
			 (setq nodup nil)
			 nil))
	    (setq last-match-char (unless (= (match-end 0) (point-min))
				    (char-before (match-end 0))))
	    (unless (replace-match replacement :literal literal)
	      (return))
	    (setq last-match (point))
	    (setq nodup (= (match-beginning 0) (match-end 0)))
	    (when undo-bound
	      (undo-boundary))
	    (setq count (1+ count)))))
      (when (eobp)
	(return)))
		
    (hide-match)
    (unless noerror
      (and (eq def 'quit)
	   (quit))
      (and not-found
	   (error "文字列が見つかりません")))
    (when (and interactive-p
	       (null *executing-macro*))
      (message "~d個置換しました" count))
		(when (eq buffer-mode 'ruby-mode)
		(save-excursion (modify-rb-attributes (point-min) (point-max)))
		(enable-post-buffer-modified-hook t))
    count))
