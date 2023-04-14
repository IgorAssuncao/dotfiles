local status_project, project = pcall(require, "project_nvim")
if not status_project then
  vim.notify("Error from plugins.p_telescope.p_project: project not found.")
  return
end

local status_telescope, telescope = pcall(require, "telescope")
if not status_telescope then
  vim.notify("Error from plugins.p_telescope.p_project: telescope not found.")
  return
end

project.setup()

telescope.load_extension('projects')

require("plugins.p_telescope.p_project.keymaps")
