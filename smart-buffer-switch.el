
;; Smart buffer switch

(defun do-switch-buffer-file (switch-fun)
  (funcall switch-fun)
  (if (string= "*" (substring (buffer-name (current-buffer)) 0 1))
	  (do-switch-buffer-file)))

(defun switch-to-next-file-buffer ()
  (interactive)
  (do-switch-buffer-file 'switch-to-next-buffer))

(defun switch-to-prev-file-buffer ()
  (interactive)
  (do-switch-buffer-file 'switch-to-prev-buffer))

;; (global-set-key (kbd "M-<tab>") 'switch-to-next-file-buffer)
