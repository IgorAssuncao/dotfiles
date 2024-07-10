return function(opts)
    opts.settings = {
        ['helm-ls'] = {
            yamlls = {
                path = "yaml-language-server"
            }
        }
    }
    return opts
end
