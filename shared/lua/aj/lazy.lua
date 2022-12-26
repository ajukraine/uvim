local function bootstrap(opts)
  local lazypath = opts.config_folder .. "/data/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--single-branch",
      "https://github.com/folke/lazy.nvim.git",
      lazypath,
    })
  end
  vim.opt.runtimepath:prepend(lazypath)
end

local function configure_plugins(plugins, opts)
  local plugin_specs = {}
  for i, plugin in ipairs(plugins) do
    local map = {
      ['on']     = 'cmd',
      ['for']    = 'ft',
      ['do']     = 'build',
      ['branch'] = 'branch',
    }
    local plugin_spec = { }

    if type(plugin) == type({}) then
      plugin_spec[1] = plugin[1]
      for plug, lazy in pairs(map) do
        local prop = plugin[plug]

        -- Handle special case, when 'on' is for key mapping instead
        if type(prop) == type('') and prop:match('^<Plug>.+') then
          lazy = 'keys'
        end

        if prop then
          plugin_spec[lazy] = prop
        end
      end
      table.insert(plugin_specs, plugin_spec)

    elseif type(plugin) == type('') then
      plugin_spec[1] = plugin
      table.insert(plugin_specs, plugin_spec)

    else
      print('Unrecognized plugin definition: ', vim.inspect(plugin))
    end
  end

  require('lazy').setup(plugin_specs, {
    root = opts.config_folder .. "/data/lazy",
  })
end

return {
  bootstrap = bootstrap,
  configure_plugins = configure_plugins,
}
