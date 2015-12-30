;; .emacs config
;; check os type and load config


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)

(message (concat "==== OS-TYPE IS "
                 (symbol-name system-type)
                 " ===="))
(message (concat "==== Emacs Version is " emacs-version
                 " ===="))

(message "---- load dot_emacs begin ----")
(let ((main-config-path (concat (cond
                                 ((string-equal system-type "windows-nt") "D:")
                                 ((or (string-equal system-type "darwin")
                                      (string-equal system-type "gnu/linux")) "~"))
                                "/Documents/MyCore/Config/EmacsConfig/main.el")))
  (if (file-exists-p main-config-path)
      (load main-config-path)))

(message "---- load dot_emacs end ----")
