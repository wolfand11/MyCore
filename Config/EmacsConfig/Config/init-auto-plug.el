;; ------------------------------------------------------------------------
;; 配置package.el管理的插件
;; ------------------------------------------------------------------------
;;(add-to-list 'package-load-list 'tabbar)
;;(add-to-list 'package-load-list ')

;; 设置Tabbar Begin ------------------------------------
;;设置tabbar
;;(require 'tabbar)
(tabbar-mode t)
(global-set-key [(ctrl tab)] 'tabbar-forward)
(global-set-key [(ctrl shift tab)] 'tabbar-backward)
(global-set-key "\M-n" 'tabbar-forward)
(global-set-key "\M-p" 'tabbar-backward) 
;;设置tabbar外观
;;设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    :family "微软雅黑"
                    :background "grey30"
                    :foreground "sky blue"
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "gray30")
                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "yellow"
                    :background "grey30"
                    :box '(:line-width 2 :color "gray70")
                    ;; :overline "black"
                    ;; :underline "black"
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "gray70")
                    )
;; 设置Tabbar End --------------------------------------

;; 设置sr-speedbar Begin -------------------------------
;;(load "sr-speedbar.el")
;;默认显示所有文件
(custom-set-variables
 '(speedbar-show-unknown-files t)
)
;;sr-speedbar-right-side 把speedbar放在左侧位置
;;sr-speedbar-skip-other-window-p 多窗口切换时跳过speedbar窗口
;;sr-speedbar-max-width与sr-speedbar-width-x 设置宽度
(custom-set-variables '(sr-speedbar-right-side nil)
		      '(sr-speedbar-skip-other-window-p t)
		      '(sr-speedbar-max-width 30)
		      '(sr-speedbar-width-x 20))
;; 绑定快捷键
(global-set-key [f5] 'sr-speedbar-toggle)

;; 设置sr-speedbar路径
(add-hook 'speedbar-mode-hook
          (lambda ()
            (cd "~/Documents/")))

;; 打开sr-speedbar
(sr-speedbar-open)
;; 设置sr-speedbar End --------------------------------

;; 设置auto-complete Begin ----------------------------
(ac-config-default)
;; 设置auto-complete End -------------------------------

;; batch-mode Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.bat$" . batch-mode))
(add-to-list 'interpreter-mode-alist '("bat" . batch-mode))
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'batch-mode))
;; batch-mode End  -----------------------------------

;; Protobuff-mode Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))
(add-to-list 'interpreter-mode-alist '("bat" . protobuf-mode))
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'protobuf-mode))
;; Protobuff-mode End  -----------------------------------

;; lua-mode设置 Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
;;add auto-completed
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'lua-mode))
;; lua-mode设置 End-------------------------------------

;; json-mode Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'interpreter-mode-alist '("json" . json-mode))
(eval-after-load "auto-complete" '(add-to-list 'ac-modes 'json-mode))
;; json-mode End  -----------------------------------

;; MarkDown设置 Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; MarkDown设置 End-------------------------------------

;; 设置高亮 Begin ----------------------------------------
;;(load "highlight-symbol.el")
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(meta f3)] 'highlight-symbol-prev)
;; 设置高亮 End ----------------------------------------

;; multiple cursors
;;(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Yasnippet
(yas-global-mode t)

;;
;; ace-jump-mode major function
;; 
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
;; 
;; enable a more powerful jump back function from ace jump mode
;;
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; flx-ido mode
(flx-ido-mode t)

;; helm mode
(require 'helm-config)
(helm-mode t)
;;(global-set-key (kbd "C-c h") 'helm-mini)
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-unset-key (kbd "C-x C-f"))
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; projectile mode
(projectile-global-mode)
(setq projectile-completion-system 'helm)

(provide 'init-auto-plug)
