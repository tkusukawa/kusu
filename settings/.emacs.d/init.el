(define-key global-map "\C-z" 'undo)
(define-key global-map "\C-q" 'kill-ring-save)
(define-key global-map "\C-i" 'isearch-forward)
(define-key global-map "\C-s" 'save-buffer)
(setq make-backup-files nil)
(setq auto-save-default nil)