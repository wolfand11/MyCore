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
(setq wolfand11-packages '(;;eshell
                           ;;org-static-blog
                           org
                           cc-mode
                           lua-mode
                           emacs-lisp
                           csharp-mode
                           shader-mode
                           ;;find-file-in-project
                           ;;prodigy
                           ;;company
                           htmlize
                           treemacs
                           ))

;; (defun wolfand11/post-init-find-file-in-project ()
;;   (progn
;;     ;; If you use other VCS (subversion, for example), enable the following option
;;     ;;(setq ffip-project-file ".svn")
;;     ;; in MacOS X, the search file command is CMD+p
;;     (bind-key* "s-p" 'find-file-in-project)
;;     ;; for this project, I'm only interested certain types of files
;;     ;; (setq-default ffip-patterns '("*.html" "*.js" "*.css" "*.java" "*.xml" "*.js"))
;;     ;; if the full path of current file is under SUBPROJECT1 or SUBPROJECT2
;;     ;; OR if I'm reading my personal issue track document,
;;     (defadvice find-file-in-project
;;         (before my-find-file-in-project activate compile)
;;       (when (ffip-current-full-filename-match-pattern-p
;;              "\\(/fireball\\)")
;;         ;; set the root directory into "~/projs/PROJECT_DIR"
;;         (setq-local ffip-project-root "~/Github/fireball")
;;         ;; well, I'm not interested in concatenated BIG js file or file in dist/
;;         (setq-local ffip-find-options "-not -size +64k -not -iwholename '*/bin/*'")
;;         ;; do NOT search files in below directories, the default value is better.
;;         ;; (setq-default ffip-prune-patterns '(".git" ".hg" "*.svn" "node_modules" "bower_components" "obj"))
;;         )
;;       (when (ffip-current-full-filename-match-pattern-p
;;              "\\(/cocos2d-x\\)")
;;         ;; set the root directory into "~/projs/PROJECT_DIR"
;;         (setq-local ffip-project-root "~/cocos2d-x")
;;         ;; well, I'm not interested in concatenated BIG js file or file in dist/
;;         (setq-local ffip-find-options "-not -size +64k -not -iwholename '*/bin/*'")
;;         ;; do NOT search files in below directories, the default value is better.
;;         ;; (setq-default ffip-prune-patterns '(".git" ".hg" "*.svn" "node_modules" "bower_components" "obj"))
;;         ))
;;     (ad-activate 'find-file-in-project)))

(defun wolfand11/init-htmlize()
  (use-package htmlize
    :defer t))

;; Organize Your Life In Plain Text!
;; http://doc.norang.ca/org-mode.html
(defun wolfand11/post-init-org ()
  ;; enable org indent
  ;; (setq org-startup-indented t)
  ;; define the refile targets
  ;;(setq org-agenda-files (quote ("~/Documents/MyGTD")))
  ;;(setq org-default-notes-file "~/Documents/MyGTD/gtd.org")
  ;; (setq org-refile-targets (quote ((nil :maxlevel .
  ;;                                       9)
  ;;                                  (org-agenda-files :maxlevel .
  ;;                                                    9))))
  ;;(setq org-refile-targets (quote ((nil :maxlevel . 9))))

  ;; the %i would copy the selected text into the template
  ;;http://www.howardism.org/Technical/Emacs/journaling-org.html
  ;;add multi-file journal
  ;;(setq org-capture-templates '(("w" "Work" entry (file "~/Documents/MyGTD/gtd.org") "* TODO %?\n%U\n"
  ;;                               :clock-in t :clock-resume t)))

  ;;An entry without a cookie is treated just like priority ' B '.
  ;;So when create new task, they are default 重要且紧急
  ;;(setq org-agenda-custom-commands '(("w" . "任务安排")
  ;;                                 ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
  ;;                                 ("wb" "重要且不紧急的任务" tags-todo "-WEEKLY-MONTHLY-DAILY+PRIORITY=\"B\"")
  ;;                                 ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
  ;;                                 ))

  ;; (setq org-tag-persistent-alist '((:startgroup . nil)
  ;;                                  ("WORK" . ?w) ("PROJECT" . ?p)
  ;;                                  (:endgroup . nil)
  ;;                                  (:startgroup . nil)
  ;;                                  ("DAILY" . ?x) ("MONTHLY" . ?y) ("YEARLY" . ?z)
  ;;                                  (:endgroup . nil)
  ;;                                  (:startgroup . nil)
  ;;                                  ("PERSONAL" . ?P) ("STUDY" . ?s) ("LIFE" . ?l)
  ;;                                  (:endgroup . nil)))
  (setq org-publish-project-alist
        `(
          ("blog-notes"
           :base-directory ,(concat home-path "/Documents/MyProject/Public/wolfand11/_post/")
           :base-extension "org"
           :publishing-directory ,(concat home-path "/Documents/MyProject/Public/wolfand11/_site/")
           :recursive t
           :publishing-function org-html-publish-to-html
           :html-link-home "https://wolfand11.gitee.io"
           :html-link-org-files-as-html org-html-link-org-files-as-html
           :headline-levels 5
           :with-author nil
           :with-email nil
           :with-creator nil
           :with-timestamps nil
           :htmlized-source t
           :section-numbers nil

           ;; --------------------
           ;; remove default html-head, use custom html-head
           ;;
           :html-head-include-default-style nil
           :html-head "<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\" />
           <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
           <link rel=\"stylesheet\" title=\"Standard\" href=\"https://wolfand11.gitee.io/res/css/worg.css\" type=\"text/css\" />
           <link rel=\"alternate stylesheet\" title=\"Zenburn\" href=\"https://wolfand11.gitee.io/res/css/worg-zenburn.css\" type=\"text/css\" />
           <link rel=\"alternate stylesheet\" title=\"Classic\" href=\"https://wolfand11.gitee.io/res/css/worg-classic.css\" type=\"text/css\" />
           <link rel=\"icon\" href=\"https://wolfand11.gitee.io/res/favicon.ico\" type=\"image/ico\" />"
           ;;https://wolfand11.gitee.io/res/css/org.css
           ;;res/css/org.css

           ;; --------------------
           ;; use coding.me as comment system
           ;;
           ;; :html-postamble "<div id=\"gitment-ctn\"></div>
           ;; <link rel=\"stylesheet\" href=\"https://dn-coding-net-public-file.qbox.me/Coding-Comments/v0.0.3/default.css\">
           ;; <script src=\"https://dn-coding-net-public-file.qbox.me/Coding-Comments/v0.0.3/gitment.min.js\"></script>
           ;; <script>
           ;; var gitment = new Gitment({
           ;;     owner: 'wolfand11',
           ;;     repo: 'blog_comments',
           ;;     oauth: {
           ;;         client_id: '25bc4077d166c8858dca999bcd070cca',
           ;;         client_secret: 'c9a758cc154771b25162f537ad711c96ae5ac87c',
           ;;     },
           ;; });
           ;; gitment.render('gitment-ctn')
           ;; </script>"
           :html-postamble nil
           :auto-preamble nil
           ;;:auto-sitemap t                  ; Generate sitemap.org automagically...
           ;;:sitemap-style tree
           ;;:sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
           ;;:sitemap-title    "Sitemap"      ; ... with title 'Sitemap'.
           ;;:sitemap-file-entry-format "%d %t"
           )
          ("blog-sitemap"
           :base-directory ,(concat home-path "/Documents/MyProject/Public/wolfand11/_post/")
           :base-extension "org"
           :exclude "about.org"
           :publishing-directory ,(concat home-path "/Documents/MyProject/Public/wolfand11/_site/")
           :recursive nil
           :publishing-function org-html-publish-to-html
           :html-link-home "https://wolfand11.gitee.io"
           :html-link-org-files-as-html org-html-link-org-files-as-html
           :html-postamble nil
           :auto-preamble nil
           :html-head-include-default-style nil
           :html-head "<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\" />
           <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
           <link rel=\"stylesheet\" title=\"Standard\" href=\"https://wolfand11.gitee.io/res/css/worg.css\" type=\"text/css\" />
           <link rel=\"alternate stylesheet\" title=\"Zenburn\" href=\"https://wolfand11.gitee.io/res/css/worg-zenburn.css\" type=\"text/css\" />
           <link rel=\"alternate stylesheet\" title=\"Classic\" href=\"https://wolfand11.gitee.io/res/css/worg-classic.css\" type=\"text/css\" />
           <link rel=\"icon\" href=\"https://wolfand11.gitee.io/res/favicon.ico\" type=\"image/ico\" />"
           )
          ("blog-static"
           :base-directory ,(concat home-path "/Documents/MyProject/Public/wolfand11/_post/")
           :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|txt\\|lua\\|py\\|ico"
           :publishing-directory ,(concat home-path "/Documents/MyProject/Public/wolfand11/_site/")
           :recursive t
           :publishing-function org-publish-attachment
           )
          ("blog" :components ("blog-notes" "blog-static"))
          ;;
          ))

  ;; define myself todo state
  (setq org-todo-keywords (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                                  (sequence "WAITING(w@/!)" "HOLD(h@/!)" "DISCUSS(D@/!)" "|"
                                            "CANCELLED(c@/!)" ))))

;;   ;; (evil-leader/set-key "oaoa" 'org-agenda "oaoc"
;;   ;;   'org-capture)
)

;; (defun wolfand11/init-org-static-blog()
;;   (use-package org-static-blog
;;     :init
;;     (setq org-static-blog-publish-title "wolfand11's blog")
;;     (setq org-static-blog-publish-url "https://wolfand11.gitee.io/")
;;     (setq org-static-blog-publish-directory (concat home-path "/Documents/MyProject/Public/wolfand11/_site/"))
;;     (setq org-static-blog-posts-directory (concat home-path "/Documents/MyProject/Public/wolfand11/_post/"))
;;     (setq org-static-blog-drafts-directory (concat home-path "/Documents/MyProject/Public/wolfand11/_drafts/"))
;;     (setq org-static-blog-enable-tags t)
;;     (setq org-export-with-toc t)
;;     (setq org-export-with-section-numbers nil)
;;     (setq org-static-blog-page-header
;;           "<meta http-equiv=\"Content-Type\" content=\"text/html;charset=utf-8\" />
;;           <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />
;;           <link rel=\"stylesheet\" title=\"Standard\" href=\"https://wolfand11.gitee.io/res/css/worg.css\" type=\"text/css\" />
;;           <link rel=\"alternate stylesheet\" title=\"Zenburn\" href=\"https://wolfand11.gitee.io/res/css/worg-zenburn.css\" type=\"text/css\" />
;;           <link rel=\"alternate stylesheet\" title=\"Classic\" href=\"https://wolfand11.gitee.io/res/css/worg-classic.css\" type=\"text/css\" />
;;           <link rel=\"icon\" href=\"https://wolfand11.gitee.io/res/favicon.ico\" type=\"image/ico\" />"
;;           )
;;     (setq org-static-blog-page-postamble
;;           "<div id=\"archive\">
;;             <a href=\"https://wolfand11.gitee.io/sitemap.html\">Other posts</a>
;;           </div>"
;;           )
;;     :defer t))

(defun wolfand11/post-init-cc-mode ()
  (setq c-basic-offset 4))

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

;; (defun wolfand11/post-init-nxml-mode ()
;;   (progn
;;     (push 'company-dabbrev company-backends-nxml-mode)
;;     (push 'company-etags company-backends-nxml-mode)))

(defun wolfand11/init-csharp-mode ()
  (use-package csharp-mode
    :defer t
    :mode ("\\.cs\\'" . csharp-mode)
    :init
    (progn
      (setq csharp-indent-level 4)
      (electric-pair-local-mode 1)
      ;; (push 'company-dabbrev company-backends-csharp-mode)
      ;; (push 'company-etags company-backends-csharp-mode)
      )))

(defun wolfand11/init-shader-mode ()
  (use-package shader-mode
    :defer t
    :mode ("\\.shader\\'" . shader-mode)
    :init
    (progn
      (setq shader-indent-level 4)
      (electric-pair-local-mode 1)
      ;; (push 'company-dabbrev company-backends-shader-mode)
      ;; (push 'company-etags company-backends-shader-mode)
      )))

;; (defun lua/post-init-company ()
;;   (add-hook 'lua-mode-hook 'company-mode))

;; (defun lua/post-init-ggtags ()
;;   (add-hook 'lua-mode-local-vars-hook #'spacemacs/ggtags-mode-enable))

;; (defun lua/post-init-helm-gtags ()
;;   (spacemacs/helm-gtags-define-keys-for-mode 'lua-mode))

(defun wolfand11/post-init-emacs-lisp ()
  (remove-hook 'emacs-lisp-mode-hook 'auto-compile-mode))

(defun wolfand11/post-init-treemacs ()
  (setq treemacs-python-executable (cond
                                    ((string-equal system-type "windows-nt") "D:/Applications/Python/treemacs_py3/")
                                    ((or (string-equal system-type "darwin")
                                         (string-equal system-type "gnu/linux")) (treemacs--find-python3)))))

;; (defun wolfand11/post-init-eshell ()
;;   (progn
;;     (defun wolfand11/init-eshell-atlas ()
;;       ;; shortcut for normal
;;       (eval-after-load "em-alias"
;;         '(progn
;;            (eshell/alias "ll" "ls -lh $*")
;;            (eshell/alias "la" "ls -a $*")
;;            (eshell/alias "lla" "ls -alh $*")
;;            (eshell/alias "ff" "find-file $1")))
;;       ;; shortcut for my toolkit
;;       (eval-after-load "em-alias"
;;         '(progn
;;            (eshell/alias "cd-desktop" "cd ~/Desktop")
;;            (eshell/alias "cd-cloud" "cd ~/Documents/MyCloud")
;;            (eshell/alias "cd-test" "cd ~/Documents/MyCloud/360Cloud/MyTestProject")
;;            (eshell/alias "cd-core" "cd ~/Documents/MyCore")
;;            (eshell/alias "cd-config" "cd ~/Documents/MyCore/Config")
;;            (eshell/alias "cd-doc" "cd ~/Documents/MyCore/Document")
;;            (eshell/alias "cd-toolkit" "cd ~/Documents/MyToolkit")
;;            (eshell/alias "cd-gtd" "cd ~/Documents/MyGTD")
;;            (eshell/alias "cd-project" "cd ~/Documents/MyProject")
;;            (eshell/alias "cd-blog" "cd ~/Documents/MyProject/Public/wolfand11/source/_posts")
;;            (eshell/alias "cd-study" "cd ~/Documents/MyProject/Public/StudyProjects"))))
;;     (wolfand11/init-eshell-atlas)))

;; (defun wolfand11/post-init-prodigy ()
;;   (progn
;;     (prodigy-define-service :name "Hexo Server"
;;       :command "hexo"
;;       :args '("server"):cwd
;;       "~/Documents/MyProject/Public/wolfand11"
;;       :tags '(hexo server):kill-signal'sigkill
;;       :kill-process-buffer-on-stop t)
;;     (prodigy-define-service :name "Hexo Clean"
;;       :command "hexo"
;;       :args '("clean"):cwd
;;       "~/Documents/MyProject/Public/wolfand11"
;;       :tags '(hexo clean):kill-signal'sigkill
;;       :kill-process-buffer-on-stop t)
;;     (prodigy-define-service :name "Hexo Deploy"
;;       :command "hexo"
;;       :args '("deploy" "--generate"):cwd
;;       "~/Documents/MyProject/Public/wolfand11"
;;       :tags '(hexo deploy):kill-signal'sigkill
;;       :kill-process-buffer-on-stop t)))

;; (defun wolfand11/post-init-company ()
;;   (progn
;;     (setq company-minimum-prefix-length 1
;;           company-idle-delay 0.08)

;;     (when (configuration-layer/package-usedp 'company)
;;       (spacemacs|add-company-hook shell-script-mode)
;;       (spacemacs|add-company-hook makefile-bsdmake-mode)
;;       (spacemacs|add-company-hook sh-mode)
;;       (spacemacs|add-company-hook lua-mode)
;;       (spacemacs|add-company-hook csharp-mode)
;;       (spacemacs|add-company-hook shader-mode)
;;       (spacemacs|add-company-hook nxml-mode)
;;       (spacemacs|add-company-hook conf-unix-mode)
;;       (spacemacs|add-company-hook json-mode)
;;       (spacemacs|add-company-hook graphviz-dot-mode)
;;       )
;;     ))
