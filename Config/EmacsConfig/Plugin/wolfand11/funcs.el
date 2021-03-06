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

(defun wolfand11/open-in-external-app (&optional @fname)
  "Open the current file or dired marked files in external app.
When called in emacs lisp, if @fname is given, open that.
URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2019-11-04 2021-02-16"
  (interactive)
  (let* (
         ($file-list
          (if @fname
              (progn (list @fname))
            (if (string-equal major-mode "dired-mode")
                (dired-get-marked-files)
              (list (buffer-file-name)))))
         ($do-it-p (if (<= (length $file-list) 5)
                       t
                     (y-or-n-p "Open more than 5 files? "))))
    (when $do-it-p
      (cond
       ((string-equal system-type "windows-nt")
        (mapc
         (lambda ($fpath)
           (shell-command (concat "PowerShell -Command \"Invoke-Item -LiteralPath\" " "'" (shell-quote-argument (expand-file-name $fpath )) "'")))
         $file-list))
       ((string-equal system-type "darwin")
        (mapc
         (lambda ($fpath)
           (shell-command
            (concat "open " (shell-quote-argument $fpath))))  $file-list))
       ((string-equal system-type "gnu/linux")
        (mapc
         (lambda ($fpath) (let ((process-connection-type nil))
                            (start-process "" nil "xdg-open" $fpath))) $file-list))))))

(defun wolfand11/open-in-finder ()
  "Show current file in desktop.
 (Mac Finder, Windows Explorer, Linux file manager)
 This command can be called when in a file or in `dired'.

URL `http://ergoemacs.org/emacs/emacs_dired_open_file_in_ext_apps.html'
Version 2020-02-13"
  (interactive)
  (let (($path (if (buffer-file-name) (buffer-file-name)
                 (shell-quote-argument default-directory))))
    (cond
     ((string-equal system-type "windows-nt")
      (w32-shell-execute "open" default-directory))
     ((string-equal system-type "darwin")
      (if (eq major-mode 'dired-mode)
          (let (($files (dired-get-marked-files )))
            (if (eq (length $files) 0)
                (shell-command (concat "open " (shell-quote-argument default-directory)))
              (shell-command (concat "open -R " (shell-quote-argument (car (dired-get-marked-files )))))))
        (shell-command
         (concat "open -R " $path))))
     ((string-equal system-type "gnu/linux")
      (let (
            (process-connection-type nil)
            (openFileProgram (if (file-exists-p "/usr/bin/gvfs-open")
                                 "/usr/bin/gvfs-open"
                               "/usr/bin/xdg-open")))
        (start-process "" nil openFileProgram $path))
      ;; (shell-command "xdg-open .") ;; 2013-02-10 this sometimes froze emacs till the folder is closed. eg with nautilus
      ))))

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
  "get code comment string"
  (let ((coment-str))
    (if comment-start
        (setq comment-str comment-start)
      (setq comment-str "//"))
    (apply 'concat (make-list count (string-trim comment-str)))))

(defun wolfand11/cd_res()
  (interactive)
  (find-file "~/Documents/MyResource"))

(defun wolfand11/cd_proj()
  (interactive)
  (find-file "~/Documents/MyProject"))

(defun wolfand11/cd_study()
  (interactive)
  (find-file "~/Documents/MyProject/Public/StudyProjects"))

(defun wolfand11/cd_blog()
  (interactive)
  (find-file "~/Documents/MyProject/Public/wolfand11/_post"))

(defun wolfand11/cd_book()
  (interactive)
  (find-file "~/Documents/MyResource/Readings"))

(defun wolfand11/cd_core()
  (interactive)
  (find-file "~/Documents/MyCore"))

(defun wolfand11/cd_config()
  (interactive)
  (find-file "~/Documents/MyCore/Config"))
