;;insert-current-date
(defun wolfand11/insert-current-date ()
    "Insert the current date"
    (interactive "*")
    (insert (format-time-string "Date:%Y-%m-%d Time:%H:%M:%S" (current-time))))
    ;(insert (format-time-string "%Y/%m/%d" (current-time))))

;;cp-buffer-file-name
(defun wolfand11/cp-buffer-file-name (choice)
  "Copy the buffer-file-name to the kill-ring"
  (interactive "cCopy Buffer Name (F) Full, (D) Directory, (N) Name")
  (let ((new-kill-string)
        (name (if (eq major-mode 'dired-mode)
                  (dired-get-filename)
                (or (buffer-file-name) ""))))
    (cond ((eq choice ?f)
           (setq new-kill-string name))
          ((eq choice ?d)
           (setq new-kill-string (file-name-directory name)))
          ((eq choice ?n)
           (setq new-kill-string (file-name-nondirectory name)))
          (t (message "Quit")))
    (when new-kill-string
      (message "%s copied" new-kill-string)
      (kill-new new-kill-string))))

(defun wolfand11/open-in-finder ()
  "Open buffer-file in finder"
  (interactive)
  (let ((name (if (eq major-mode 'dired-mode)
		 (dired-get-filename)
	       (or (buffer-file-name) "./temp.txt")))
	(open-cmd-str (cond ((eq system-type 'darwin) "open")
			((eq system-type 'windows-nt) "explorer")
			((eq system-type 'gnu/linux "nautilus"))
			(t ""))))    
    (if (not (string-equal open-cmd-str ""))
	(shell-command (format "%s %s" open-cmd-str (file-name-directory name))))))

(defun wolfand11/sync-dotspacemacs (choice)
  "sync .spacemacs and dot.spacemacs"
  (interactive "cSync from (.).spacemacs or (D)dot.spacemacs to another")
  (let ((-spacemacs-path "~/.spacemacs")
        (dotspacemacs-path "~/Documents/MyCore/Config/EmacsConfig/dot.spacemacs.el")
        (from-path)
        (to-path))
    (cond ((eq choice ?.)
           (setq from-path -spacemacs-path)
           (setq to-path dotspacemacs-path))
          ((eq choice ?D)
           (setq from-path dotspacemacs-path)
           (setq to-path -spacemacs-path))
          (t (message "Quit")))
    (when (and from-path to-path)
      (message "From %s to %s" (file-name-nondirectory from-path) (file-name-nondirectory to-path))
      (copy-file from-path to-path t))))

(defun wolfand11/get-comment-str(count)
  (let ((coment-str))
    (if comment-start
        (setq comment-str comment-start)
      (setq comment-str "//"))
    (apply 'concat (make-list count (string-trim comment-str)))))

