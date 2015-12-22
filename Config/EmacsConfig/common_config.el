;; -*- Emacs-Lisp -*-

;; init-user-infomation
(load "init-user-infomation.el")
;; init-environment-variable
(load "init-environment-variable.el")

(load (concat user-emacs-directory "init.el"))

;; ; init-utility-function
(load "init-utility-function")
;; init-my-toolkit
(load "init-my-shortcut")

(put 'upcase-region 'disabled nil)

