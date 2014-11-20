;; Package 设置 Start----------------------------------------------
;; 加载 package
(require 'package)

;; 设置插件安装路径
(setq package-user-dir  (AppendToEmacsConfigPath "Plugin/elpa"))

;; 添加插件源
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;; package init
(package-initialize)
;; Package 设置 End----------------------------------------------

;; 设置ido Begin ----------------------------------------
(require 'ido)
(ido-mode t)
(ido-everywhere t)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)
;; 设置ido End ------------------------------------------

;; Rencentf 设置 Start----------------------------------------------
(require 'recentf)
(recentf-mode 1)                        
(global-set-key "\C-xf" 'recentf-open-files)
;; Rencentf 设置 End  ----------------------------------------------

;; hideshow-mode Begin ----------------------------
(load-library "hideshow")
(add-hook 'c-mode-hook      'hs-minor-mode)
(add-hook 'c++-mode-hook    'hs-minor-mode)
(add-hook 'go-mode-hook     'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'javascript-mode-hook 'hs-minor-mode)
(add-hook 'json-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(global-set-key (kbd "C--") 'hs-hide-block)    
(global-set-key (kbd "C-=") 'hs-show-block)    
(global-set-key (kbd "C-<") 'hs-hide-all)    
(global-set-key (kbd "C->") 'hs-show-all)
(global-set-key (kbd "C-}") 'hs-hide-level)
;; hideshow-mode End   ----------------------------

;; eshell config Begin ----------------------------
(add-hook 'eshell-mode-hook
	  (lambda ()
	    (setq pcomplete-cycle-completions nil)))
;; eshell config End   ----------------------------

(provide 'init-buildin-plug)
