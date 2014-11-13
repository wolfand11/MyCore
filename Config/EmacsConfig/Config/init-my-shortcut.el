;; shortcut for normal

(eval-after-load "em-alias"
  '(progn (eshell/alias "ll" "ls -lh $*")
	  (eshell/alias "la" "ls -a $*")
	  (eshell/alias "lla" "ls -alh $*")
	  ))


;; shortcut for my toolkit
(eval-after-load "em-alias"
  '(progn (eshell/alias "cd-cloud"   "cd ~/Documents/MyCloud")
	  (eshell/alias "cd-toolkit" "cd ~/Documents/MyCloud/360Cloud/MyToolkit")
	  (eshell/alias "cd-test"    "cd ~/Documents/MyCloud/360Cloud/MyTestProject")	  	  
	  (eshell/alias "cd-core"    "cd ~/Documents/MyCore")
	  (eshell/alias "cd-config"  "cd ~/Documents/MyCore/Config")
	  (eshell/alias "cd-doc"     "cd ~/Documents/MyCore/Document")
	  (eshell/alias "cd-project" "cd ~/Documents/MyProject")
	  (eshell/alias "goagent"    "python ~/Documents/MyCloud/360Cloud/MyToolkit/GoAgent/MyGoAgent.py $*")
	  ))

(provide 'init-my-shortcut)
