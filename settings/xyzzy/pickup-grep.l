;Grepの時強調表示

(provide "pickup-grep")

;(require "pickup-pattern")

(in-package "editor")

(defvar *error-pattern* nil)
(defvar *error-add-pickup-pattern-list* nil);;; tだと、*pickup-pattern-list*に、
;;; F10,F11した検索文字列が追加される

(defun goto-error (next)
  (when (and next *error-list*)
    (setq *rerror-list* (cons (car *error-list*) *rerror-list*))
    (setq *error-list* (cdr *error-list*)))
  (when (and *rerror-list*
	     (null *error-list*))
    (rebuild-error-list))
  (when *error-list*
    (let ((error (car *error-list*)))
      (if (= (count-windows 'arg) 1)
	  (progn
	    (split-window t);;; ここをtにするとF10を押した時、画面が横に２分割される。
	    ;;; grep バッファのウィンドウを指定のサイズにしたい場合は
	    ;;; split-window の後の t を *error-window-size* に変えてください。
	    (set-buffer *error-buffer*))
	(pop-to-buffer *error-buffer*))
      (goto-line (cdr error))
      (reverse-region (progn (goto-eol) (point))
		      (progn (goto-bol) (point)))
      (recenter)
      (let ((scanner (and *highlight-error* *find-error-scanner*)))
	(other-window)
	(set-buffer (marker-buffer (car error)))
	(goto-marker (car error))
	(and scanner
	     (funcall scanner (save-excursion (goto-eol) (point)))
	     (eq *highlight-error* t)
	     (show-match)))
      (recenter)
      (when *error-pattern*
	(let ((pickup-item (make-pickup-pattern-item :pattern (car *error-pattern*)
						     :regexp (cdr *error-pattern*))))
	  (pickup-pattern-set pickup-item t)
	  (setq *last-search-string* (car *error-pattern*))
	  (when *error-add-pickup-pattern-list*
	    (setq *pickup-pattern-list*
		  (delete pickup-item *pickup-pattern-list* :test 'equalp))
	    (pushnew pickup-item *pickup-pattern-list* :test 'equalp))
	  )) t)))

(defun pickup-grep ()
  (setq *error-pattern*
	(cons (car *minibuffer-search-string-history*)
	      (cond
	       ((equal *this-command* 'grep) t)
	       ((equal *this-command* 'fgrep) nil)
	       (t *grep-regexp-search*))))
  (save-excursion
    (dolist (buffer (buffer-list))
      (set-buffer buffer)
      (pickup-pattern-unset-all))))

(add-hook '*grep-hook* 'pickup-grep)
(add-hook '*grepd-hook* 'pickup-grep)

;(in-package "user")
