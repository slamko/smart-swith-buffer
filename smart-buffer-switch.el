;; smart-buffer-switch.el -- a set of emacs lisp functions intended to simplify switching between emacs buffers.

;; Copyright (C) 2022 Viacheslav Chepelyk-Kozhin.
;;
;; This program is free software: you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free Software
;; Foundation, either version 3 of the License, or (at your option) any later version.
;; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
;; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.


;; helper functions 

(defun current-buffer-name ()
  (buffer-name (current-buffer)))

(defmacro setq-ifnil (variable value)
  (setq variable (or variable value)))

(defun sys-buffer-p ()
  (string= "*" (substring (current-buffer-name) 0 1)))



(defun smart-buf--switch-to-last-buffer ()
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

(defun smart-buf--switch-to-next-project-buffer ()
  "Switch to next buffer associated with a file opened within the directory tree of the current visited file. "
  (interactive)
  (do-switch-project-buffer 'switch-to-next-buffer))

(defun smart-buf--switch-to-prev-project-buffer ()
  "Switch to previous buffer associated with a file opened within the directory tree of the current visited file. "
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

(defun smart-buf--switch-to-next-sys-buffer ()
  "Switch to next buffer not associated with a file."
  (interactive)
  (do-switch-system-buffer 'switch-to-next-buffer))

(defun smart-buf--switch-to-prev-sys-buffer ()
  "Switch to previous buffer not associated with a file."
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

(defun smart-buf--switch-to-next-user-buffer ()
  "Switch to next buffer created by the user."
  (interactive)
  (do-switch-user-buffer 'switch-to-next-buffer))

(defun smart-buf--switch-to-prev-user-buffer ()
  "Switch to previous buffer created by the user."
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

(defun smart-buf--switch-to-next-dir-buffer ()
  "Switch to next buffer with file manager opened."
  (interactive)
  (do-switch-directory-buffer 'switch-to-next-buffer))

(defun smart-buf--switch-to-prev-dir-buffer ()
  "Switch to previous buffer with file manager opened."
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

(defun smart-buf--switch-to-next-file-buffer ()
  "Switch to next buffer associated with some file."
  (interactive)
  (do-switch-buffer-file 'switch-to-next-buffer))

(defun smart-buf--switch-to-prev-file-buffer ()
  "Switch to previous buffer associated with some file."
  (interactive)
  (do-switch-buffer-file 'switch-to-prev-buffer))
