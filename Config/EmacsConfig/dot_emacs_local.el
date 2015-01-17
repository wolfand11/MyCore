(eval-after-load "em-alias"
  '(progn (eshell/alias "cd-hero2"     "cd ~/Documents/MyProject/Private/hero2/client_svn")
  	  (eshell/alias "cd-hero2-t"   "cd ~/Documents/MyProject/Private/hero2/client_svn/trunk")
  	  (eshell/alias "cd-hero2-b"   "cd ~/Documents/MyProject/Private/hero2/client_svn/branches")
	  (eshell/alias "my-ls"        "ls $*")	  
	  ))
