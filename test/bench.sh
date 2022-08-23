#!/usr/bin/env bash

echo 'Running vim-startuptime...'
vim-startuptime -warmup 1 -count 10 -vimpath nvim |
  awk '
  BEGIN { FS=" *" }
  /^Total Average/{ time=$3; exit }
  END {
    print "Total avg time: " time "ms"
    if (time > 100) {
      print "\033[31m" "error: startup time exceeds 100ms"
      exit 1
    } 
  }'
