local M = {
	ns_id = nil,
}

M.setup = function()
	vim.api.nvim_create_user_command("TSSearch", function()
		local buf = vim.api.nvim_create_buf(false, true) -- create new scratch buffer

		local text = {
			"$f --> Search functions",
			"$i --> Search variables",
			"$a --> Search assignments",
		}

		vim.api.nvim_buf_set_lines(buf, 0, -1, false, text)

		local width = vim.o.columns
		local height = #text

		local win_id = vim.api.nvim_open_win(buf, false,
			{
				relative = 'editor',
				col = 0,
				width = width,
				height = height,
				row = vim.o.lines - height - 2,
				border = "rounded"
			}
		)

		vim.cmd("redraw")

		vim.api.nvim_create_autocmd({ "CmdlineChanged" }, {
			callback = function()
				local input = vim.fn.getcmdline()
				vim.schedule(function()
					M.treesitter_query(input)
				end)
			end,
			group = vim.api.nvim_create_augroup("CmdlineInputHooks", { clear = true })
		})

		vim.ui.input({
			prompt = "Query (options: $a, $i, $f): ",
		}, function(input)
			if input then
				-- Do something with the user_query if needed
				vim.cmd("redraw")
			end

			vim.cmd("redraw")
			vim.api.nvim_win_close(win_id, true)

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				once = true,
				callback = function()
					if vim.api.nvim_win_is_valid(win_id) then
						vim.api.nvim_win_close(win_id, true)
					end
				end,
			})
		end)

		-- local user_query = vim.fn.input(
		-- )
	end, {})
end

M.treesitter_query = function(user_query)
	user_query = user_query or ""
	if string.match(user_query, "^%$[aif]") then
		local ns_id = vim.api.nvim_create_namespace("ts_highlight_ns")
		M.ns_id = ns_id
		vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
		vim.api.nvim_set_hl(0, "TSNodeHighlight", {
			bg = "#ffffff", -- el fondo que quieras
			fg = "NONE",
		})
		local query_table = {
			["$a"] = "(assignment_statement) @assign",
			["$i"] = "(identifier) @variable",
			["$f"] = "(function_declaration) @function",
		}
		local query = vim.treesitter.query.parse("lua", ([[; query
		%s]]):format(query_table[user_query]))

		local tree = vim.treesitter.get_parser():parse()[1]
		for id, node, metadata in query:iter_captures(tree:root(), 0) do
			-- Print the node name and source text.
			-- vim.print({ node:type(), vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf()) })
			-- vim.print(vim.treesitter.get_node_text(node, vim.api.nvim_get_current_buf()))
			local start_row, start_col, end_row, end_col = node:range()
			vim.hl.range(
				0,
				ns_id,
				"TSNodeHighlight",
				{ start_row, start_col }, -- posición inicial
				{ end_row, end_col }, -- posición final
				{ inclusive = true }
			)
			-- vim.print(metadata)
		end
	elseif M.ns_id then
		vim.api.nvim_buf_clear_namespace(0, M.ns_id, 0, -1)
	end
end

return M
