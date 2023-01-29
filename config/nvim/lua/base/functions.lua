local M = {}

local function print_plugin_require_error(target)
  print("Oops, error requiring: " .. target)
end

local function protected_require(target)
  local status, t = pcall(require, target)
  if not status then
    print_plugin_require_error(target)
    return
  end
  return t
end

M.protected_require = protected_require

return M
