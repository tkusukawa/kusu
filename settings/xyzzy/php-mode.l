;;; -*- Mode: Lisp; Package: EDITOR -*-
;;;
;;; This file is not part of xyzzy.
;;;
; $Id: php-mode.l 432 2005-11-24 17:57:10Z torihat $
;
; php-mode.l
;
; by Masashi Hattori

(provide "php-mode")

(in-package "editor")

(export '(php-mode *php-mode-hook* *php-keyword-file* *php-indent-tabs-mode*))

(defvar *php-mode-hook* nil)

(defvar *php-keyword-hash-table* nil)
(defvar *php-keyword-file* "PHP")
(defvar *php-completion-list* nil)

(defvar *php-indent-tabs-mode* nil)
(defvar *php-comment-column* nil)

(defvar *php-mode-syntax-table* nil)
(unless *php-mode-syntax-table*
  (setq *php-mode-syntax-table* (make-syntax-table))
  (do ((x #x21 (1+ x)))((>= x #x7f))
    (let ((c (code-char x)))
      (unless (alphanumericp c)
	(set-syntax-punctuation *php-mode-syntax-table* c))))
  (set-syntax-option *php-mode-syntax-table* 1)
  (set-syntax-string *php-mode-syntax-table* #\")
  (set-syntax-string *php-mode-syntax-table* #\')
  (set-syntax-escape *php-mode-syntax-table* #\\)
  (set-syntax-symbol *php-mode-syntax-table* #\_)
  (set-syntax-symbol *php-mode-syntax-table* #\#)
  (set-syntax-symbol *php-mode-syntax-table* #\<)
  (set-syntax-symbol *php-mode-syntax-table* #\>)
  (set-syntax-symbol *php-mode-syntax-table* #\?)
  (set-syntax-symbol-prefix *php-mode-syntax-table* #\$)
  (set-syntax-match *php-mode-syntax-table* #\( #\))
  (set-syntax-match *php-mode-syntax-table* #\{ #\})
  (set-syntax-match *php-mode-syntax-table* #\[ #\])
  (set-syntax-start-multi-comment *php-mode-syntax-table* "/*")
  (set-syntax-end-multi-comment *php-mode-syntax-table* "*/")
  ;(set-syntax-start-comment *php-mode-syntax-table* #\#)
  ;(set-syntax-end-comment *php-mode-syntax-table* #\LFD nil t)
  (set-syntax-start-c++-comment *php-mode-syntax-table* #\/)
  (set-syntax-end-c++-comment *php-mode-syntax-table* #\LFD)
  )

(defvar *php-mode-map* nil)
(unless *php-mode-map*
  (setq *php-mode-map* (make-sparse-keymap))
  (define-key *php-mode-map* #\{ 'c-electric-insert)
  (define-key *php-mode-map* #\: 'c-electric-insert)
  (define-key *php-mode-map* #\# 'c-electric-insert)
  (define-key *php-mode-map* #\} 'c-electric-close)
  (define-key *php-mode-map* #\C-h 'backward-delete-char-untabify-or-selection)
  (define-key *php-mode-map* #\TAB 'c-indent-line)
  (define-key *php-mode-map* #\M-TAB 'php-completion)
  (define-key *php-mode-map* #\C-M-q 'indent-sexp)
  (define-key *php-mode-map* #\RET 'c-newline-and-indent))

(defvar *php-mode-abbrev-table* nil)
(unless *php-mode-abbrev-table*
  (define-abbrev-table '*php-mode-abbrev-table*))

(defun tags-find-php-point (class name functionp point)
  (goto-char (- point *jump-tag-limit*))
  (and (scan-buffer (concat "^[ \t]*\\(function\\||class\\)[ \t]+"
			    (regexp-quote name)
			    "\\($\\|[ \t\r\n\f#]\\)")
		    :regexp t
		    :case-fold t
		    :limit (+ point *jump-tag-limit*))
       (point)))

(defun php-build-summary-of-functions ()
  (let ((result nil))
    (save-excursion
      (goto-char (point-min))
      (while (scan-buffer "^[ \t]*\\(function\\|class\\)[ \t]+\\([^ \t\n{(]+\\)"
			  :regexp t :tail t)
	(push (list (current-line-number) (match-string 2)) result)))
    (nreverse result)))

(defun php-mode ()
  (interactive)
  (kill-all-local-variables)
  (setq mode-name "PHP")
  (setq buffer-mode 'php-mode)
  (use-syntax-table *php-mode-syntax-table*)
  (use-keymap *php-mode-map*)
  (make-local-variable 'mode-specific-indent-command)
  (setq mode-specific-indent-command #'c-indent-line)
  (make-local-variable 'paragraph-start)
  (setq paragraph-start "^$\\|\f")
  (make-local-variable 'paragraph-separate)
  (setq paragraph-separate paragraph-start)
  (make-local-variable 'indent-tabs-mode)
  (setq indent-tabs-mode *php-indent-tabs-mode*)
  (make-local-variable 'tags-find-target)
  (setq tags-find-target #'c-tags-find-target)
  (make-local-variable 'tags-find-point)
  (setq tags-find-point #'tags-find-php-point)
  (make-local-variable 'build-summary-function)
  (setq build-summary-function 'php-build-summary-of-functions)
  (make-local-variable 'regexp-keyword-list)
  (setq regexp-keyword-list *php-variables-format*)
  (and *php-keyword-file*
       (null *php-keyword-hash-table*)
       (setq *php-keyword-hash-table*
	     (load-keyword-file *php-keyword-file* t)))
  (when *php-keyword-hash-table*
    (make-local-variable 'keyword-hash-table)
    (setq keyword-hash-table *php-keyword-hash-table*))
  (setq *local-abbrev-table* *php-mode-abbrev-table*)
  (setq comment-start "// ")
  (setq comment-end "")
  (setq comment-start-skip "/\\(\\*+\\|/\\)[ \t]*")
  (setq comment-indent-function 'c-comment-indent)
  (when *php-comment-column*
    (setq comment-column *php-comment-column*))
  (run-hooks '*php-mode-hook*))

(pushnew '(php-maketags "*.php" "*.php3" "*.phtml" "*.inc") *maketags-list* :key #'car)

(defun php-maketags (file count)
  (goto-char (point-min))
  (while (scan-buffer "^[ \t]*\\(function\\|class\\)[ \t]+" :regexp t :tail t :case-fold t)
    (do-events)
    (let ((opoint (point)))
      (skip-chars-forward "A-Za-z0-9_")
      (unless (= opoint (point))
	(format t "~A~A~D" (buffer-substring opoint (point)) file opoint)
	(setq count (1+ count)))))
  count)

(defvar *php-variables-format*
  (compile-regexp-keyword-list
   '(
     ("\$[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*"
      t (:keyword 1))
     ("->\\([a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*\\)"
      t (:keyword 1) nil 1 1)
     ("<\\?\\(php\\)?"
      t (:keyword 2 :bold))
     ("\\?>"
      t (:keyword 2 :bold)))))

(defun php-completion ()
  "�L�[���[�h����⊮"
  (interactive)
  (or *php-completion-list*
      (setq *php-completion-list* (make-list-from-keyword-table *php-keyword-hash-table*))
      (return-from php-completion nil))
  (let ((opoint (point)))
    (when (skip-syntax-spec-backward "w_.")
      (let ((from (point)))
	(goto-char opoint)
	(do-completion from opoint :list *php-completion-list*)))))