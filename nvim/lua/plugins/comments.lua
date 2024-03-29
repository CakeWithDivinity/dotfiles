return {
  {
    "nvim-ts-context-commentstring",
    lazy = true,
  },
  {
    {
      "echasnovski/mini.comment",
      event = "VeryLazy",
      opts = {
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = "<leader>gc",

          -- Toggle comment on current line
          comment_line = "<leader>gc",
        },
      },
    },
  },
}
