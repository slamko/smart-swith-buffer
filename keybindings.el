(load-file "smart-buffer-switch.el")

(global-set-key (kbd "C-<tab>") 'switch-to-next-file-buffer)
(global-set-key (kbd "M-<tab>") 'switch-to-next-user-buffer)
(global-set-key (kbd "C-/") 'switch-to-next-dir-buffer)
(global-set-key (kbd "C-=") 'switch-to-next-project-buffer)

