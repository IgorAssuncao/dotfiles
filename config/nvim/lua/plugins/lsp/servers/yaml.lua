return function(opts)
    opts.settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/**.yml",
                ["https://json.schemastore.org/github-action.json"] = "/.github/actions/**.yml",
            }
        }
    }
    opts.filetypes = {
        "yml",
        "yaml"
    }

    return opts
end
