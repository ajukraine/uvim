# Concept
uvim - stands for 'ultra vim', is a configuration project that aims to support both vim and neovim.
It consists of shared core config written in Lua, wrapped into Vim and Neovim specific shell.

## End vision

### File structure
```
.
├── neovim/
│   ├── lua -> ../shared/lua/
│   └── init.lua              # Entry point for Neovim
├── shared/
│   └── lua/                  # Shared Lua config folder
│       └── aj/
│           └── config.lua
└── vim/
    ├── lua -> ../shared/lua/
    └── vimrc                 # Entry point for Vim
```
### config.lua

### Quality attributes

- Compatibility: Vim 8.2+, Neovim latest stable (0.7) and dev (0.8)
- Performance: startup time under from 100ms (desired) to 200ms (acceptable)

#### Quality test cases (WIP)

| Key | Description                                             |
|-----|---------------------------------------------------------|
| QA1 | Works with Vim 8.2+                                     |
| QA2 | Works with latest stable of Neovim (currently 0.7)      |
| QA3 | Works with latest dev version of Neovim (currently 0.8) |
| QA4 | Startup time doesn't exceed 200ms                       |

## TODO

- [ ] Implement basic Vim version, by moving existing config to Lua
  - [x] options
  - [x] key mappings
  - [x] automatic Lua config reload on save
  - [x] plugins
  - [ ] auto commands
  - [x] logic around 'has_guicolors'
  - [x] colorscheme
  - [ ] syntax/filetype instructions
  - [x] global varibles
  - [ ] functions
- [ ] Implement basic Neovim version
  - [x] options
  - [x] key mappings
  - [ ] automatic Lua config reload on save
  - [ ] automatic PlugInstall
  - [x] plugins
  - [ ] auto commands
  - [x] logic around 'has_guicolors'
  - [x] colorscheme
  - [ ] syntax/filetype instructions
  - [x] global varibles
  - [ ] functions
- [ ] Define interface of 'aj.config' Lua module
- [ ] Find out how to write logs during confiration

