#!/usr/bin/env bash

printf "%b" "\e[90mRunning vim-startuptime...\e[0m\n"
vim-startuptime -warmup 1 -count 10 -vimpath nvim |
  awk '
  BEGIN { FS=" *" }
  /^Total Average/{ time=$3; exit }
  END {
    print "\033[90m" "Total avg time: " time "ms" "\033[0m"
    if (time > 100) {
      print "\033[31m" "error: startup time exceeds 100ms" "\033[0m"
      exit 1
    } 
  }'
