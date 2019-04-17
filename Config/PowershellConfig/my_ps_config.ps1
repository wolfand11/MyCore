# -------------------------SHORTCUT-------------------------
# apps aliases
new-alias -Name open -Value Invoke-Item

# cd shortcut
function cd-home { set-location "D:" }
function cd-desktop { set-location($HOME+"/Desktop/") }
function cd-res { set-location "D:/Documents/MyResource" }
function cd-proj { set-location "D:/Documents/MyProject/" }
function cd-study { set-location "D:/Documents/MyProject/Public/StudyProjects" }
function cd-blog { set-location "D:/Documents/MyProject/Public/wolfand11" }
function cd-book { set-location "D:/Documents/MyCloud/快盘/MyBook" }
function cd-test { set-location "D:/Documents/MyCloud/360Cloud/MyTestProject" }
function cd-core { set-location "D:/Documents/MyCore" }
function cd-config { set-location "D:/Documents/MyCore/Config" }
function cd-doc { set-location "D:/Documents/MyCore/Document" }
function cd-toolkit { set-location "D:/Documents/MyToolkit" }
function cd-gtd { set-location "D:/Documents/MyGTD" }

# ------------------------Show SETTING--------------------
# 欢迎文字
echo "Smile to the world!" 

# 检查ExecutionPolicy
function CheckExecutionPolicy
{
    $cur_policy = Get-ExecutionPolicy
	if($cur_policy -ne "Unrestricted")
    {
        echo("ExecutionPolicy = "+$cur_policy)
    }
}
CheckExecutionPolicy

# 设置默认启动目录
cd-home

# 设置默认的编辑器

# 设置Terminal路径显示
#TODO:
