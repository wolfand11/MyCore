;; Init Plugins managed with package.el

;; solarized-theme Begin ------------------------------------
(load-theme 'solarized-dark t)
;; solarized-theme End   ------------------------------------

;; 设置Tabbar Begin ------------------------------------
(require 'tabbar)
(tabbar-mode t)
(setq tabbar-use-images nil)
;;设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    :family "微软雅黑"
                    :background "#002B36"
                    :foreground "#879A00"                    
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "#879A00")
                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "yellow"
                    :box '(:line-width 2 :color "yellow")
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "#879A00")
                    )
;; 设置Tabbar End --------------------------------------

;; 设置sr-speedbar Begin -------------------------------
(require 'sr-speedbar)
;;默认显示所有文件
(custom-set-variables
 '(speedbar-show-unknown-files t)
)
;;sr-speedbar-right-side 把speedbar放在左侧位置
;;sr-speedbar-skip-other-window-p 多窗口切换时跳过speedbar窗口
;;sr-speedbar-max-width与sr-speedbar-width-x 设置宽度
(custom-set-variables '(sr-speedbar-right-side nil)
		      '(speedbar-use-images nil)
		      '(sr-speedbar-skip-other-window-p nil)
		      '(sr-speedbar-width 25)
		      '(sr-speedbar-max-width 30)
		      '(sr-speedbar-width-x 25))
;; 绑定快捷键
(global-set-key [f5] 'sr-speedbar-toggle)

;; 设置sr-speedbar路径
(add-hook 'speedbar-mode-hook
          (lambda ()
            (cd "~/Documents/")))

;; 打开sr-speedbar
;;(sr-speedbar-open)
;;设置sr-speedbar End --------------------------------

;; ;; neotree Begin--------------------------------------
;; ;; (require 'neotree)
;; ;; (global-set-key [f5] 'neotree-toggle)
;; ;; neotree End  --------------------------------------

;; ;; 设置auto-complete Begin ----------------------------
;; (require 'auto-complete-config)
;; (add-to-list 'ac-dictionary-directories (AppendToEmacsResourcePath "ac-dict"))
;; (ac-config-default)
;; ;;; set the trigger key so that it can work together with yasnippet on tab key,
;; ;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;; ;;; activate, otherwise, auto-complete will
;; (ac-set-trigger-key "<tab>")
;; (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'batch-mode))
;; (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'protobuf-mode))
;; (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'lua-mode))
;; ;; 设置auto-complete End -------------------------------

;; 设置company-mode Start----------------------------------- 
(add-hook 'after-init-hook 'global-company-mode)
;; 设置company-mode End  -----------------------------------

;; batch-mode Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.bat$" . batch-mode))
(add-to-list 'interpreter-mode-alist '("bat" . batch-mode))
;; batch-mode End  -----------------------------------

;; ;; Protobuff-mode Start-----------------------------------
;; (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
;; (add-to-list 'interpreter-mode-alist '("bat" . protobuf-mode))
;; ;; Protobuff-mode End  -----------------------------------

;; lua-mode设置 Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
;;add auto-completed
;; lua-mode设置 End-------------------------------------

;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; smartparens mode Start-----------------------------------
(require 'smartparens-config)
(smartparens-global-mode t)
;; highlights matching pairs
(show-smartparens-global-mode t)
;; smartparens mode End  -----------------------------------

;; MarkDown设置 Start-----------------------------------
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; MarkDown设置 End-------------------------------------

;; ;; multiple cursors
;; ;;(require 'multiple-cursors)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Yasnippet
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs (AppendToEmacsResourcePath "snippets"))
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

;; ;; flx-ido mode
;; ;;(flx-ido-mode t)

;; Helm Projectile Mode End ----------------------------------------
(require 'helm-config)
(helm-mode t)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
;;(global-set-key (kbd "C-c h") 'helm-mini)
(global-unset-key (kbd "C-x C-b"))
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-unset-key (kbd "C-x C-f"))
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-unset-key (kbd "M-s o"))
(global-set-key (kbd "M-s o") 'helm-occur)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-M-x-fuzzy-match t
      helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t
      helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)
;; projectile mode
(projectile-global-mode)
(setq projectile-completion-system 'helm
      projectile-indexing-method 'alien
      projectile-switch-project-action 'projectile-dired
      projectile-enable-caching t)
;; helm-projectile
(require 'helm-projectile)
(helm-projectile-on)
;; Helm Projectile Mode End ----------------------------------------
                        
;; dsvn
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(require 'vc-svn)

;; undo tree
(require 'undo-tree)
(global-undo-tree-mode)

;; ergoemacs
(setq ergoemacs-use-mac-command-as-meta nil)
(setq ergoemacs-theme nil)		
(setq ergoemacs-keyboard-layout "us")
(setq ergoemacs-helm-ido-style-return nil)
(define-key key-translation-map (kbd "<f13>") (kbd "<menu>"))
(require 'ergoemacs-mode)
(ergoemacs-mode 1)
(ergoemacs-ignore-prev-global)

;; ;; e2wm
;; ;;(require 'e2wm)
;; ;;(global-set-key (kbd "M-+") 'e2wm:start-management)

;; ;; package utils
;; (require 'package-utils)

(provide 'init-auto-plug)
