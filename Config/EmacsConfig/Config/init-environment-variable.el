;;
;; 设置默认目录
(setenv default-directory "~/Documents/")

;; 设置 custom config path
(setq custom-file "~/.custom.el")

(let ((common-path)
      (special-path)
      (env-str (getenv "PATH")))
  (when (string-equal system-type "darwin") ;; osx
    (setq special-path '("/usr/local/bin" "/opt/local/bin" "/opt/local/sbin")))
  (when (string-equal system-type "windows-nt")
    (setq special-path (list (expand-file-name (AppendToEmacsResourcePath "diffutils/bin")))))
  (when (string-equal system-type "gnu/linux")
    (setq special-path '()))
  (setq env-str (concat (mapconcat 'identity special-path path-separator)
                        path-separator
                        env-str))
  (setenv "PATH" env-str)
  (setq exec-path (append special-path exec-path)))

(message "init-env-variable SUCCESSFULL!")
