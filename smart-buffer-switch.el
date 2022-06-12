
;; Smart buffer switch

;;

(defun current-buffer-name ()
  (buffer-name (current-buffer)))

(defun setq-ifnil (variable value)
  (setq variable (or variable value)))

(defun sys-buffer-p ()
  (string= "*" (substring (current-buffer-name) 0 1)))

;; switch to user buffer

(defun do-switch-user-buffer (switch-fun &optional first-buffer)
  (if (not (string= first-buffer (current-buffer-name)))
	  (progn
		(setq first-buffer (or first-buffer (current-buffer-name)))
		(funcall switch-fun)
		(if (sys-buffer-p)
			(do-switch-user-buffer switch-fun first-buffer)))))

(defun switch-to-next-user-buffer ()
  (interactive)
  (do-switch-user-buffer 'switch-to-next-buffer))

(defun switch-to-prev-user-buffer ()
  (interactive)
  (do-switch-user-buffer 'switch-to-prev-buffer))

;; switch to directory buffer

(defun do-switch-directory-buffer (switch-fun &optional first-buffer)
   (if (not (string= first-buffer (current-buffer-name)))
   	(progn
   	  (setq first-buffer (or first-buffer (current-buffer-name)))
   	  (funcall switch-fun)
   	  (if (or (sys-buffer-p) buffer-file-name)
   		  (do-switch-directory-buffer switch-fun first-buffer)))))

(defun switch-to-next-dir-buffer ()
  (interactive)
  (do-switch-directory-buffer 'switch-to-next-buffer))

(defun switch-to-prev-dir-buffer ()
  (interactive)
  (do-switch-directory-buffer 'switch-to-prev-buffer))


;; switch to file buffer

(defun do-switch-buffer-file (switch-fun &optional first-buffer)
  (if (not (string= first-buffer (current-buffer-name)))
	  (progn
		(setq-ifnil first-buffer (current-buffer-name))
		(funcall switch-fun)
		(if (not buffer-file-name)
			(do-switch-buffer-file switch-fun first-buffer)))))

(defun switch-to-next-file-buffer ()
  (interactive)
  (do-switch-buffer-file 'switch-to-next-buffer))

(defun switch-to-prev-file-buffer ()
  (interactive)
  (do-switch-buffer-file 'switch-to-prev-buffer))
