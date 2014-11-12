;; shortcut for normal

(eval-after-load "em-alias"
  '(progn (eshell/alias "ll" "ls -lh $*")
	  (eshell/alias "la" "ls -a $*")
	  (eshell/alias "lla" "ls -alh $*")
	  ))


;; shortcut for my toolkit
(eval-after-load "em-alias"
  '(progn (eshell/alias "cd-toolkit" "cd ~/Documents/MyToolkit")
	  (eshell/alias "cd-config"  "cd ~/Documents/MyToolkit/Config")
	  (eshell/alias "cd-tools"   "cd ~/Documents/MyToolkit/Tools")
	  (eshell/alias "cd-res"     "cd ~/Documents/MyToolkit/Resource")	  
	  (eshell/alias "cd-project" "cd ~/Documents/MyProject")
	  (eshell/alias "goagent"    "python ~/Documents/MyToolkit/GoAgent/MyGoAgent.py $*")
	  ))

(provide 'init-my-shortcut)
