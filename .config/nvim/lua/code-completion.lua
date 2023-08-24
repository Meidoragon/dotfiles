vim.opt.completeopt = {'menuone', 'noselect', 'noinsert', 'preview'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }

local cmp = require'cmp'
cmp.setup ({
	--required by vsnip	
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	
	--add borders to the windows
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	
	--add mappings to control suggestions
	mapping = {
		--Shift+Tab to go to Previous Selected Item
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
		--Tab to go to next item
		['<Tab>'] = cmp.mapping.select_next_item(),
		--Ctrl+Shift+F to scroll backwards
		['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
		--Ctrl+F to scroll forwards
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		--Ctrl+Space to bring up completion at current cursor location
		['<C-Space>'] = cmp.mapping.complete(),
		--Ctrl+E to exit suggestion and close it
		['<C-e>'] = cmp.mapping.close(),
		--Enter to CONFIRM currently selected suggestion
		--We set the ConfirmBehavior to inster the selcted suggestion
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		})
	},

	--installed sources that can be used for code suggestions
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp', keyword_length = 3 },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua', keyword_length = 2 },
		{ name = 'buffer', keyword_length = 2 },
		{ name = 'vsnip', keyword_length = 2 },
	},
	
	--add formatting of the different sources
	formatting = {
		fields = {'menu', 'abbr', 'kind'},
		format = function(entry, item)
			local menu_icon ={
				nvim_lsp = 'λ',
				vsnip = '⋗',
				buffer = 'b',
				path = 'p'
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	}
})
