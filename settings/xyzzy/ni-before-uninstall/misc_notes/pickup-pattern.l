;;; -*- Mode: Lisp; Package: user -*-
;;; pickup-pattern.l --- pickup-pattern.l �� uninstall �p���W���[��

;; Copyright (C) 2001-2005 OHKUBO Hiroshi <ohkubo@s53.xrea.com>

;; Author: OHKUBO Hiroshi <ohkubo@s53.xrea.com>
;; Time-stamp: <2005/10/08 12:14:50 +0900>

;; Description:
;;
;;     pickup-pattern.l �� uninstall �p���W���[��
;;

(require "pickup-pattern")
(ed::pickup-pattern-uninstall)

;; �A�b�v�f�[�g�� history ���ێ����邽��(�̕z��)
(setq lisp::*modules*
      (delete "pickup-pattern" lisp::*modules* :test 'string-equal))

;;; pickup-pattern.l ends here