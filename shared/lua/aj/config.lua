local function require_fresh(module_name)
  package.loaded[module_name] = nil

  return require(module_name)
end

return {
  get_config = function(opts)
    local function get(module_name)
      return require_fresh(module_name).get(opts)
    end

    return {
      plugins  = get('aj.plugins'),
      options  = get('aj.options'),
      mappings = get('aj.mappings'),
      globals  = get('aj.globals'),
      hooks    = get('aj.hooks'),
      commands = get('aj.commands'),
    }
  end
}
