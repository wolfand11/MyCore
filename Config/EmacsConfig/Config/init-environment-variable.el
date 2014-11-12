;;
;; 设置默认目录
(setenv default-directory "~/Documents/")

;; 设置PATH变量，这样就可以调用系统的bin了
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "/usr/bin")
(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "/opt/local/sbin")

(message "init-env-variable SUCCESSFULL!")
