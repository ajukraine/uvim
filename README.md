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

## Quality attributes

- Compatibility: Vim 8.2+, Neovim latest stable (0.7) and dev (0.8)
- Performance: startup time under from 100ms (desired) to 200ms (acceptable)

### Benchmarking

In order to track startup time, there is useful script at `test/bench.sh`.

The script relies on:
 - bash
 - awk
 - [vim-startuptime](https://github.com/rhysd/vim-startuptime) (install with `go install github.com/rhysd/vim-startuptime@latest`)

When you run the `bench.sh`, it will write smth like this:
```
bench: Running vim-startuptime...
bench: Total avg time: 167.449200ms
bench: error: Total avg time exceeds 100ms
```
The line `bench: error: ...` is printed only in case of exceeding 100ms limit and puts exit code to 1.

#### Git hook for 'pre-push'
The `bench.sh` was designed to be used as 'pre-push' Git hook. Just create a symlink like:
```
ln -s ../../test/bench.sh .git/hooks/pre-push
```

### Quality test cases (WIP)

| Key | Description                                                     |
|-----|-----------------------------------------------------------------|
| QA1 | Works with Vim 8.2+                                             |
| QA2 | Works with latest stable of Neovim (currently 0.7)              |
| QA3 | Works with latest dev version of Neovim (currently 0.8)         |
| QA4 | Startup time doesn't exceed 100ms on main machine (MacBook Pro) |

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
  - [ ] handle termcap options just for Vim
- [ ] Implement basic Neovim version
  - [x] options
  - [x] key mappings
  - [x] automatic Lua config reload on save
  - [ ] automatic PlugInstall
  - [x] plugins
  - [ ] auto commands
  - [x] logic around 'has_guicolors'
  - [x] colorscheme
  - [ ] syntax/filetype instructions
  - [x] global varibles
  - [ ] functions
  - [x] add hooks (for example, after plugins are installed)
- [x] Custom commands
- [ ] Define interface of 'aj.config' Lua module
- [ ] Find out how to write logs during configuration
- [ ] Implement robust LSP support
  - [ ] key mappings should be defined only in LSP enabled buffers
