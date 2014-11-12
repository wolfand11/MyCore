@echo Start Update Project

set svn_bin_path=C:\Program Files\TortoiseSVN\bin
set project_path=E:MUX

if exist %project_path% (
   "%svn_home%"\TortoiseProc.exe/command:update /path:"%svn_work%" /notempfile /closeonend:1
)
else (
     @echo %project_path% don't exist!
)
