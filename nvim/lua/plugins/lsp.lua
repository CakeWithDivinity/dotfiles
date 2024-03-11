local util = require("lspconfig.util")

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        angularls = {
          root_dir = util.root_pattern("angular.json", "project.json"),
        },
      },
    },
  },
}
