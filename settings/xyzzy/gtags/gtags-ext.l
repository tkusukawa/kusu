;; -*- Mode: Lisp; Package: EDITOR -*-
;; gtags-ext.l --- extensions

;; Author : bulb <ttomise at gmail dot com>
;; Version: 0.0.0.1

(provide "gtags/gtags-ext")

(in-package "editor")


(export '(gtags-mouse-left-press
          gtags-find-file-ext
          gtags-find-next-tag
          gtags-find-previous-tag
          ))

;;;
;;; interactive command
;;;

(defun gtags-find-next-tag ()
  "Move to next tag"
  (interactive)
  (gtags-pop-stack)
  (next-virtual-line)
  (gtags-select-tag))

(defun gtags-find-previous-tag ()
  "Move to previous tag"
  (interactive)
  (gtags-pop-stack)
  (previous-virtual-line)
  (gtags-select-tag))


(defun gtags-mouse-left-press ()
  "double click"
  (interactive)
  (let ((click (mod *last-mouse-click-count* 6)))
    (if (= click 2)
        (gtags-select-tag)
      (mouse-left-press))))



;;; ヘッダファイルをカーソル直下でタグジャンプ
;;; C/C++のみ
(defun gtags-find-file-ext ()
  "Input pattern and move to the top of the file."
  (interactive)
  (let (tagname prompt input)
    (setq tagname (save-excursion
                     (goto-bol)
                     (and (looking-at "^[ \t]*#[ \t]*include[ \t]*[\<\"]\\(.+\\)[\>\"]")
                          (let ((name (match-string 1)))
                            name))))
    (if tagname
        (setq prompt (concat "Find file: (default " tagname ") "))
      (setq prompt "Find files: "))
    (setq input (read-string prompt))
    (if (not (equal "" input)) (setq tagname input))
    (gtags-push-context)
    (gtags-goto-tag tagname "P")))


#|
;;; ファイルをセーブすると自動でgtags生成
(defvar *gtags-save-buf-cnt* 0)
(defconstant  *gtags-save-buf-cnt-num* 15)

(defun gtags-update ()
  "Type '\\[gtags-file-chk]': the current line's file check gtags."
  (interactive)
  (call-process "global -u"
                :wait nil
                :show :minimize)
  (message "gtags-checked"))

;; C/C++-modeの時だけ実行する
(defun gtags-file-chk ()
  (interactive)
  (if (or (eq buffer-mode 'c++-mode)
          (eq buffer-mode 'c-mode)
          ;(eq buffer-mode 'php-mode)
          (eq buffer-mode 'gtags-mode))
      (progn
        (incf *gtags-save-buf-cnt*)
        (if (<= *gtags-save-buf-cnt-num* *gtags-save-buf-cnt*)
            (progn
              (setq *gtags-save-buf-cnt* 0)
              (gtags-update))))))

;;セーブ後に実行する
(add-hook '*after-save-buffer-hook* 'gtags-file-chk)
|#

;;; gtags-ext.l ends here
