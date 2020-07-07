;; 初始化个人信息
(setq user-full-name "Dong Guo")
(setq user-mail-address "smile_guodong@163.com")

;; (spacemacs|defvar-company-backends lua-mode)
;; (spacemacs|defvar-company-backends nxml-mode)
;; (spacemacs|defvar-company-backends csharp-mode)
;; (spacemacs|defvar-company-backends shader-mode)

(add-to-list 'auto-mode-alist '("\\.bytes\\'" . lua-mode))
