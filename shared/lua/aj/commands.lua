return {
  get = function (opts)
    return {
      ['CurrentFileCopyFullPath'] = [[:let @+=expand('%:p')]],
    }
  end
}
