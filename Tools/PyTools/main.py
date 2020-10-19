# -*- coding: utf-8 -*-
from log import *
from optparse import OptionParser
from org_export_sitemap import GOrgExportSitemap

def main():
    pass

# Logic Start
if __name__ == "__main__":
    main()

def ParseOption():
    parser = OptionParser(usage="%prog [options]")
    parser.add_option("--OrgExportSitemap", action="store_true", dest="export_blog_sitemap", help="export my blog sitemap")
    parser.add_option("-p", "--paths", dest="path_arr", help="path array args")
    options,args = parser.parse_args()

    if options.export_blog_sitemap:
        GOrgExportSitemap.ExportSitemap(None)
        pass
    return options,args

if __name__ == '__main__':
    log_info("START LOOP-LIFE Python Stage")
    options,args = ParseOption()
    print(options)
    print(args)
    log_info("END   LOOP-LIFE Python Stage")

