;; 初始化个人信息
(setq user-full-name "Dong Guo")
(setq user-mail-address "smile_guodong@163.com")

(spacemacs|defvar-company-backends lua-mode)
(spacemacs|defvar-company-backends nxml-mode)
(spacemacs|defvar-company-backends csharp-mode)
(spacemacs|defvar-company-backends shader-mode)

(setq op/repository-directory "~/Documents/MyProject/Public/wolfand11.coding.me")
(setq op/site-domain "http://wolfand11.coding.me")
(setq op/site-main-title "WOLFAND11's BLOG")
(setq op/site-sub-title "Life is beautiful!")
(setq op/personal-github-link "https://github.com/wolfand11")
(setq op/personal-disqus-shortname "wolfand11")
(setq op/personal-google-analytics-id "UA-135031721-1")

(setq op/category-config-alist
      '(("blog" ;; this is the default configuration
         :show-meta t
         :show-comment t
         :uri-generator op/generate-uri
         :uri-template "/blog/%y/%m/%d/%t/"
         :sort-by :date     ;; how to sort the posts
         :category-index t) ;; generate category index or not
        ("wiki"
         :show-meta t
         :show-comment nil
         :uri-generator op/generate-uri
         :uri-template "/wiki/%t/"
         :sort-by :mod-date
         :category-index t)
        ("index"
         :show-meta nil
         :show-comment nil
         :uri-generator op/generate-uri
         :uri-template "/"
         :sort-by :date
         :category-index nil)
        ("about"
         :show-meta nil
         :show-comment nil
         :uri-generator op/generate-uri
         :uri-template "/about/"
         :sort-by :date
         :category-index nil)))

(add-to-list 'auto-mode-alist '("\\.bytes\\'" . lua-mode))
