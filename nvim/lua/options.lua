function update_statusline()
	vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }, function(res)
		vim.schedule(function()
			local stdout = vim.trim(res.stdout)
			local branch = ""
			if stdout ~= "" then
				branch = stdout and " " .. stdout .. " |" or ""
			end
			vim.opt_local.statusline = " %f %{&modified? '●':''} %=" .. branch .. " col %c | %L lines | %%%p "
			vim.cmd("redrawstatus")
		end
		)
	end)
end

vim.api.nvim_create_autocmd(
	{ "BufEnter", "BufWinEnter", "BufWritePost", "ShellCmdPost", "FocusGained", "UIEnter" }, {
		pattern = "*",
		callback = function()
			local filename = vim.fn.bufname("%")
			local buftype = vim.bo.buftype
			-- local is_file_valid = vim.fn.filereadable(filename)
			if filename == "" or buftype == "nofile" then
				vim.opt_local.statusline = filename
			else
				update_statusline()
			end
		end,
	})

vim.o.statusline = " %f %{&modified?'●':''}%=at %c | %L lines | %%%p "
-- vim.opt.nocompatible = true
vim.opt.number = true
-- vim.opt.mouse=a
vim.opt.numberwidth = 1
--syntax enable
vim.opt.showcmd = true
vim.opt.ruler = true
-- vim.opt.encoding=utf-8
vim.opt.sw = 2
vim.opt.tabstop = 2
vim.opt.laststatus = 2
vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.g.mapleader = " "
vim.opt.scrolloff = 8
vim.o.cursorline = true

vim.o.foldmethod = 'expr'
vim.o.foldexpr = nil
vim.o.foldlevelstart = 99
vim.o.foldlevel = 99
vim.o.foldenable = true

vim.cmd("set conceallevel=0")
-- vim.opt.noshowmode = true
--vim.opt.complete=-i

-- vim.opt.rtp+=~/.fzf
-- vim.opt.list lcs=tab:\|\
-- vim.opt.background=dark
--
-- let g:AutoPairsMapCR=0
--
vim.g.skip_ts_context_commentstring_module = true

vim.api.nvim_create_autocmd({ 'TermRequest' }, {
	desc = 'Handles OSC 7 dir change requests',
	callback = function(ev)
		local val, n = string.gsub(ev.data.sequence, '\027]7;file://[^/]*', '')
		if n > 0 then
			-- OSC 7: dir-change
			local dir = val
			if vim.fn.isdirectory(dir) == 0 then
				vim.notify('invalid dir: ' .. dir)
				return
			end
			vim.b[ev.buf].osc7_dir = dir
			if vim.api.nvim_get_current_buf() == ev.buf then
				vim.cmd.lcd(dir)
			end
		end
	end
})

vim.api.nvim_create_user_command('TRun',
	function()
		local b = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_open_win(b, true, { win = 0, split = 'below' })
		vim.cmd.term { "ls -l", bang = true }
		-- TODO: I can close this automatically when I move the cursor out of the terminal output window
	end,
	{}
)
