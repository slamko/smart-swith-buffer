
;; Smart buffer switch

;;

(defun current-buffer-name ()
  (buffer-name (current-buffer)))

(defmacro setq-ifnil (variable value)
  (setq variable (or variable value)))

(defun do-switch-buffer-file (switch-fun &optional first-buffer)
  (if (not (string= first-buffer (current-buffer-name)))
  (funcall switch-fun)
  (setq-ifnil first-buffer (current-buffer-name)))
  (if (or (string= "*" (substring (current-buffer-name) 0 1))
		   (string= "%" (substring (current-buffer-name) 0 1)))
	  (do-switch-buffer-file switch-fun first-buffer))))
  
(defun do-switch-buffer-file (switch-fun &optional first-buffer)
  (if (not (string= first-buffer (current-buffer-name)))
  (funcall switch-fun)
  (setq-ifnil first-buffer (current-buffer-name)))
  (if (not buffer-file-name)
	  (do-switch-buffer-file switch-fun first-buffer))))

(defun switch-to-next-file-buffer ()
  (interactive)
  (do-switch-buffer-file 'switch-to-next-buffer))

(defun switch-to-prev-file-buffer ()
  (interactive)
  (do-switch-buffer-file 'switch-to-prev-buffer))

 (global-set-key (kbd "M-<tab>") 'switch-to-next-file-buffer)
