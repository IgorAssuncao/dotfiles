return {
    settings = {
        yaml = {
            schemaStore = {
                -- NOTE: Disable to use schemastore plugin.
                enable = false,
                -- NOTE: schemastore plugin
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = ""
            },
            schemas = vim.tbl_deep_extend("force", {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/**.(yml|yaml)",
                ["https://json.schemastore.org/github-action.json"] = "/.github/actions/**.(yml|yaml)",
            }, require('schemastore').yaml.schemas())
        }
    },
    filetypes = {
        "yml",
        "yaml"
    }
}
