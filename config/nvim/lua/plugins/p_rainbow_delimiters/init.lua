local status_rainbow_delimiters, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if not status_rainbow_delimiters then
    vim.notify("Error from plugins.p_rainbow_delimiters: rainbow_delimiters not found.")
    return
end

vim.g.rainbow_delimiters = {
    strategy = {
        rainbow_delimiters.strategy["global"],
        rainbow_delimiters.strategy["local"]
    },
    query = {
        [""] = "rainbow-delimiters",
        lua = "rainbow-blocks"
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    }
}
