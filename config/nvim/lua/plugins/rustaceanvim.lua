return {
    "mrcjkb/rustaceanvim",
    version = '^6',
    lazy = false,
    config = function()
        vim.g.rustaceanvim = {
            tools = {
                float_win_config = {
                    auto_focus = true
                },
            },
            server = {
                default_settings = {
                    ["rust-analyzer"] = {
                        inlayHints = {
                            bindingModeHints = {
                                enable = false,
                            },
                            chainingHints = {
                                enable = true,
                            },
                            closingBraceHints = {
                                enable = true,
                                minLines = 25,
                            },
                            closureReturnTypeHints = {
                                enable = "never",
                            },
                            lifetimeElisionHints = {
                                enable = "never",
                                useParameterNames = false,
                            },
                            maxLength = 25,
                            parameterHints = {
                                enable = true,
                            },
                            reborrowHints = {
                                enable = "never",
                            },
                            renderColons = true,
                            typeHints = {
                                enable = true,
                                hideClosureInitialization = false,
                                hideNamedConstructor = false,
                            },
                        },
                    },
                },
            },
        }
    end
}
