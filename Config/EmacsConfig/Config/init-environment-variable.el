;;
;; 设置默认目录
(setenv default-directory "~/Documents/")

;; 设置PATH环境变量
;; (let ((common-path)
;;       (special-path)
;;       (env-str (getenv "PATH")))
;;   (when (string-equal system-type "darwin") ;; osx
;;     (setq special-path '("/usr/local/bin" "/opt/local/bin" "/opt/local/sbin"))
;;     (setq shell-file-name "/bin/zsh")
;;     )
;;   (when (string-equal system-type "windows-nt")
;;     (setq special-path (list (expand-file-name "~/Applications/cygwin-portable/cygwin/")
;;                              (expand-file-name "~/Applications/cygwin-portable/cygwin/bin/")))
;;     ;;(setq shell-file-name (expand-file-name "~/Applications/cygwin-portable/cygwin/bin/bash.exe"))
;;     )
;;   (when (string-equal system-type "gnu/linux")
;;     (setq special-path '()))

;;   ;; set cross platform tools path
;;   (setq special-path (append special-path (list (expand-file-name "~/Documents/MyCore/Config/EmacsConfig/Resource"))))

;;   (setq env-str (concat (mapconcat 'identity special-path path-separator)
;;                         path-separator
;;                         env-str))
;;   (setenv "PATH" env-str)
;;   (setq exec-path (append special-path exec-path)))

(message "init-env-variable SUCCESSFULL!")
