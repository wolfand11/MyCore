;;
;; 设置默认目录
(setenv default-directory "~/Documents/")

;; 设置PATH变量，这样就可以调用系统的bin了
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/bin")
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/opt/local/sbin")

(when (string-equal system-type "windows-nt")
  (progn
    (setq diff-path (expand-file-name (AppendToEmacsResourcePath "diffutils/bin")))
    (setenv "PATH"
	    (concat diff-path ";"))
    (add-to-list 'exec-path '(diff-path))))

(message "init-env-variable SUCCESSFULL!")
