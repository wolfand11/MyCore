# -------------------------INIT-------------------------
# 设置变量
# MYOS_TYPE osx windows linux
set -x MYOS_TYPE osx

# -------------------------PATH-------------------------
# 设置PATH
switch $MYOS_TYPE
case windows
     # TODO
case osx
     fish_add_path -P /opt/local/bin /opt/local/sbin
case linux
     # TODO
end

# ------------------------- APP ------------------------
# Init pyenv
status is-interactive; and pyenv init --path | source
pyenv init - | source

# -------------------------SHORTCUT-------------------------
# cd shortcut
switch $MYOS_TYPE
case windows
     alias cd-desktop='cd /c/Users/$USER/Desktop'
case '*'
     alias cd-desktop='cd ~/Desktop/'
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
# 关闭默认终端提示语
function fish_greeting
end
# 新的终端提示语
echo "Smile to the world! OS is $MYOS_TYPE"

# 设置默认启动目录
cd ~

