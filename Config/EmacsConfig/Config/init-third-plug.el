;; 应用插件：

;; darkroom-mode, color-theme-6.6.0, template, graphviz-dot-mode,
;; tabbar, htmlize, org-mode 7.4
;; markdown-mode, sr-speadbar, lua-mode, json-mode
;; protobuff-mode
;; ido-mode for swich buff

;; 设置模板 Begin ----------------------------------------
(require 'template)
(template-initialize)
;; 设置模板 End ------------------------------------------

;; 加载HTMLIZE.EL Begin --------------------------------
(require  'htmlize)
(setq htmlize-output-type "font")
;; 加载HTMLIZE.EL End ----------------------------------





(provide 'init-third-plug)
