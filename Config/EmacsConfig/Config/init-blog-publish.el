;;------------------- blog editor init

(if (version< emacs-version "24.4")
    (progn (message "Warnning: emacs version less than 24.4"))
  (progn (require 'ox-publish) ))

;;[1] Org Mode设置 Begin ---------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-publish-use-timestamps-flag nil)
(auto-image-file-mode t)
;; 定义快捷插入操作
(define-skeleton iexp
  "Input #+BEGIN_EXAMPLE #+END_EXAMPLE in org-mode"
  ""
  "#+BEGIN_EXAMPLE\n"
  _ "\n"
  "#+END_EXAMPLE"
  )
(define-skeleton isrc
  "Input #+begin_src #+end_src in org-mode"
  ""
  "#+BEGIN_HTML\n<pre lang = \"cpp\">\n"
  _ "\n"
  "</pre>\n#+END_HTML"
  )
(define-skeleton iprop
  "Input :PROPERTIES: :END: in org-mode"
  ""
  >":PROPERTIES:\n"
  > _ "\n"
  >":END:"
  )

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
     :base-directory "~/Documents/MyProject/Public/LifeProject/wolfand11.github.com/_my_blogs/org/"
     :base-extension "org"
     
     ;; Path to your Jekyll project.
     :publishing-directory "~/Documents/MyProject/Public/LifeProject/wolfand11.github.com/_posts/"
     :recursive t
     :publishing-function org-html-publish-to-html
     :headline-levels 4 
     :html-extension "html"
     :body-only t ;; Only export section between <body> </body>
     ;;:table-of-contents nil
     )
    
    ("iGitBlog" :components ("org-iGitBlog"))
))
;; 设置jekyll blog End----------------------------------

(provide 'init-blog-publish)
