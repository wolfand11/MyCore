;; -*- Emacs-Lisp -*-

;; 设置优先的编码系统，用于加载文件
(prefer-coding-system 'utf-8)
;; 设置默认编码,用于保存文件
(setq default-buffer-file-coding-system 'utf-8)

;; 设置EmacsConfig目录----------------------------------------
(defun AppendToEmacsConfigPath (subpath)
    "concat emacs_config_path with subpath"
    (concat emacs_config_path subpath))
(defun AppendToEmacsResourcePath (subpath)
    "concat emacs_config_path with subpath"
    (concat emacs_resource_path subpath))
(setq emacs_config_path "~/Documents/MyCore/Config/EmacsConfig/")
(setq emacs_resource_path (AppendToEmacsConfigPath "Resource/"))
(add-to-list 'load-path emacs_config_path)

;; 加载Emacs配置
(message "=BEGINE= commoon_config.el")
(load (AppendToEmacsConfigPath "common_config.el"))

;; 加载local emacs配置
(let ((emacs-local-config "~/.emacs.local"))
  (if (file-exists-p emacs-local-config)
      (progn
	(message "=BEGINE= .emacs.local")
	(load emacs-local-config))))

(put 'upcase-region 'disabled nil)
