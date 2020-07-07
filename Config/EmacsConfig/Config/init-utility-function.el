;;insert-current-date
(defun insert-current-date ()
    "Insert the current date"
    (interactive "*")
    (insert (format-time-string "Date:%Y-%m-%d Time:%H:%M:%S" (current-time))))
    ;(insert (format-time-string "%Y/%m/%d" (current-time))))

;;cp-buffer-file-name
(defun cp-buffer-file-name (choice)
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

(provide 'init-utility-function)
