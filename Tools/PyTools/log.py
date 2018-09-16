# -*- coding: utf-8 -*-
from enum import Enum
GLogType = Enum('GLogType', ('Info', 'Warn', 'Error'))


def log(obj, log_type=GLogType.Info, is_add_prefix=True):
    prefix = ""
    if is_add_prefix:
        prefix = log_type.name + "  : "
    print(prefix + str(obj))


def log_info(obj, is_add_prefix=True):
    log(obj, GLogType.Info, is_add_prefix)


def log_error(obj, is_add_prefix=True):
    log(obj, GLogType.Error, is_add_prefix)


def log_warning(obj, is_add_prefix=True):
    log(obj, GLogType.Warn, is_add_prefix)
