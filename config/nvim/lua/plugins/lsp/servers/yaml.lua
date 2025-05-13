return {
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/**.yml",
                ["https://json.schemastore.org/github-action.json"] = "/.github/actions/**.yml",
            }
        }
    },
    filetypes = {
        "yml",
        "yaml"
    }
}
