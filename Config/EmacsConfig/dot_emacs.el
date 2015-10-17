;; .emacs config
;; check os type and load config
(message (concat "==== OS-TYPE IS " (symbol-name system-type) " ===="))
(message (concat "==== Emacs Version is " emacs-version " ===="))

(message "---- load dot_emacs begin ----")
(let ((main-config-path (concat (cond
				 ((string-equal system-type "windows-nt")
				  "D:")
				 ((or (string-equal system-type "darwin") (string-equal system-type "gnu/linux"))
				  "~"))
 "/Documents/MyCore/Config/EmacsConfig/main.el")))
  (if (file-exists-p main-config-path) (load main-config-path)))


(message "---- load dot_emacs end ----")
