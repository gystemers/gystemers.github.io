#!/usr/bin/env bash
set -eu

emacs -Q --batch \
  -l build-site.el
