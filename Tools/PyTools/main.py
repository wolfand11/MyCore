# -*- coding: utf-8 -*-
from log import *
from file_dir_operator import *


def parse_argv(argv):
    if argv[0] == "./file_dir_operator.py":
        GFileDirOperator.parse_argv(argv)


def main():
    argv = []
    argv.extend(sys.argv)
    argv = ["./file_dir_operator.py", "./", "-R", "-opt[p]"]
    log(argv)
    parse_argv(argv)


# Logic Start
if __name__ == "__main__":
    main()
