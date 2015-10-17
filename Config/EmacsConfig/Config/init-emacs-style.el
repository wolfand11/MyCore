;; 显示设置 Begin ----------------------------------------
;; 设置英文字体
(set-face-attribute
 'default nil :font "Source Code Pro 18")
;; 设置中文字体
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Microsoft YaHei" :size 18)))
;; 显示设置 End ------------------------------------------

;; Emacs细节配置 Begin -----------------------------------

;; 设置缺省模式
(setq default-major-mode 'text-mode)
;; 更改自动备份目录
(setq backup-directory-alist (quote (("." . "~/backups"))))
;; 让鼠标指针远离光标
(mouse-avoidance-mode 'animate)
;; 平滑滚动
(setq scroll-margin 3
      scroll-conservatively 10000)
;; 设置Emacs标题栏
(setq frame-title-format "Emacs @ %b")
;; 设置Copy自动化
(defun col (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (copy-region-as-kill beg end))
  )
(defun cow (&optional arg)
  "Copy words at point"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point)))
        (end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end))
  )
(defun cop (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point)))
        (end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end))
  )
;; 字体更改自动化
(defun increase-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (ceiling (* 1.10
                                  (face-attribute 'default :height)))))
(defun decrease-font-size ()
  (interactive)
  (set-face-attribute 'default
                      nil
                      :height
                      (floor (* 0.9
                                (face-attribute 'default :height)))))
;; 保存某个文件中的退出位置
(require 'saveplace)
(setq-default save-place t)
;; 自动打开上次的文件
;;(desktop-save-mode 1)
;; 显示时间
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)
;; 取消警告声音
(setq visible-bell nil)
;; 支持 emacs 和外部程序的粘贴
(setq x-select-enable-clipboard t)
;; 取消滚动条
(scroll-bar-mode -1)
;; 显示列号
(column-number-mode t)
;; 显示行号
(global-linum-mode t)
;; 高亮显示选择区域
(setq-default transient-mark-mod t)
;; 括号匹配显示
(show-paren-mode t)
;; 隐藏工具栏
(tool-bar-mode -1)
;; 隐藏菜单栏
(menu-bar-mode -1)
;; 语法高亮
(global-font-lock-mode t)
;; 关闭启动画面
(setq inhibit-startup-message t)
;; 换行后自动缩进
(global-set-key "\r" 'newline-and-indent)
;; 设置emacs窗口大小
;;(add-to-list 'default-frame-alist '(height . 24))
;;(add-to-list 'default-frame-alist '(width . 100))
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
;; Emacs细节配置 End -------------------------------------

(provide 'init-emacs-style)
