vim9script

export def Begin(folder: string)
  g:myplug_install = 0
  var vimplug_folder = folder .. '/.vimplug'
  &runtimepath ..= ',' .. vimplug_folder

  var autoload_plug_path = vimplug_folder ..   '/autoload/plug.vim'
  if !filereadable(autoload_plug_path)
    const plug_url = 'https://raw.github.com/junegunn/vim-plug/master/plug.vim'
    silent exe '!curl -fL --create-dirs -o ' .. autoload_plug_path .. ' ' .. plug_url
    execute 'source ' .. fnameescape(autoload_plug_path)
    g:myplug_install = 1
  endif

  plug#begin(vimplug_folder .. '/plugins')
enddef

export def End()
  plug#end()

  if g:myplug_install
    PlugInstall --sync
  endif
  unlet g:myplug_install
enddef
