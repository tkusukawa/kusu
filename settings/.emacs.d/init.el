(define-key global-map "\C-z" 'undo)
(define-key global-map "\C-q" 'kill-ring-save)
;(define-key global-map "\C-i" 'isearch-forward)
;(define-key global-map "\C-s" 'save-buffer)
(setq make-backup-files nil)
(setq auto-save-default nil)
(add-hook 'shell-mode-hook
          '(lambda ()
             (progn
               ;; (define-key shell-mode-map (kbd "C-p") 'comint-previous-input)
               ;; (define-key shell-mode-map (kbd "C-n") 'comint-next-input)
               (define-key shell-mode-map (kbd "C-p") 'comint-previous-matching-input-from-input)
               (define-key shell-mode-map (kbd "C-n") 'comint-next-matching-input-from-input)
               )))
