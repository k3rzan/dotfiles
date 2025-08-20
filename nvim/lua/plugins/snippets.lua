local ls = require("luasnip")

local types = require("luasnip.util.types")

-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

vim.keymap.set({ "i" }, "<C-K>", function() ls.expand({}) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function() ls.jump(1) end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(-1) end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, { silent = true })

ls.add_snippets("zig", {
	ls.parser.parse_snippet(
		{ trig = "salloc", wordTrig = false },
		"std.mem.Allocator"
	),
	ls.parser.parse_snippet(
		{ trig = "malloc", wordTrig = false },
		"mem.Allocator"
	),
	ls.parser.parse_snippet(
		{ trig = "arraylist", wordTrig = false },
		"var ${1:_}: std.ArrayListUnmanaged(${2:type}) = .empty;"
	),
})
