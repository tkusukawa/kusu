;;; -*- Mode: Lisp; Package: EDITOR -*-
;;; pickup-pattern.l

;; Copyright (C) 2001-2005 OHKUBO Hiroshi <ohkubo@s53.xrea.com>

;; Author: OHKUBO Hiroshi <ohkubo@s53.xrea.com>
;; Version: 0.0.0.6
;; Time-stamp: <2005/10/08 12:11:46 +0900>

;;; Commentary:

;; Description:
;;
;;  ����������/�w�肵���p�^�[���������\�����܂��B
;;  �I���p�^�[��/�S�p�^�[���̋����\���̉����A�ĕ`�悪�\�ł��B
;;

;; Installation:
;;
;;      1. �A�[�J�C�u��W�J���� pickup-pattern.l �� $XYZZY/site-lisp ��
;;         �R�s�[���܂��B
;;
;;      2. �o�C�g�R���p�C�����܂��B
;;
;;              M-x byte-compile-file
;;              Byte compile file: $XYZZY/site-lisp/pickup-pattern.l
;;
;;      3. ~/.xyzzy �܂��� $XYZZY/site-lisp/siteinit.l �Ɉȉ��̃R�[�h��
;;         �ǉ����܂��B
;;
;;              (require "pickup-pattern")
;;
;;      4. �K�v�Ȃ�΃L�[�o�C���h���̐ݒ�̃R�[�h��ǉ����܂��B
;;
;;          ��F
;;          (global-set-key '(#\C-c #\p #\s) 'pickup-pattern-set-input)
;;          (global-set-key '(#\C-c #\p #\C-s) 'pickup-pattern-set-input-detail)
;;          (global-set-key '(#\C-c #\p #\r) 'pickup-pattern-refresh-select)
;;          (global-set-key '(#\C-c #\p #\C-r) 'pickup-pattern-refresh-all)
;;          (global-set-key '(#\C-c #\p #\u) 'pickup-pattern-unset-select)
;;          (global-set-key '(#\C-c #\p #\C-u) 'pickup-pattern-unset-all)
;;          (global-set-key '(#\C-c #\p #\d) 'pickup-pattern-delete-select)
;;          (global-set-key '(#\C-c #\p #\C-d) 'pickup-pattern-delete-all)
;;          (global-set-key '(#\C-c #\p #\l) 'pickup-pattern-list-show)
;;          (global-set-key #\M-s 're-search-forward-pickup)
;;          (global-set-key #\M-C-s 're-search-backward-pickup)
;;          (setq *pickup-pattern-fg* 1)
;;          (setq *pickup-pattern-bg* 3)
;;          (setq *pickup-pattern-bold* t)
;;          (setq *pickup-pattern-underline* nil)
;;          (setq *pickup-pattern-strike-out* nil)
;;          (setq *pickup-pattern-regexp* t)
;;          (setq *pickup-pattern-overlap* nil)
;;          (setq *pickup-pattern-pre-search-unset* t)
;;          (setq *pickup-pattern-search-pattern-add* nil)
;;
;;      5. ��L�̐ݒ�𔽉f�����邽�߂ɁAxyzzy ���ċN�����܂��B
;;         siteinit.l �ɋL�q�����ꍇ�� Ctrl �L�[�� Shift �L�[�������Ȃ���
;;         xyzzy ���ċN�����A�_���v�t�@�C�����č\�z���܂��B
;;

;; Uninstallation:
;;
;;      1. ESC ESC (ed::pickup-pattern-uninstall) �ƃ^�C�v���A
;;         pickup-pattern.l �֘A�̏��� xyzzy ����폜���܂��B
;;
;;      2. pickup-pattern.l �Ɋւ���L�q���폜���܂��B
;;
;;      3. siteinit.l �ɋL�q���Ă����ꍇ�� Ctrl �L�[�� Shift �L�[������
;;         �Ȃ��� xyzzy ���ċN�����A�_���v�t�@�C�����č\�z���܂��B
;;

;; Changes:
;;
;;      [Version 0.0.0.6]
;;      Sat, 08 Oct 2005 12:10:51 +0900
;;        �E���[���A�h���X��ύX�B
;;        �E���C�Z���X����(�C��BSD���C�Z���X)���L�ځB
;;
;;      [Version 0.0.0.5]
;;      Mon, 14 Jun 2004 01:10:48 +0900
;;        �E*pickup-pattern-list* �� history �ϐ��ɕύX�B
;;        �Epickup-pattern-uninstall �ǉ��B
;;        �ENetInstaller �Ή��B
;;
;;      Tue, 19 Feb 2002 12:07:12 +0900
;;        �E�R�����g���C���B
;;
;;      [Version 0.0.0.4]
;;      Thu, 06 Dec 2001 11:42:14 +0900
;;        �E"�O�i�F" �Ə����Ă����Ƃ���� "�����F" �ɕύX�B
;;        �Epickup-pattern-set-input-detail �Ŗ����́A�܂��͕s���ȓ���
;;          �̏ꍇ pickup-pattern �̃f�t�H���g�ݒ�ɏ]���Ă����̂�
;;          nil �ɕύX�B
;;
;;      Thu, 22 Nov 2001 19:13:20 +0900
;;        �EML �ŋT�䂳��ɋ����Ă�������Ƃ���ɂ���
;;          (define-history-variable) ���C���B
;;
;;      [Version 0.0.0.3]
;;      Mon, 19 Nov 2001 23:03:13 +0900
;;        �Ebyte-compile ���Ă��܂Ƃ��ɓ����悤�ɁB
;;        �E*pickup-pattern-set-hook*, *pickup-pattern-unset-all-hook* �ǉ��B
;;        �E��������������X�g�ɒǉ����邩�ǂ�����
;;          *pickup-pattern-search-pattern-add* ��ǉ��B
;;        �Eeditor::*show-match-hook* �Ɉ��������Ďg��
;;          pickup-pattern-last-search ��ǉ��B
;;        �Epickup-pattern-list-show �ǉ��B
;;        �Edocument �� typo �C���B
;;        �E���낢��ƕύX�B
;;
;;      [Version 0.0.0.2]
;;      Fri, 16 Nov 2001 18:01:23 +0900
;;        �Edefstruct ���g������A����ς�o�C�g�R���p�C������Ɠ����Ȃ��B
;;          macro �ւ̗���������Ȃ��B���������ǂ�����΁B
;;        �E�Ȃ�ƂȂ� *pickup-pattern-list* �� export ����̂���߂��B
;;        �E�f�t�H���g�̔z�F�Ȃǂ̐ݒ��ς����B
;;        �Epickup-pattern-set-input-detail �̒ǉ��B
;;        �Epickup-pattern-delete-all �Ŗ₢���킹��悤�ɁB
;;
;;      Fri, 16 Nov 2001 14:01:30 +0900
;;        �E���K�\���� pickup ����p�^�[�����O���[�v������Ă�����A
;;          ��Ԗڂ̃O���[�v�Ƀ}�b�`����������̂� pickup ����悤�ɕύX�B
;;
;;      [Version 0.0.0.1]
;;      Tue, 13 Nov 2001 23:10:02 +0900
;;        �E�ϐ��A�֐��Ƀh�L�������g�̒ǉ��B
;;        �Eeditor package �ɓ��ꂽ�B
;;        �Epickup-string �� pickup-pattern �ɒu���B
;;          Changes �̊Y�������u���B
;;
;;      Tue, 13 Nov 2001 08:33:43 +0900
;;        �E�������� *case-fold-search* �𔽉f����悤�ɁB
;;        �E*pickup-pattern-overlap* �̒ǉ��B
;;        �Ere-search-forward-pickup, re-search-backward-pickup �̒ǉ��B
;;
;;      Fri, 09 Nov 2001 18:30:06 +0900
;;        �Esearch-forward, re-search-forward ���Ɠ��� history ��
;;          �g�p����悤�ɁB
;;
;;      Thu, 08 Nov 2001 17:42:30 +0900
;;        �Epickup-pattern-set-input �̃v�����v�g���C���B
;;
;;      Thu, 08 Nov 2001 15:56:04 +0900
;;        �Etext-attribute �� tag �����ʂ��邽�߂�
;;          *pickup-pattern-identifier* �̒ǉ��B
;;        �E���K�\���������邩�ǂ����̃t���O *pickup-pattern-regexp* �̒ǉ��B
;;        �Epickup-pattern-unset �̋�����ύX�B
;;        �Epickup-pattern-refresh-all, pickup-pattern-unset-all,
;;          pickup-pattern-delete-select, pickup-pattern-delete-all �̒ǉ��B
;;
;;      Wed, 07 Nov 2001 23:42:57 +0900
;;        �E���ō쐬�B

;; Licence:
;;
;;    pickup-pattern �͏C��BSD���C�Z���X�Ɋ�Â��ė��p�\�ł��B
;;    <http://www.opensource.org/licenses/bsd-license.php>
;;
;;
;;    Copyright (C) 2001-2005, OHKUBO Hiroshi.  All rights reserved.
;;
;;    Redistribution and use in source and binary forms, with or without
;;    modification, are permitted provided that the following conditions
;;    are met:
;;
;;    1. Redistributions of source code must retain the above copyright
;;       notice, this list of conditions and the following disclaimer.
;;
;;    2. Redistributions in binary form must reproduce the above copyright
;;       notice, this list of conditions and the following disclaimer in
;;       the documentation and/or other materials provided with the
;;       distribution.
;;
;;    3. Neither the name of the University nor the names of its
;;       contributors may be used to endorse or promote products derived
;;       from this software without specific prior written permission.
;;
;;    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;;    ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;;    LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
;;    A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
;;    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
;;    SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
;;    LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;;    DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;    THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
;;    OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
;;

;;; Code:

(provide "pickup-pattern")

(require "struct")

(in-package "editor")

(export '(*pickup-pattern-fg* *pickup-pattern-bg* *pickup-pattern-bold*
          *pickup-pattern-underline* *pickup-pattern-strike-out*
          *pickup-pattern-regexp* *pickup-pattern-overlap*
          *pickup-pattern-identifier*
          *pickup-pattern-pre-search-unset* *pickup-pattern-search-pattern-add*
          *pickup-pattern-set-hook* *pickup-pattern-unset-all-hook*))

(export '(pickup-pattern-set-input
          pickup-pattern-set-input-detail
          pickup-pattern-refresh-select
          pickup-pattern-refresh-all
          pickup-pattern-unset-select
          pickup-pattern-unset-all
          pickup-pattern-delete-select
          pickup-pattern-delete-all
          pickup-pattern-list-show
          re-search-forward-pickup
          re-search-backward-pickup
          pickup-pattern-last-search))

(defconstant *pickup-pattern-version* "0.0.0.6"
  "pickup-pattern: Version")

(defstruct pickup-pattern-item
  (pattern    nil)
  (name       nil)
  (foreground :default)
  (background :default)
  (bold       :default)
  (underline  :default)
  (strike-out :default)
  (regexp     :default))

(defvar *pickup-pattern-fg* 1
  "pickup-pattern: �����F")
(defvar *pickup-pattern-bg* 3
  "pickup-pattern: �w�i�F")
(defvar *pickup-pattern-bold* t
  "pickup-pattern: �{�[���h�\��")
(defvar *pickup-pattern-underline* nil
  "pickup-pattern: �A���_�[���C���\��")
(defvar *pickup-pattern-strike-out* nil
  "pickup-pattern: �ł��������\��")

(defvar *pickup-pattern-regexp* t
  "pickup-pattern: �p�^�[���𐳋K�\���Ƃ݂Ȃ�")
(defvar *pickup-pattern-overlap* nil
  "pickup-pattern: �I�[�o�[���b�v�����p�^�[���ɂ��}�b�`")
(defvar *pickup-pattern-identifier* 'pickup-pattern
  "pickup-pattern: tag ���ʎq")

(defvar *pickup-pattern-pre-search-unset* t
  "pickup-pattern: �����O�� pickup �\����S�ĉ���")
(defvar *pickup-pattern-search-pattern-add* nil
  "pickup-pattern: ��������������X�g�ɒǉ�")

(define-history-variable *pickup-pattern-list* nil
  "pickup-pattern: pickup �p�^�[���̃��X�g")

(defvar *pickup-pattern-select-string-info-show* nil
  "pickup-pattern: �p�^�[���I�����Ƀf�t�H���g�ȊO�̐ݒ��\��")
(defvar *pickup-pattern-select-string-info-left* " �y"
  "pickup-pattern: �p�^�[���I�����ɕ\��������̍��[������")
(defvar *pickup-pattern-select-string-info-right* "�z"
  "pickup-pattern: �p�^�[���I�����ɕ\��������̉E�[������")
(defvar *pickup-pattern-select-string-info-separator* ", "
  "pickup-pattern: �p�^�[���I�����ɕ\��������̋�؂蕶����")

(defvar *pickup-pattern-set-hook* nil
  "pickup-pattern: pickup ���t�b�N")
(defvar *pickup-pattern-unset-all-hook* nil
  "pickup-pattern: pickup �S�������t�b�N")


(defun pickup-pattern-set-input ()
  "pickup-pattern: ���̓p�^�[���� pickup"
  (interactive)
  (let (pattern pickup-item)
    (setq pattern
          (if *pickup-pattern-regexp*
              (read-string "Re-Pickup: " :default *last-search-regexp*
                           :history 'search)
            (read-string "Pickup: " :default *last-search-string*
                         :history 'search)))
    (when (string/= "" pattern)
      (setq pickup-item
            (make-pickup-pattern-item :pattern pattern
                                      :regexp *pickup-pattern-regexp*))
      (pickup-pattern-set pickup-item *pickup-pattern-overlap*)
      (setq *pickup-pattern-list*
            (delete pickup-item *pickup-pattern-list* :test 'equalp))
      (pushnew pickup-item *pickup-pattern-list* :test 'equalp)
      (if *pickup-pattern-regexp*
          (setq *last-search-regexp* pattern)
        (setq *last-search-string* pattern)))))

(defun pickup-pattern-set-input-detail ()
  "pickup-pattern: ���̓p�^�[�����w�肵���������@�� pickup"
  (interactive)
  (let (pickup-item input
        pattern name foreground background bold underline strike-out)
    (setq pattern
          (if *pickup-pattern-regexp*
              (read-string "Re-Pickup: " :default *last-search-regexp*
                           :history 'search)
            (read-string "Pickup: " :default *last-search-string*
                         :history 'search)))
    (when (string/= "" pattern)
      (setq name (read-string "�I�����\����: " :default pattern))
      (if (string= "" (string-trim " " name))
          (setq name pattern))
      (setq input (read-string (format nil "�����F (0-15): ")))
      (if (string-match "[0-9]+" input)
          (setq foreground (parse-integer (match-string 0)))
        (setq foreground nil))
      (setq input (read-string (format nil "�w�i�F (0-15): ")))
      (if (string-match "[0-9]+" input)
          (setq background (parse-integer (match-string 0)))
        (setq background nil))
      (setq input (string-trim " " (read-string (format nil "Bold (yes or no): "))))
      (cond
       ((string-match "^\\([yY]\\|[yY][eE][sS]\\)$" input) (setq bold t))
       ((string-match "^\\([nN]\\|[nN][oO]\\)$" input) (setq bold nil))
       (t (setq bold nil)))
      (setq input (string-trim " " (read-string (format nil "Underline (yes or no): "))))
      (cond
       ((string-match "^\\([yY]\\|[yY][eE][sS]\\)$" input) (setq underline t))
       ((string-match "^\\([nN]\\|[nN][oO]\\)$" input) (setq underline nil))
       (t (setq underline nil)))
      (setq input (string-trim " " (read-string (format nil "Strike-Out (yes or no): "))))
      (cond
       ((string-match "^\\([yY]\\|[yY][eE][sS]\\)$" input) (setq strike-out t))
       ((string-match "^\\([nN]\\|[nN][oO]\\)$" input) (setq strike-out nil))
       (t (setq strike-out nil)))

      (setq pickup-item
            (make-pickup-pattern-item :pattern    pattern
                                      :name       name
                                      :foreground foreground
                                      :background background
                                      :bold       bold
                                      :underline  underline
                                      :strike-out strike-out
                                      :regexp     *pickup-pattern-regexp*))
      (pushnew pickup-item *pickup-pattern-list* :test 'equalp)
      (pickup-pattern-set pickup-item *pickup-pattern-overlap*)
      (if *pickup-pattern-regexp*
          (setq *last-search-regexp* pattern)
        (setq *last-search-string* pattern)))))

(defun pickup-pattern-set (pickup-item overlap &optional (whole-pickup nil))
  "pickup-pattern: �p�^�[���� pickup
�����F
  �Epickup-item: ��������n����悤�ɂȂ��Ă��邪�A
    ��{�I�� pickup-pattern-item �\���̂�n���B
  �Eoverlap: nil �̏ꍇ��x�}�b�`����������ɂ̓}�b�`���Ȃ��B
  �Ewhole-pickup: t �̏ꍇ�p�^�[�������K�\�����O���[�v������Ă��Ă��A
    �}�b�`����������S�̂� pickup ����B"
  (let (pattern
        pattern-fg pattern-bg pattern-bold pattern-underline pattern-strike-out
        pattern-regexp)
    (cond
     ((stringp pickup-item)
      (setq pattern pickup-item)
      (setq pattern-regexp *pickup-pattern-regexp*)
      (setq pattern-fg *pickup-pattern-fg*)
      (setq pattern-bg *pickup-pattern-bg*)
      (setq pattern-bold *pickup-pattern-bold*)
      (setq pattern-underline *pickup-pattern-underline*)
      (setq pattern-strike-out *pickup-pattern-strike-out*))
     ((pickup-pattern-item-p pickup-item)
      (setq pattern (pickup-pattern-item-pattern pickup-item))
      (setq pattern-regexp (pickup-pattern-item-regexp pickup-item))
      (setq pattern-fg (pickup-pattern-item-foreground pickup-item))
      (setq pattern-bg (pickup-pattern-item-background pickup-item))
      (setq pattern-bold (pickup-pattern-item-bold pickup-item))
      (setq pattern-underline (pickup-pattern-item-underline pickup-item))
      (setq pattern-strike-out (pickup-pattern-item-strike-out pickup-item))
      (if (eq pattern-regexp :default)
          (setq pattern-regexp *pickup-pattern-regexp*))
      (if (eq pattern-fg :default)
          (setq pattern-fg *pickup-pattern-fg*))
      (if (eq pattern-bg :default)
          (setq pattern-bg *pickup-pattern-bg*))
      (if (eq pattern-bold :default)
          (setq pattern-bold *pickup-pattern-bold*))
      (if (eq pattern-underline :default)
          (setq pattern-underline *pickup-pattern-underline*))
      (if (eq pattern-strike-out :default)
          (setq pattern-strike-out *pickup-pattern-strike-out*))
      ))
    (when pattern
      (save-excursion
        (goto-char (point-min))
        (while (scan-buffer pattern
                            :regexp pattern-regexp
                            :case-fold *case-fold-search*)
          (if (and pattern-regexp (not whole-pickup) (match-beginning 1))
              (set-text-attribute (match-beginning 1) (match-end 1)
                                  (cons *pickup-pattern-identifier* pickup-item)
                                  :foreground pattern-fg
                                  :background pattern-bg
                                  :bold       pattern-bold
                                  :underline  pattern-underline
                                  :strike-out pattern-strike-out)
            (set-text-attribute (match-beginning 0) (match-end 0)
                                (cons *pickup-pattern-identifier* pickup-item)
                                :foreground pattern-fg
                                :background pattern-bg
                                :bold       pattern-bold
                                :underline  pattern-underline
                                :strike-out pattern-strike-out))
          (if overlap (forward-char) (goto-char (match-end 0)))))))
    (run-hooks '*pickup-pattern-set-hook*))

(defun pickup-pattern-make-select-list ()
  (let (select-list display-string info-list (i 1))
    (dolist (pickup-item *pickup-pattern-list*)
      (cond
       ((stringp pickup-item)
        (setq display-string (format nil "~2,'0D: ~A" i pickup-item))
        (setq display-string (concat display-string " (all default)")))
       ((pickup-pattern-item-p pickup-item)
        (setq display-string (format nil "~2,'0D: ~A" i
                                     (cond
                                      ((pickup-pattern-item-name pickup-item))
                                      ((pickup-pattern-item-pattern pickup-item)))))
        (when *pickup-pattern-select-string-info-show*
          (setq info-list nil)
          (if (and (stringp (pickup-pattern-item-name pickup-item))
                   (string/= (pickup-pattern-item-name pickup-item)
                             (pickup-pattern-item-pattern pickup-item)))
              (push (format nil "PT: ~S" (pickup-pattern-item-pattern pickup-item)) info-list))
          (unless (eq (pickup-pattern-item-foreground pickup-item) :default)
            (push (format nil "FG: ~S" (pickup-pattern-item-foreground pickup-item)) info-list))
          (unless (eq (pickup-pattern-item-background pickup-item) :default)
            (push (format nil "BG: ~S" (pickup-pattern-item-background pickup-item)) info-list))
          (unless (eq (pickup-pattern-item-bold pickup-item) :default)
            (push (format nil "B: ~S" (pickup-pattern-item-bold pickup-item)) info-list))
          (unless (eq (pickup-pattern-item-underline pickup-item) :default)
            (push (format nil "U: ~S" (pickup-pattern-item-underline pickup-item)) info-list))
          (unless (eq (pickup-pattern-item-strike-out pickup-item) :default)
            (push (format nil "S: ~S" (pickup-pattern-item-strike-out pickup-item)) info-list))
          (when info-list
            (setq display-string
                  (concat display-string
                          *pickup-pattern-select-string-info-left*
                          (pickup-pattern-join-string-list
                           *pickup-pattern-select-string-info-separator*
                           (nreverse info-list))
                          *pickup-pattern-select-string-info-right*)))))
       (t (push "" select-list)))
      (push display-string select-list)
      (incf i))
    (nreverse select-list)))

(defun pickup-pattern-refresh-select ()
  "pickup-pattern: �I���p�^�[���� pickup �\�����ĕ`��"
  (interactive)
  (if (null *pickup-pattern-list*)
      (message "�p�^�[�����o�^����Ă��܂���")
    (popup-list (pickup-pattern-make-select-list)
                #'(lambda (string)
                    (let (index pickup-item)
                      (when (string-match "\\(.*?\\)0*\\([1-9][0-9]*\\): \\(.*\\)" string)
                        (setq index (parse-integer (match-string 2)))
                        (setq pickup-item (nth (1- index) *pickup-pattern-list*))
                        (pickup-pattern-set pickup-item *pickup-pattern-overlap*)
                        (setq *pickup-pattern-list*
                              (nconc
                               (subseq *pickup-pattern-list* 0 (1- index))
                               (subseq *pickup-pattern-list* index)))
                        (push pickup-item *pickup-pattern-list*)
                        (refresh-screen))))
                (point))))

(defun pickup-pattern-refresh-all ()
  "pickup-pattern: �S�p�^�[���� pickup �\�����ĕ`��"
  (interactive)
  (dolist (pickup-item (reverse *pickup-pattern-list*))
    (pickup-pattern-set pickup-item *pickup-pattern-overlap*)))

(defun pickup-pattern-unset (pickup-item)
  "pickup-pattern: �p�^�[���� pickup �\��������"
  (delete-text-attributes pickup-item :test
                          #'(lambda (pickup-item tag)
                              (if (and (consp tag)
                                       (eq (car tag) *pickup-pattern-identifier*)
                                       (equalp (cdr tag) pickup-item))
                                  t nil))))

(defun pickup-pattern-unset-select ()
  "pickup-pattern: �I���p�^�[���� pickup �\��������"
  (interactive)
  (if (null *pickup-pattern-list*)
      (message "�p�^�[�����o�^����Ă��܂���")
    (popup-list (pickup-pattern-make-select-list)
                #'(lambda (string)
                    (let (index pickup-item)
                      (when (string-match "\\(.*?\\)0*\\([1-9][0-9]*\\): \\(.*\\)" string)
                        (setq index (parse-integer (match-string 2)))
                        (setq pickup-item (nth (1- index) *pickup-pattern-list*))
                        (pickup-pattern-unset pickup-item)
                        (setq *pickup-pattern-list*
                              (nconc
                               (subseq *pickup-pattern-list* 0 (1- index))
                               (subseq *pickup-pattern-list* index)))
                        (push pickup-item *pickup-pattern-list*)
                        (refresh-screen))))
                (point))))

(defun pickup-pattern-unset-all ()
  "pickup-pattern: �S�p�^�[���� pickup �\��������"
  (interactive)
  (delete-text-attributes nil :test
                          #'(lambda (pickup-item tag)
                              (if (and (consp tag)
                                       (eq (car tag) *pickup-pattern-identifier*))
                                  t nil)))
  (run-hooks '*pickup-pattern-unset-all-hook*))

(defun pickup-pattern-delete-select ()
  "pickup-pattern: �I���p�^�[���� pickup �\�������������X�g����폜"
  (interactive)
  (if (null *pickup-pattern-list*)
      (message "�p�^�[�����o�^����Ă��܂���")
    (popup-list (pickup-pattern-make-select-list)
                #'(lambda (string)
                    (let (index pickup-item)
                      (when (string-match "\\(.*?\\)0*\\([1-9][0-9]*\\): \\(.*\\)" string)
                        (setq index (parse-integer (match-string 2)))
                        (setq pickup-item (nth (1- index) *pickup-pattern-list*))
                        (pickup-pattern-unset pickup-item)
                        (setq *pickup-pattern-list*
                              (nconc
                               (subseq *pickup-pattern-list* 0 (1- index))
                               (subseq *pickup-pattern-list* index)))
                        (refresh-screen))))
                (point))))

(defun pickup-pattern-delete-all ()
  "pickup-pattern: �S�p�^�[���� pickup �\�������������X�g����폜"
  (interactive)
  (when (and *pickup-pattern-list*
             (string-match "^\\([yY]\\|[yY][eE][sS]\\)"
                           (read-string "�S�p�^�[�����폜���Ă悢�ł����H(yes/no): ")))
    (pickup-pattern-unset-all)
    (setq *pickup-pattern-list* nil)))

(defun re-search-forward-pickup (regexp &optional noerror)
  "pickup-pattern: ���K�\���O������ & pickup �\��"
  (interactive "sRe-search forward: "
    :default0 *last-search-regexp* :history0 'search)
  (let (pickup-item)
    (if *pickup-pattern-pre-search-unset*
        (pickup-pattern-unset-all))
    (setq pickup-item (make-pickup-pattern-item :pattern regexp :regexp  t))
    (pickup-pattern-set pickup-item t t)
    (when (and *pickup-pattern-search-pattern-add* (string/= "" regexp))
      (setq *pickup-pattern-list*
            (delete pickup-item *pickup-pattern-list* :test 'equalp))
      (pushnew pickup-item *pickup-pattern-list* :test 'equalp))
    (search-command regexp nil t (interactive-p) noerror)))

(defun re-search-backward-pickup (regexp &optional noerror)
  "pickup-pattern: ���K�\��������� & pickup �\��"
  (interactive "sRe-search backward: "
    :default0 *last-search-regexp* :history0 'search)
  (let (pickup-item)
    (if *pickup-pattern-pre-search-unset*
        (pickup-pattern-unset-all))
    (setq pickup-item (make-pickup-pattern-item :pattern regexp :regexp  t))
    (pickup-pattern-set pickup-item t t)
    (when (and *pickup-pattern-search-pattern-add* (string/= "" regexp))
      (setq *pickup-pattern-list*
            (delete pickup-item *pickup-pattern-list* :test 'equalp))
      (pushnew pickup-item *pickup-pattern-list* :test 'equalp))
    (search-command regexp t t (interactive-p) noerror)))

(defun pickup-pattern-last-search ()
  "pickup-pattern: editor::*show-match-hook* �p function"
  (let (pickup-item)
    (if *pickup-pattern-pre-search-unset*
        (pickup-pattern-unset-all))
    (if *last-search-regexp-p*
        (setq pickup-item (make-pickup-pattern-item :pattern *last-search-regexp*
                                                    :regexp t))
      (setq pickup-item (make-pickup-pattern-item :pattern *last-search-string*
                                           :regexp nil)))
    (when *pickup-pattern-search-pattern-add*
      (setq *pickup-pattern-list*
            (delete pickup-item *pickup-pattern-list* :test 'equalp))
      (pushnew pickup-item *pickup-pattern-list* :test 'equalp))
    (pickup-pattern-set pickup-item t t))
  t)

(defun pickup-pattern-list-show ()
  "pickup-pattern: �p�^�[�����X�g�̕\��"
  (interactive)
  (let ((current-buffer-mode buffer-mode) (i 1) info-list
        pattern pattern-fg pattern-bg pattern-bold pattern-underline
        pattern-strike-out pattern-regexp)
    (delete-other-windows)
    (split-window)
    (switch-to-buffer "*PickupPatternShow*")
    (kill-all-local-variables)
    (setq buffer-mode current-buffer-mode)
    (setq mode-name "PickupPatternShow")
    (make-local-variable 'need-not-save)
    (setq need-not-save t)
    (make-local-variable 'auto-save)
    (setq auto-save nil)

    (erase-buffer (selected-buffer))
    (dolist (pickup-item *pickup-pattern-list*)
      (setq info-list nil)
      (cond
       ((stringp pickup-item)
        (setq pattern pickup-item)
        (setq pattern-regexp *pickup-pattern-regexp*)
        (setq pattern-fg *pickup-pattern-fg*)
        (setq pattern-bg *pickup-pattern-bg*)
        (setq pattern-bold *pickup-pattern-bold*)
        (setq pattern-underline *pickup-pattern-underline*)
        (setq pattern-strike-out *pickup-pattern-strike-out*))
       ((pickup-pattern-item-p pickup-item)
        (setq pattern (pickup-pattern-item-pattern pickup-item))
        (setq pattern-regexp (pickup-pattern-item-regexp pickup-item))
        (setq pattern-fg (pickup-pattern-item-foreground pickup-item))
        (setq pattern-bg (pickup-pattern-item-background pickup-item))
        (setq pattern-bold (pickup-pattern-item-bold pickup-item))
        (setq pattern-underline (pickup-pattern-item-underline pickup-item))
        (setq pattern-strike-out (pickup-pattern-item-strike-out pickup-item))
        (if (eq pattern-regexp :default)
            (setq pattern-regexp *pickup-pattern-regexp*)
          (push (format nil "R: ~S" pattern-regexp) info-list))
        (if (eq pattern-fg :default)
            (setq pattern-fg *pickup-pattern-fg*)
          (push (format nil "FG: ~S" pattern-fg) info-list))
        (if (eq pattern-bg :default)
            (setq pattern-bg *pickup-pattern-bg*)
          (push (format nil "BG: ~S" pattern-bg) info-list))
        (if (eq pattern-bold :default)
            (setq pattern-bold *pickup-pattern-bold*)
          (push (format nil "B: ~S" pattern-bold) info-list))
        (if (eq pattern-underline :default)
            (setq pattern-underline *pickup-pattern-underline*)
          (push (format nil "U: ~S" pattern-underline) info-list))
        (if (eq pattern-strike-out :default)
            (setq pattern-strike-out *pickup-pattern-strike-out*)
          (push (format nil "S: ~S" pattern-strike-out) info-list))
        ))

      (insert (format nil "��~2,'0D: " i))
      (cond
       ((stringp pickup-item)
        (set-text-attribute (point)
                            (progn (insert (format nil "~A~%" pickup-item)) (point))
                            nil
                            :foreground pattern-fg
                            :background pattern-bg
                            :bold       pattern-bold
                            :underline  pattern-underline
                            :strike-out pattern-strike-out)
        (insert (format nil "~A~%" pickup-item)))
       ((pickup-pattern-item-p pickup-item)
        (set-text-attribute (point)
                            (progn
                              (insert (format nil  "~A"
                                              (cond
                                               ((pickup-pattern-item-name pickup-item))
                                               ((pickup-pattern-item-pattern pickup-item)))))
                              (point))
                            nil
                            :foreground pattern-fg
                            :background pattern-bg
                            :bold       pattern-bold
                            :underline  pattern-underline
                            :strike-out pattern-strike-out)
        (insert (format nil "~A~%"
                        (if info-list
                            (concat *pickup-pattern-select-string-info-left*
                                    (pickup-pattern-join-string-list
                                     *pickup-pattern-select-string-info-separator*
                                     (nreverse info-list))
                                    *pickup-pattern-select-string-info-right*)
                          "")))
        (insert (format nil "~A~%" (pickup-pattern-item-pattern pickup-item)))))
      (incf i))
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (other-window)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; �ėp�֐�
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; join
(defun pickup-pattern-join-string-list (join str-list)
  (let ((return-str "") (cnt (length str-list)))
    (dolist (str str-list)
      (incf cnt -1)
      (when (stringp str)
        (setq return-str (concat return-str str (if (> cnt 0) join "")))))
    return-str))

#|
(global-set-key '(#\C-c #\p #\s) 'pickup-pattern-set-input)
(global-set-key '(#\C-c #\p #\C-s) 'pickup-pattern-set-input-detail)
(global-set-key '(#\C-c #\p #\r) 'pickup-pattern-refresh-select)
(global-set-key '(#\C-c #\p #\C-r) 'pickup-pattern-refresh-all)
(global-set-key '(#\C-c #\p #\u) 'pickup-pattern-unset-select)
(global-set-key '(#\C-c #\p #\C-u) 'pickup-pattern-unset-all)
(global-set-key '(#\C-c #\p #\d) 'pickup-pattern-delete-select)
(global-set-key '(#\C-c #\p #\C-d) 'pickup-pattern-delete-all)
(global-set-key '(#\C-c #\p #\l) 'pickup-pattern-list-show)
(global-set-key #\M-s 're-search-forward-pickup)
(global-set-key #\M-C-s 're-search-backward-pickup)
|#

;; uninstall
(defun pickup-pattern-uninstall ()
  (let ((history-variables
         '(*pickup-pattern-list*)))
    (dolist (variable history-variables)
      (unregister-history-variable variable))))

;;; pickup-pattern.l ends here