;; shortcut for normal

(eval-after-load "em-alias"
  '(progn (eshell/alias "ll" "ls -lh $*")
	  (eshell/alias "la" "ls -a $*")
	  (eshell/alias "lla" "ls -alh $*")
	  (eshell/alias "ff"  "find-file $1")
	  ))

;; shortcut for my toolkit
(eval-after-load "em-alias"
  '(progn (eshell/alias "cd-desktop" "cd ~/Desktop")
	  (eshell/alias "cd-cloud"   "cd ~/Documents/MyCloud")
	  (eshell/alias "cd-test"    "cd ~/Documents/MyCloud/360Cloud/MyTestProject")
	  (eshell/alias "cd-core"    "cd ~/Documents/MyCore")
	  (eshell/alias "cd-config"  "cd ~/Documents/MyCore/Config")
	  (eshell/alias "cd-doc"     "cd ~/Documents/MyCore/Document")
	  (eshell/alias "cd-toolkit" "cd ~/Documents/MyToolkit")
	  (eshell/alias "cd-gtd"     "cd ~/Documents/MyGTD")
	  (eshell/alias "cd-project" "cd ~/Documents/MyProject")
	  (eshell/alias "cd-blog"    "cd ~/Documents/MyProject/Public/LifeProject/wolfand11.github.com/_my_blogs")
	  (eshell/alias "cd-study"   "cd ~/Documents/MyProject/Public/StudyProjects")
	  ))

(provide 'init-my-shortcut)
