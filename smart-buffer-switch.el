
;; Smart buffer switch

;;

(defun current-buffer-name ()
  (buffer-name (current-buffer)))


(defmacro setq-ifnil (variable value)
  (setq variable (or variable value)))

(defun sys-buffer-p ()
  (string= "*" (substring (current-buffer-name) 0 1)))

(defun switch-to-last-buffer ()
  (interactive)
  (switch-to-buffer nil))

;; switch to project buffer

(defun do-switch-project-buffer (switch-fun &optional first-buffer project-dir)
  (if (not (string= first-buffer (current-buffer-name)))
	  (progn
 		(setq-ifnil first-buffer (current-buffer-name))
		(setq-ifnil project-dir (file-name-directory buffer-file-name))
		(funcall switch-fun)
		(if (or (not buffer-file-name) (not (string-prefix-p project-dir buffer-file-name)))
			(do-switch-project-buffer switch-fun first-buffer project-dir)))))

(defun switch-to-next-project-buffer ()
  (interactive)
  (do-switch-project-buffer 'switch-to-next-buffer))

(defun switch-to-prev-project-buffer ()
  (interactive)
  (do-switch-project-buffer 'switch-to-prev-buffer))


;; switch to sys buffer

(defun do-switch-system-buffer (switch-fun &optional first-buffer)
  (if (not (string= first-buffer (current-buffer-name)))
	  (progn
		(setq-ifnil first-buffer (current-buffer-name))
		(funcall switch-fun)
		(if (not (sys-buffer-p))
			(do-switch-system-buffer switch-fun first-buffer)))))

(defun switch-to-next-sys-buffer ()
  (interactive)
  (do-switch-system-buffer 'switch-to-next-buffer))

(defun switch-to-prev-sys-buffer ()
  (interactive)
  (do-switch-system-buffer 'switch-to-prev-buffer))


;; switch to user buffer

(defun do-switch-user-buffer (switch-fun &optional first-buffer)
  (if (not (string= first-buffer (current-buffer-name)))
	  (progn
		(setq-ifnil first-buffer (current-buffer-name))
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
   	  (setq-ifnil first-buffer (current-buffer-name))
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
