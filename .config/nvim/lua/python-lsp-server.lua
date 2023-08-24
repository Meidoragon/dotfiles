lspconfig = require "lspconfig"
util = require "lspconfig/util"

lspconfig.pylsp.setup{
	cmd = {"pylsp"},
	filetypes = {"python"},
	single_file_support = true,
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					ignore = {'W391'},
					maxLineLength = 100
				}
			}
		}
	}
}
