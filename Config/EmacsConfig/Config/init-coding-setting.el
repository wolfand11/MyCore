;; 常用按键绑定
(global-set-key [(ctrl f9)] 'compile)
(global-set-key [f9] 'gdb)
;; 默认编译命令设定
(setq-default compile-command "make")
;; 编译成功后自动关闭窗口
(setq compilation-finish-functions
      (lambda (buf str)
        (when (and (string= (buffer-name buf) "*compilation*")
                   (not (string-match "exited abnormally" str)))
          (run-at-time 0.5 nil 'delete-windows-on buf)
          )))

;; 设置C++风格 Begin -----------------------------------

;; 设置自动缩进
(setq indent-tabs-mode nil)
(setq default-tab-width 8)
(setq tab-width 8)
(setq tab-stop-list ())
;; Google C++ Style
(eval-when-compile (require 'cc-defs))
(defun google-c-lineup-expression-plus-4 (langelem)
  "Indents to the beginning of the current C expression plus 4 spaces.

This implements title \"Function Declarations and Definitions\" of the Google
C++ Style Guide for the case where the previous line ends with an open
parenthese.

\"Current C expression\", as per the Google Style Guide and as clarified by
subsequent discussions,
means the whole expression regardless of the number of nested parentheses, but
excluding non-expression material such as \"if(\" and \"for(\" control
structures.

Suitable for inclusion in `c-offsets-alist'."
  (save-excursion
    (back-to-indentation)
    ;; Go to beginning of *previous* line:
    (c-backward-syntactic-ws)
    (back-to-indentation)
    ;; We are making a reasonable assumption that if there is a control
    ;; structure to indent past, it has to be at the beginning of the line.
    (if (looking-at "\$latex \\(if\\|for\\|while\$\\s *(\\)")
        (goto-char (match-end 1)))
    (vector (+ 4 (current-column)))))

(defconst google-c-style
  `((c-recognize-knr-p . nil)
    (c-enable-xemacs-performance-kludge-p . t) ; speed up indentation in XEmacs
    (c-basic-offset . 2)
    (indent-tabs-mode . nil)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist . ((defun-open after)
                               (defun-close before after)
                               (class-open after)
                               (class-close before after)
                               (namespace-open after)
                               (inline-open after)
                               (inline-close before after)
                               (block-open after)
                               (block-close . c-snug-do-while)
                               (extern-lang-open after)
                               (extern-lang-close after)
                               (statement-case-open after)
                               (substatement-open after)))
    (c-hanging-colons-alist . ((case-label)
                               (label after)
                               (access-label after)
                               (member-init-intro before)
                               (inher-intro)))
    (c-hanging-semi&comma-criteria
     . (c-semi&comma-no-newlines-for-oneline-inliners
        c-semi&comma-inside-parenlist
        c-semi&comma-no-newlines-before-nonblanks))
    (c-indent-comments-syntactically-p . nil)
    (comment-column . 40)
    (c-cleanup-list . (brace-else-brace
                       brace-elseif-brace
                       brace-catch-brace
                       empty-defun-braces
                       defun-close-semi
                       list-close-comma
                       scope-operator))
    (c-offsets-alist . ((arglist-intro google-c-lineup-expression-plus-4)
                        (func-decl-cont . ++)
                        (member-init-intro . ++)
                        (inher-intro . ++)
                        (comment-intro . 0)
                        (arglist-close . c-lineup-arglist)
                        (topmost-intro . 0)
                        (block-open . 0)
                        (inline-open . 0)
                        (substatement-open . 0)
                        (statement-cont
                         .
                         (,(when (fboundp 'c-no-indent-after-java-annotations)
                             'c-no-indent-after-java-annotations)
                          ,(when (fboundp 'c-lineup-assignments)
                             'c-lineup-assignments)
                          ++))
                        (label . /)
                        (case-label . +)
                        (statement-case-open . +)
                        (statement-case-intro . +) ; case w/o {
                        (access-label . /)
                        (innamespace . 0))))
  "Google C/C++ Programming Style")
(defun google-set-c-style ()
  "Set the current buffer's c-style to Google C/C++ Programming
  Style. Meant to be added to `c-mode-common-hook'."
  (interactive)
  (make-local-variable 'c-tab-always-indent)
  (setq c-tab-always-indent t)
  (c-add-style "Google" google-c-style t))
(defun google-make-newline-indent ()
  "Sets up preferred newline behavior. Not set by default. Meant
  to be added to `c-mode-common-hook'."
  (interactive)
  (define-key c-mode-base-map "\C-m" 'newline-and-indent)
  (define-key c-mode-base-map [ret] 'newline-and-indent))
(provide 'google-c-style)
(add-hook 'c++-mode-hook 'google-set-c-style)
(add-hook 'c++-mode-hook 'google-make-newline-indent)

;; 设置C++风格 End -------------------------------------

;; 设置Python脚本的模板 Start----------------------------
(defcustom python/main_py-template
  "#coding=utf-8
#author:guodong

import os
import os.path
import sys

def ContainsAny(str, set):
    for c in set:
        if c in str: return 1;
    return 0;


def ContainsAll(str, set):
    for c in set:
        if c not in str: return 0;
    return 1;

class ProcessType:    
    ShowHelp = 0
    ProcessFile = 1
    ProcessFilesInDir = 2
    Invalid = 3
    @staticmethod
    def ConvertStrTypeToType(strArg,default):
        if strArg==\"-h\":
            return ProcessType.ShowHelp
        else:
            if os.path.exists(strArg):
                if os.path.isfile(strArg):
                    return ProcessType.ProcessFile
                else:
                    return ProcessType.ProcessFilesInDir
        return default

def ParseArgs(args):
    argcount = len(args)
    process_type = ProcessType.ShowHelp
    file_or_dir  = \"\"

    if argcount==1:
        pass
    elif argcount==2:
        process_type = ProcessType.ConvertStrTypeToType(args[1],ProcessType.ShowHelp)
        file_or_dir  = args[1]

    return process_type,file_or_dir

def ShowHelpInfo():
    print(\"usage (argcount=2): python ./XXXX.py -h  show help\")   

def Process(process_type):
    pass

def main():
    print(sys.argv)
    process_type,file_or_dir = ParseArgs(sys.argv)
    Process(process_type)
    
if __name__ == '__main__':
    main()
else:
    print(__name__)
    main()
\n"
    "The default template to be inserted in a new script buffer."
    :type 'string)
(defun python/new-main_py()
  "Create a new main.py script"
  (interactive)
  (python-mode)
  (insert python/main_py-template))
;; 设置Python脚本的模板 End------------------------------

;; 设置Shell脚本的模板 Start-----------------------------
(defcustom shell/shell-script-buffer-template
  "#!/bin/bash

#功能: 
#说明: 

# usage:
ARGUMENT_COUNT=$#
if test $ARGUMENT_COUNT -eq 1
    then
    if test $1 = \"-h\"
    then
	echo \"usage 1(argcount=1): ./XXXX.sh /user/guodong/..../ProjectRootDir\"
	echo \"usage 2(argcount=0): ./XXXX.sh\"
	exit 0
    fi
fi

#---------------------------------------------------------------------------------------
# Helper Function
#---------------------------------------------------------------------------------------

#---------------------------------------------------------------------------------------
# Logic
#---------------------------------------------------------------------------------------
echo LogicStart--------------------------------------
\n"
  "The default template to be inserted in a new script buffer."
  :type 'string)
(defun shell/new-shell-script()
  "Creates a new shell script."
  (interactive)
  (shell-script-mode)
  (insert shell/shell-script-buffer-template))
;; 设置Shell脚本的模板 End  -----------------------------



(provide 'init-coding-setting)
