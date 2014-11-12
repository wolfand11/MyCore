;; shortcut for normal

(eval-after-load "em-alias"
  '(progn (eshell/alias "ll" "ls -lh $*")
	  (eshell/alias "la" "ls -a $*")
	  (eshell/alias "lla" "ls -alh $*")
	  ))


;; shortcut for my toolkit
(eval-after-load "em-alias"
  '(progn (eshell/alias "cd-dropbox" "cd ~/Documents/MyCloud/Dropbox/")
	  (eshell/alias "cd-toolkit" "cd ~/Documents/MyCloud/Dropbox/MyToolkit")
	  (eshell/alias "cd-config"  "cd ~/Documents/MyCloud/Dropbox/MyConfig")
	  (eshell/alias "cd-project" "cd ~/Documents/MyProject")
	  (eshell/alias "goagent"    "python ~/Documents/MyCloud/Dropbox/MyToolkit/MyGoAgent/MyGoAgent.py $*")
	  ))

(provide 'init-my-shortcut)
