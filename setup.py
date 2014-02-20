#! /usr/bin/env python

import sys, os, os.path

map = {"synapse_config.json" : "~/.config/synapse/config.json",
       "xmonad.hs" : "~/.xmonad/xmonad.hs"}

srcdir, scriptname = os.path.split(sys.argv[0])
srcdir = os.path.join(os.getcwd(), srcdir)

for fn in os.listdir(srcdir):
    if fn.endswith("~") or fn.startswith(".") or fn == scriptname:
        continue
    src = os.path.join(srcdir, fn)
    dest = os.path.expanduser(map.get(fn, "~/."+fn))
    print src, "->", dest
    if os.path.exists(dest):
        os.remove(dest)
    os.symlink(src, dest)
