return {
  get_config = function(opts)
    return {
      plugins = require('aj.plugins').get(opts),
      options = require('aj.options').get(opts),
      -- custom_options = custom_options,
      mappings = require('aj.mappings').get(opts),
      globals = require('aj.globals').get(opts),
      hooks = require('aj.hooks').get(opts),
    }
  end
}
