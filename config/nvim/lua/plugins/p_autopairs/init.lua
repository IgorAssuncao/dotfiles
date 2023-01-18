PLUGINS.autopairs.setup()

local cmp_autopairs = require("nvim-autopairs.completion.cmp")

PLUGINS.cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)
