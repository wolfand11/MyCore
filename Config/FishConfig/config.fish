
# -------------------------SHORTCUT-------------------------
# cd shortcut
switch (uname)
    case Linux Darwin FreeBSD NetBSD DragonFly
        alias cd-desktop='cd ~/Desktop/'
    case '*'
        alias cd-desktop='cd /c/Users/$USER/Desktop'
end

alias cd-res='        cd ~/Documents/MyResource'
alias cd-proj='       cd ~/Documents/MyProject/'
alias cd-study='      cd ~/Documents/MyProject/Public/StudyProjects'
alias cd-blog='       cd ~/Documents/MyProject/Public/wolfand11/_post'
alias cd-book='       cd ~/Documents/MyResource/Readings'
alias cd-core='       cd ~/Documents/MyCore'
alias cd-config='     cd ~/Documents/MyCore/Config'

# app alias
alias open='doublecmd -C -R ./'
alias rg='ranger'

# ------------------------Show SETTING--------------------
# 欢迎文字
echo "Smile to the world!"

# 设置默认启动目录
cd ~
