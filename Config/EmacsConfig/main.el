;; -*- Emacs-Lisp -*-

;; 设置优先的编码系统，用于加载文件
(prefer-coding-system 'utf-8)
;; 设置默认编码,用于保存文件
(setq default-buffer-file-coding-system 'utf-8)
;; 显示GC消息
;; (setq garbage-collection-messages t)

;; 设置EmacsConfig目录----------------------------------------
(defun AppendToEmacsConfigPath (subpath)
  "concat emacs_config_path with subpath"
  (concat emacs_config_path subpath))
(defun AppendToEmacsResourcePath (subpath)
  "concat emacs_config_path with subpath"
  (concat emacs_resource_path subpath))
(setq emacs_config_path (concat home-path "/Documents/MyCore/Config/EmacsConfig/"))
(setq emacs_resource_path (AppendToEmacsConfigPath "Resource/"))

;; 加载基本目录
(add-to-list 'load-path emacs_config_path)
(setq my_layer_path (AppendToEmacsConfigPath "Plugin/"))
(add-to-list 'load-path
             (AppendToEmacsConfigPath "Config/"))
;; (add-to-list 'load-path
;;              (AppendToEmacsConfigPath "Plugin/"))

;; 加载Emacs配置
(message "=== BEGIN Loading Config ===")
(message "=BEGIN= spacemacs-init.el")
(load (concat user-emacs-directory "init.el"))

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "=BEGIN= custom_init.el")
            (load (AppendToEmacsConfigPath "custom_init.el"))
            ;; 加载local emacs配置
            (let ((emacs-local-config (concat home-path "/.emacs.local.el")))
              (if (file-exists-p emacs-local-config)
                  (progn
                    (message "=BEGIN= .emacs.local.el")
                    (load emacs-local-config))))
            (message "=== END Loading Config ===")))
