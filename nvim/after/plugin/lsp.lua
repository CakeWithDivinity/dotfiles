local lsp = require('lsp-zero')

local function format()
    local disabled_formatter = {
        svelte = true,
        tsserver = true,
        cssls = true,
        html = true,
        jsonls = true,
        sumneko_lua = true,
        pylsp = true,
        taplo = true,
        dockerls = true,
    }

    vim.cmd('Prettier')

    vim.lsp.buf.format {
        filter = function(client)
            -- Disable formatting for some language servers
            if disabled_formatter[client.name] then return false end

            -- Disable formatter of null-ls if formatting is provided by another LSP
            if client.name ~= 'null-ls' then return true end
            local clients = vim.lsp.buf_get_clients()
            local has_other_formatter = false
            for _  in ipairs(clients) do
                if
                    lsp.name ~= 'null-ls'
                    and lsp.server_capabilities.documentFormattingProvider
                    and not disabled_formatter[lsp.name]
                then
                    has_other_formatter = true
                end
            end
            if has_other_formatter then return false end
            return true
        end,
    }
end

lsp.preset('recommended')

lsp.ensure_installed({
	'tsserver',
	'eslint',
	'lua_ls',
	'angularls',
	'cssls',
	'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({ select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

vim.keymap.set("n", "<leader>lf", format);

lsp.setup()
