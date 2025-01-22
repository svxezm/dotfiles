local lsp = require('lsp-zero')

lsp.on_attach(function(client,bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'rust_analyzer', 'ast_grep'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

lsp.preset('recommended')

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-l>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-p>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete()
})

lsp.set_preferences({
	sign_icons = { }
})
