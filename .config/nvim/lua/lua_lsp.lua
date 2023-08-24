lspconfig = require'lspconfig'

lspconfig.lua_ls.setup{
	cmd = {"lua-language-server"},
	filetypes = {"lua"},
	log_level = 2,
	settings = {
		Lua = {
			telemetry = {
				enable = false
			}
		}
	},
	single_file_support = true,

	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
			client.config.settings = vim.tbl_deep_extend('force', client.config.settings.Lua, {
				runtime = {
					--tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim
					version = 'LuaJIT'
				},
				-- Make the server aware of Neovim runtime filetypes
				workspace = {
					library = { vim.env.VIMRUNTIME }
					-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
					-- library = vim.api.nvim_get_runtime_file("", true)
				}
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true

	end
}
