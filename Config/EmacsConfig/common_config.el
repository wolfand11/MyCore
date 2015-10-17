;; -*- Emacs-Lisp -*-

;; init-userinfomation
(load "init-user-infomation.el")
;; init-environment variable
(load "init-environment-variable.el")
(if is-using-spacemacs
    (load (concat user-emacs-directory "init.el"))
  (progn
    ;; init-buildin-plug
    (load "init-buildin-plug.el")
    ;; init-auto-plug
    (load "init-auto-plug.el")
    ;; init-third-plug
    (load "init-third-plug.el")
    ;; init-emacs-style
    (load "init-emacs-style")
    ;; init-coding-setting
    (load "init-coding-setting")
    ))
; init-utility-function
(load "init-utility-function")
;; init-blog-publish
(load "init-blog-publish")
;; init-my-toolkit
(load "init-my-shortcut")

(put 'upcase-region 'disabled nil)

