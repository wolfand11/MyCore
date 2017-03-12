;;; packages.el --- wolfand11 Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq wolfand11-packages '(eshell
                           org
                           lua-mode
                           emacs-lisp
                           find-file-in-project
                           prodigy
                           company))

(defun wolfand11/post-init-find-file-in-project ()
  (progn
    ;; If you use other VCS (subversion, for example), enable the following option
    ;;(setq ffip-project-file ".svn")
    ;; in MacOS X, the search file command is CMD+p
    (bind-key* "s-p" 'find-file-in-project)
    ;; for this project, I'm only interested certain types of files
    ;; (setq-default ffip-patterns '("*.html" "*.js" "*.css" "*.java" "*.xml" "*.js"))
    ;; if the full path of current file is under SUBPROJECT1 or SUBPROJECT2
    ;; OR if I'm reading my personal issue track document,
    (defadvice find-file-in-project
        (before my-find-file-in-project activate compile)
      (when (ffip-current-full-filename-match-pattern-p
             "\\(/fireball\\)")
        ;; set the root directory into "~/projs/PROJECT_DIR"
        (setq-local ffip-project-root "~/Github/fireball")
        ;; well, I'm not interested in concatenated BIG js file or file in dist/
        (setq-local ffip-find-options "-not -size +64k -not -iwholename '*/bin/*'")
        ;; do NOT search files in below directories, the default value is better.
        ;; (setq-default ffip-prune-patterns '(".git" ".hg" "*.svn" "node_modules" "bower_components" "obj"))
        )
      (when (ffip-current-full-filename-match-pattern-p
             "\\(/cocos2d-x\\)")
        ;; set the root directory into "~/projs/PROJECT_DIR"
        (setq-local ffip-project-root "~/cocos2d-x")
        ;; well, I'm not interested in concatenated BIG js file or file in dist/
        (setq-local ffip-find-options "-not -size +64k -not -iwholename '*/bin/*'")
        ;; do NOT search files in below directories, the default value is better.
        ;; (setq-default ffip-prune-patterns '(".git" ".hg" "*.svn" "node_modules" "bower_components" "obj"))
        ))
    (ad-activate 'find-file-in-project)))

;; Organize Your Life In Plain Text!
;; http://doc.norang.ca/org-mode.html
(defun wolfand11/post-init-org ()
  ;; enable org indent
  (setq org-startup-indented t)
  ;; define the refile targets
  (setq org-agenda-files (quote ("~/Documents/MyGTD")))
  (setq org-default-notes-file "~/Documents/MyGTD/gtd.org")
  ;; (setq org-refile-targets (quote ((nil :maxlevel .
  ;;                                       9)
  ;;                                  (org-agenda-files :maxlevel .
  ;;                                                    9))))
  (setq org-refile-targets (quote ((nil :maxlevel .
                                        9))))

  ;; the %i would copy the selected text into the template
  ;;http://www.howardism.org/Technical/Emacs/journaling-org.html
  ;;add multi-file journal
  (setq org-capture-templates '(("w" "Work" entry
                                 (file "~/Documents/MyGTD/gtd.org")
                                 "* TODO %?\n%U\n"
                                 :clock-in t
                                 :clock-resume t)
                                ))

  ;;An entry without a cookie is treated just like priority ' B '.
  ;;So when create new task, they are default 重要且紧急
  (setq org-agenda-custom-commands '(("w" . "任务安排")
                                     ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
                                     ("wb" "重要且不紧急的任务" tags-todo "-WEEKLY-MONTHLY-DAILY+PRIORITY=\"B\"")
                                     ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
                                     ))

  (setq org-tag-persistent-alist '((:startgroup . nil)
                                   ("WORK" . ?w) ("PROJECT" . ?p)
                                   (:endgroup . nil)
                                   (:startgroup . nil)
                                   ("DAILY" . ?x) ("MONTHLY" . ?y) ("YEARLY" . ?z)
                                   (:endgroup . nil)
                                   (:startgroup . nil)
                                   ("PERSONAL" . ?P) ("STUDY" . ?s) ("LIFE" . ?l)
                                   (:endgroup . nil)))

  ;; define myself todo state
  (setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                                  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "DISCUSS(D@/!)" "|"
                                            "CANCELLED(c@/!)" ))))

  (evil-leader/set-key "oaoa" 'org-agenda "oaoc"
    'org-capture))

(defun wolfand11/post-init-lua-mode ()
  (progn
    (add-hook 'lua-mode-hook 'evil-matchit-mode)
    (add-hook 'lua-mode-hook 'smartparens-mode)
    (setq lua-indent-level 4)
    (push 'company-dabbrev company-backends-lua-mode)
    (push 'company-etags company-backends-lua-mode)
;;; add lua language, basic, string and table keywords.
    (with-eval-after-load 'lua-mode
      (require 'company-keywords)
      (push '(lua-mode  "setmetatable" "local" "function" "and" "break" "do" "else" "elseif" "self" "resume" "yield"
                        "end" "false" "for" "function" "goto" "if" "nil" "not" "or" "repeat" "return" "then" "true"
                        "until" "while" "__index" "dofile" "getmetatable" "ipairs" "pairs" "print" "rawget" "status"
                        "rawset" "select" "_G" "assert" "collectgarbage" "error" "pcall" "coroutine"
                        "rawequal" "require" "load" "tostring" "tonumber" "xpcall" "gmatch" "gsub"
                        "rep" "reverse" "sub" "upper" "concat" "pack" "insert" "remove" "unpack" "sort"
                        "lower") company-keywords-alist))

    ))

(defun wolfand11/post-init-nxml-mode ()
  (progn
    (push 'company-dabbrev company-backends-nxml-mode)
    (push 'company-etags company-backends-nxml-mode)))

(defun wolfand11/post-init-emacs-lisp ()
  (remove-hook 'emacs-lisp-mode-hook 'auto-compile-mode))

(defun wolfand11/post-init-eshell ()
  (progn
    (defun wolfand11/init-eshell-atlas ()
      ;; shortcut for normal
      (eval-after-load "em-alias"
        '(progn
           (eshell/alias "ll" "ls -lh $*")
           (eshell/alias "la" "ls -a $*")
           (eshell/alias "lla" "ls -alh $*")
           (eshell/alias "ff" "find-file $1")))
      ;; shortcut for my toolkit
      (eval-after-load "em-alias"
        '(progn
           (eshell/alias "cd-desktop" "cd ~/Desktop")
           (eshell/alias "cd-cloud" "cd ~/Documents/MyCloud")
           (eshell/alias "cd-test" "cd ~/Documents/MyCloud/360Cloud/MyTestProject")
           (eshell/alias "cd-core" "cd ~/Documents/MyCore")
           (eshell/alias "cd-config" "cd ~/Documents/MyCore/Config")
           (eshell/alias "cd-doc" "cd ~/Documents/MyCore/Document")
           (eshell/alias "cd-toolkit" "cd ~/Documents/MyToolkit")
           (eshell/alias "cd-gtd" "cd ~/Documents/MyGTD")
           (eshell/alias "cd-project" "cd ~/Documents/MyProject")
           (eshell/alias "cd-blog" "cd ~/Documents/MyProject/Public/wolfand11/source/_posts")
           (eshell/alias "cd-study" "cd ~/Documents/MyProject/Public/StudyProjects"))))
    (wolfand11/init-eshell-atlas)))

(defun wolfand11/post-init-prodigy ()
  (progn
    (prodigy-define-service :name "Hexo Server"
      :command "hexo"
      :args '("server"):cwd
      "~/Documents/MyProject/Public/wolfand11"
      :tags '(hexo server):kill-signal'sigkill
      :kill-process-buffer-on-stop t)
    (prodigy-define-service :name "Hexo Clean"
      :command "hexo"
      :args '("clean"):cwd
      "~/Documents/MyProject/Public/wolfand11"
      :tags '(hexo clean):kill-signal'sigkill
      :kill-process-buffer-on-stop t)
    (prodigy-define-service :name "Hexo Deploy"
      :command "hexo"
      :args '("deploy" "--generate"):cwd
      "~/Documents/MyProject/Public/wolfand11"
      :tags '(hexo deploy):kill-signal'sigkill
      :kill-process-buffer-on-stop t)))

(defun wolfand11/post-init-company ()
  (progn
    (setq company-minimum-prefix-length 1
          company-idle-delay 0.08)

    (when (configuration-layer/package-usedp 'company)
      (spacemacs|add-company-hook shell-script-mode)
      (spacemacs|add-company-hook makefile-bsdmake-mode)
      (spacemacs|add-company-hook sh-mode)
      (spacemacs|add-company-hook lua-mode)
      (spacemacs|add-company-hook nxml-mode)
      (spacemacs|add-company-hook conf-unix-mode)
      (spacemacs|add-company-hook json-mode)
      (spacemacs|add-company-hook graphviz-dot-mode)
      )
    ))
