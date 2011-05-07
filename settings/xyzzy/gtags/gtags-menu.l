;; -*- Mode: Lisp; Package: EDITOR -*-
;; gtags-menu.l --- gtags facility for xyzzy

;; Author : bulb <ttomise at gmail dot com>
;; Version: 0.0.0.1


;;; Code

(provide "gtags/gtags-menu")

(in-package "editor")

(export '(make-gtags-file
          make-gtags-file-dialog
          ))

(defvar *make-gtags-menu* nil)

(defvar *gtags-cmd* "gtags -v")
(defvar *gtags-incremental-cmd* "global -u -v")
(defvar *htags-cmd* "htags -saF")
(defvar *gtags-buf-name* "*GTAGS Output*")
(defvar *gtags-file-name* "GTAGS")

(defvar *make-gtags-file-dialog-template*
  '(dialog 0 0 230 100
    (:caption "GNU GLOBAL")
    (:font 9 "MS UI GOTHIC")
    (:control
     (:static nil "GTAGS�t�@�C�������\�[�X�f�B���N�g��:" #x50020000 7 7 120 10)
     (:edit src nil #x50810080 7 19 148 14)
     (:button IDOK "OK" #x50010001 169 7 50 14)
     (:button IDCANCEL "�L�����Z��" #x50010000 169 24 50 14)
     (:button ref "�Q��(&R)..." #x50010000 169 41 50 14))))


(defvar *make-gtags-menu-p* t)
(defun gtags-setup-menu ()
  (if *make-gtags-menu-p*
      (let ((tools (get-menu *app-menu* 'ed::tools)))
        (insert-menu-item tools
                          (get-menu-position tools ':|above-(>_<)|)
                          'gtags "GTAGS�t�@�C���̍쐬(&G)" 'make-gtags-file-dialog))))

(add-hook '*init-app-menus-hook* 'gtags-setup-menu)


;;;
;;; interactive command
;;;

; ksworks������Q�l�ɂ����Ē����Ă��܂��B
; http://www.ksworks.org/memo/xyzzy/global.htm

(defun make-gtags-file (dir)
  (interactive "DMake GTAGS file: \np")
  (setq dir (append-trail-slash (namestring dir)))
  (let ((file (merge-pathnames *gtags-file-name* dir)))
    (if (file-exist-p file)
        (progn
          (execute-subprocess *gtags-incremental-cmd*
                              :bufname *gtags-buf-name*
                              :directory dir))
      (progn
        (execute-subprocess *gtags-cmd*
                            :bufname *gtags-buf-name*
                            :directory dir)))))

(defun make-gtags-file-dialog ()
  (interactive)
  (multiple-value-bind (result data)
      (dialog-box *make-gtags-file-dialog-template*
                  (list
                   (cons 'src (default-directory))
                   )
                  '((src :non-null "�\�[�X�f�B���N�g������͂���" :enable (IDOK))
                    (ref :related src :directory-name-dialog (:title "�Q��"))))
    (when result
      (progn
        (make-gtags-file (cdr (assoc 'src data)))))))

;;; gtags-menu.l ends here