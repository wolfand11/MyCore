;;------------------- blog editor init

;;[1] Org Mode设置 Begin ---------------------------------------------------------
(require 'org-install)
(require 'org-publish)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-set-key [f6] 'toggle-truncate-lines)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key (kbd "<f8> p") 'org-publish)
(setq org-publish-use-timestamps-flag nil)
;; 定义快捷插入操作
(define-skeleton iexp
  "Input #+BEGIN_EXAMPLE #+END_EXAMPLE in org-mode"
  ""
  "#+BEGIN_EXAMPLE\n"
  _ "\n"
  "#+END_EXAMPLE"
  )
(define-abbrev org-mode-abbrev-table "iexp" "" 'iexp)
(define-skeleton isrc
  "Input #+begin_src #+end_src in org-mode"
  ""
  "#+BEGIN_HTML\n<pre lang = \"cpp\">\n"
  _ "\n"
  "</pre>\n#+END_HTML"
  )
(define-abbrev org-mode-abbrev-table "isrc" "" 'isrc)
(define-skeleton iprop
  "Input :PROPERTIES: :END: in org-mode"
  ""
  >":PROPERTIES:\n"
  > _ "\n"
  >":END:"
  )
(define-abbrev org-mode-abbrev-table "iprop" "" 'iprop)
;;消除行连接
(add-hook 'org-mode-hook
    (lambda () (setq truncate-lines nil)))
;; 自动换行
(global-set-key [f7] 'toggle-truncate-lines)
;; Org Mode设置 End --------------------------------------------------------

;;[2] 设置jekyll blog Begin----------------------------------
;;
;; ---post template set---
(defcustom org/github-blog-buffer-template
"#+BEGIN_HTML
---
layout: page
title: TEST
category : tool
tags : [tool, emacs]
---
{% include JB/setup %}
#+END_HTML
\n"
  "The default template to be inserted in a new post buffer."
  :type 'string)
(defun org/github-blog-new-entry()
  "Creates a new blog entry."
  (interactive)
    (org-mode)
    (insert org/github-blog-buffer-template))

;; ---org导出html设置---
(setq org-publish-project-alist
  '(
    ("org-iGitBlog"
     ;; Path to your org files.
     :base-directory "~/Documents/MyProject/Public/LifeProject/wolfand11.github.com/BlogContent/org/"
     :base-extension "org"
     
     ;; Path to your Jekyll project.
     :publishing-directory "~/Documents/MyProject/Public/LifeProject/wolfand11.github.com/_posts/"
     :recursive t
     :publishing-function org-publish-org-to-html
     :headline-levels 4 
     :html-extension "html"
     :body-only t ;; Only export section between <body> </body>
     ;;:table-of-contents nil
     )
    
    ("iGitBlog" :components ("org-iGitBlog"))
))
;; 设置jekyll blog End----------------------------------

(provide 'init-blog-publish)