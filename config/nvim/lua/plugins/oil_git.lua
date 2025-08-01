-- Plugin that shows git status in files and dirs in Oil.

return {
    "benomahony/oil-git.nvim",
    dependencies = { "stevearc/oil.nvim" },
    -- No opts or config needed! Works automatically
    config = function()
        require("oil-git").setup()
    end
}
