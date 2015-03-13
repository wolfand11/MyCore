;; Package 设置 Start----------------------------------------------
;; 加载 package
(require 'package)

;; 设置插件安装路径
(setq package-user-dir  (AppendToEmacsConfigPath "Plugin/elpa"))

;; 添加插件源
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                           ("gnu" . "http://elpa.gnu.org/packages/")
                           ("melpa" . "http://melpa.org/packages/")
                           ("melpa-stable" . "http://stable.melpa.org/packages/")
                           ("marmalade" . "http://marmalade-repo.org/packages/")
                           ))
;; package init
(package-initialize)
;; Package 设置 End----------------------------------------------

;; ;; 设置ido Begin ----------------------------------------
;; (require 'ido)
;; (ido-mode t)
;; (ido-everywhere t)
;; ;; disable ido faces to see flx highlights.
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-faces nil)
;; ;; 设置ido End ------------------------------------------

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
(add-hook 'js2-mode-hook  'hs-minor-mode)
;; hideshow-mode End   ----------------------------

;; Semantic
(require 'semantic/sb)
(global-semanticdb-minor-mode 1)
(global-semantic-idle-scheduler-mode 1)
(global-semantic-stickyfunc-mode 1)
(semantic-mode 1)

;; eshell config Begin ----------------------------
(add-hook 'eshell-mode-hook
	  (lambda ()
	    (setq pcomplete-cycle-completions nil)))
;; eshell config End   ----------------------------

(provide 'init-buildin-plug)
