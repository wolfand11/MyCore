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
(setq wolfand11-packages
      '(
        org
        find-file-in-project
        ))

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
    (defadvice find-file-in-project (before my-find-file-in-project activate compile)
      (when (ffip-current-full-filename-match-pattern-p "\\(/fireball\\)")
        ;; set the root directory into "~/projs/PROJECT_DIR"
        (setq-local ffip-project-root "~/Github/fireball")
        ;; well, I'm not interested in concatenated BIG js file or file in dist/
        (setq-local ffip-find-options "-not -size +64k -not -iwholename '*/bin/*'")
        ;; do NOT search files in below directories, the default value is better.
        ;; (setq-default ffip-prune-patterns '(".git" ".hg" "*.svn" "node_modules" "bower_components" "obj"))
        )
      (when (ffip-current-full-filename-match-pattern-p "\\(/cocos2d-x\\)")
        ;; set the root directory into "~/projs/PROJECT_DIR"
        (setq-local ffip-project-root "~/cocos2d-x")
        ;; well, I'm not interested in concatenated BIG js file or file in dist/
        (setq-local ffip-find-options "-not -size +64k -not -iwholename '*/bin/*'")
        ;; do NOT search files in below directories, the default value is better.
        ;; (setq-default ffip-prune-patterns '(".git" ".hg" "*.svn" "node_modules" "bower_components" "obj"))
        ))
    (ad-activate 'find-file-in-project)))

(defun guanghui/post-init-org ()
  ;; define the refile targets
  (setq org-agenda-files (quote ("~/MyGTD" )))
  (setq org-default-notes-file "~/MyGTD/gtd.org")

  ;; the %i would copy the selected text into the template
  ;;http://www.howardism.org/Technical/Emacs/journaling-org.html
  ;;add multi-file journal
  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/MyGTD/gtd.org" "Daily Tasks")
           "* TODO %?\n  %i\n"
           :empty-lines 1)
          ("n" "notes" entry (file+headline "~/MyGTD/notes.org" "Quick notes")
           "* TODO [#C] %?\n  %i\n %U"
           :empty-lines 1)
          ("b" "Blog Ideas" entry (file+headline "~/MyGTD/notes.org" "Blog Ideas")
           "* TODO %?\n  %i\n %U"
           :empty-lines 1)
          ("w" "work" entry (file+headline "~/MyGTD/gtd.org" "Work")
           "* TODO %?\n  %i\n %U"
           :empty-lines 1)
          ("l" "links" entry (file+headline "~/MyGTD/notes.org" "Quick notes")
           "* TODO %?\n  %i\n %a \n %U"
           :empty-lines 1)
          ("j" "Journal Entry"
           entry (file+datetree "~/MyGTD/journal.org")
           "* %?"
           :empty-lines 1)))

  ;;An entry without a cookie is treated just like priority ' B '.
  ;;So when create new task, they are default 重要且紧急
  (setq org-agenda-custom-commands
        '(
          ("w" . "任务安排")
          ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
          ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
          ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
          ("b" "Blog" tags-todo "BLOG")
          ("p" . "项目安排")
          ("pw" tags-todo "PROJECT+WORK+CATEGORY=\"cocos2d-x\"")
          ("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"zilongshanren\"")
          ("W" "Weekly Review"
           ((stuck "")            ;; review stuck projects as designated by org-stuck-projects
            (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
            ))))

  (defun org-summary-todo (n-done n-not-done)
    "switch entry to done when all subentries are done, to todo otherwise."
    (let (org-log-done org-log-states)  ; turn off logging
      (org-todo (if (= n-not-done 0) "done" "todo"))))
  
  (add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
  ;; used by org-clock-sum-today-by-tags
  (defun filter-by-tags ()
    (let ((head-tags (org-get-tags-at)))
      (member current-tag head-tags)))

  (defun org-clock-sum-today-by-tags (timerange &optional tstart tend noinsert)
    (interactive "p")
    (let* ((timerange-numeric-value (prefix-numeric-value timerange))
           (files (org-add-archive-files (org-agenda-files)))
           (include-tags '("work" "emacs" "dream" "writing" "meeting"
                           "life" "project" "other"))
           (tags-time-alist (mapcar (lambda (tag) `(,tag . 0)) include-tags))
           (output-string "")
           (tstart (or tstart
                       (and timerange (equal timerange-numeric-value 4) (- (org-time-today) 86400))
                       (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "start date/time:"))
                       (org-time-today)))
           (tend (or tend
                     (and timerange (equal timerange-numeric-value 16) (org-read-date nil nil nil "end date/time:"))
                     (+ tstart 86400)))
           h m file item prompt donesomething)
      (while (setq file (pop files))
        (setq org-agenda-buffer (if (file-exists-p file)
                                    (org-get-agenda-file-buffer file)
                                  (error "no such file %s" file)))
        (with-current-buffer org-agenda-buffer
          (dolist (current-tag include-tags)
            (org-clock-sum tstart tend 'filter-by-tags)
            (setcdr (assoc current-tag tags-time-alist)
                    (+ org-clock-file-total-minutes (cdr (assoc current-tag tags-time-alist)))))))
      (while (setq item (pop tags-time-alist))
        (unless (equal (cdr item) 0)
          (setq donesomething t)
          (setq h (/ (cdr item) 60)
                m (- (cdr item) (* 60 h)))
          (setq output-string (concat output-string (format "[-%s-] %.2d:%.2d\n" (car item) h m)))))
      (unless donesomething
        (setq output-string (concat output-string "[-nothing-] done nothing!!!\n")))
      (unless noinsert
        (insert output-string))
      output-string))

  (setq org-mobile-directory "~/MyGTD/org")
  )
