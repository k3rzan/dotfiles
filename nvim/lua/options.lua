function _G.statusline_mode()
  local modes = {
    n = "NORMAL",
    i = "INSERT",
    v = "VISUAL",
    V = "V-LINE",
    [""] = "V-BLOCK",
    c = "COMMAND",
    R = "REPLACE",
    s = "SELECT",
    S = "S-LINE",
    [""] = "S-BLOCK",
    t = "TERMINAL"
  }
  return modes[vim.api.nvim_get_mode().mode] or "UNKNOWN"
end


function update_statusline()
	vim.system({"git", "rev-parse", "--abbrev-ref", "HEAD"}, {text = true}, function (res)
		vim.schedule(function ()
			local stdout = vim.trim(res.stdout)
			local branch = stdout and " " .. stdout .. " |" or ""
			vim.o.statusline=" %f %{&modified?'●':''} %=" .. branch .. " col %c | %L lines | %%%p "
			vim.cmd("redrawstatus")
		end
		)
	end)
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter", "BufWritePost", "ShellCmdPost", "FocusGained", "UIEnter"}, {
	pattern = "*",
	callback = function()
		local filename = vim.fn.bufname("%")
		local buftype = vim.bo.buftype
		-- local is_file_valid = vim.fn.filereadable(filename)
		if filename == "" or buftype ~= "" then
			vim.schedule(function ()
				vim.opt_local.statusline=" "
			end)
		else
			update_statusline()
		end
	end,
})

	vim.o.statusline=" %f %{&modified?'●':''}%=at %c | %L lines | %%%p "
	-- vim.opt.nocompatible = true
	vim.opt.number = true
	-- vim.opt.mouse=a
	vim.opt.numberwidth = 1
	--syntax enable
	vim.opt.showcmd = false
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
