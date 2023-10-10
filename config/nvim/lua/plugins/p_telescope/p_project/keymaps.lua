local status_which_key, which_key = pcall(require, "which-key")
if not status_which_key then
    vim.notify("Error from plugins.p_project.keymaps: which-key not found.")
    return
end

local status_telescope, telescope = pcall(require, "telescope")
if not status_telescope then
    vim.notify("Error from plugins.p_project: telescope not found.")
    return
end

local projects_picker = telescope.extensions.projects.projects

which_key.register({
    ["<leader>"] = {
        f = {
            name = "Telescope Fuzzy [F]inder",
            p = { function()
                projects_picker {}
            end, "[P]rojects" }
        }
    }
})
