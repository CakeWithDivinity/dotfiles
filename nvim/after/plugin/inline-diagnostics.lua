require('toggle_lsp_diagnostics').init()

vim.keymap.set('n', '<leader>di', function() vim.cmd('ToggleDiag') end)
