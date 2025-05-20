local M = {}

function zig_setup()
	vim.lsp.config['zls'] = {
		cmd = { 'zls' },
		filetypes = { 'zig', 'zir' },
		root_markers = { 'build.zig.zon' },
	}
	vim.lsp.enable({ "zls" })
end

function ts_setup()
	vim.lsp.config['tsserver'] = {
		cmd = { 'typescript-language-server', '--stdio' },
		filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
		init_options = {
			hostInfo = "neovim"
		},
	}
	vim.lsp.enable({ "tsserver" })
end

-- setup lua lsp
function lua_setup()
	vim.lsp.config['luals'] = {
		cmd = { 'lua-language-server' },
		filetypes = { 'lua' },
		settings = {
			Lua = {
				workspace = {
					library = vim.api.nvim_get_runtime_file("lua", true),
				},
				globals = { "vim" },
				runtime = {
					version = "luaJIT",
					path = {
						"lua/?.lua",
						"lua/?/init.lua",
					}
				}
			},
		}
	}
	vim.lsp.enable({ "luals" })
end

M.setup = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
		callback = function(event)
			local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
			client.server_capabilities.completionProvider.triggerCharacters = vim.split("qwertyuiopasdfghjklzxcvbnm. ", "")
			-- vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true, })

			local hover = function()
				vim.lsp.buf.hover({
					border = "rounded"
				})
			end

			-- local map = function(keys, func, desc)
			-- 	vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			-- end
			-- map("<leader>gd", vim.lsp.buf.definition, "defs")
			-- map("K", vim.lsp.buf.hover, "Hover")
			vim.keymap.set("n", "<leader>ca",
				vim.lsp.buf.code_action, { buffer = event.buf, desc = "LSP: Code Actions" })
			vim.keymap.set("v", "<leader>ca",
				vim.lsp.buf.code_action, { buffer = event.buf, desc = "LSP: Code Actions" })
			-- -- map("<leader>rn", rename, "rename")
			-- map("gr", vim.lsp.buf.references, "Goto References ")
			-- map("gd", vim.lsp.buf.definition, "Goto Definition")
			-- map("<leader>bf", vim.lsp.buf.format, "Format Buffer")
			-- map("gi", vim.lsp.buf.implementation, "Goto Implementation")
			-- map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			-- map("<leader>r", vim.lsp.buf.rename, "Rename")
			-- map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			-- map("gD", vim.lsp.buf.declaration, "Goto Declaration")
			vim.keymap.set("n", "<leader>k", function()
				vim.diagnostic.open_float({ bufnr = event.buf, scope = 'cursor', border = "rounded", source = "if_many" })
			end, { buffer = event.buf, desc = "LSP: " .. "defs" })
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "LSP: " .. "defs" })
			vim.keymap.set("n", "K", hover, { buffer = event.buf, desc = "LSP: " .. "defs" })

			-- local client = vim.lsp.get_client_by_id(event.data.client_id)
			local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
				end,
			})
		end
	})
	local capa = require('blink.cmp').get_lsp_capabilities()
	vim.lsp.config("*", {
		capabilities = capa
	})
	ts_setup()
	lua_setup()
	zig_setup()
end

return M
