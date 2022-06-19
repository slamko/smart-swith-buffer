(add-to-list 'load-path ".")
(require 'smart-buffer-switch)

(global-set-key (kbd "C-<tab>") 'smart-buf--switch-to-next-file-buffer)
(global-set-key (kbd "M-<tab>") 'smart-buf--switch-to-next-user-buffer)
(global-set-key (kbd "C-/") 'smart-buf--switch-to-next-dir-buffer)
(global-set-key (kbd "C-=") 'smart-buf--switch-to-next-project-buffer)
(global-set-key (kbd "M-<backspace>") 'smart-buf--switch-to-last-buffer)
(define-key mode-specific-map (kbd "s") 'smart-buf--switch-to-scratch-buffer)
