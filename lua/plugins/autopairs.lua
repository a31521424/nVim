local cmp_npairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_npairs.on_confirm_done())

local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")

npairs.setup()

local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
npairs.add_rules({
	Rule(" ", " ")
		:with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({
				brackets[1][1] .. brackets[1][2],
				brackets[2][1] .. brackets[2][2],
				brackets[3][1] .. brackets[3][2],
			}, pair)
		end)
		:with_move(cond.none())
		:with_cr(cond.none())
		:with_del(function(opts)
			local col = vim.api.nvim_win_get_cursor(0)[2]
			local context = opts.line:sub(col - 1, col + 2)
			return vim.tbl_contains({
				brackets[1][1] .. "  " .. brackets[1][2],
				brackets[2][1] .. "  " .. brackets[2][2],
				brackets[3][1] .. "  " .. brackets[3][2],
			}, context)
		end),
})
for _, bracket in pairs(brackets) do
	npairs.add_rule(Rule("", " " .. bracket[2])
		:with_pair(cond.none())
		:with_move(function(opts)
			return opts.char == bracket[2]
		end)
		:with_cr(cond.none())
		:with_del(cond.none())
		:use_key(bracket[2]))
end
npairs.add_rules({
	Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
		:use_regex(true)
		:set_end_pair_length(2),
})
local get_closing_for_line = function(line)
	local i = -1
	local clo = ""

	while true do
		i, _ = string.find(line, "[%(%)%{%}%[%]]", i + 1)
		if i == nil then
			break
		end
		local ch = string.sub(line, i, i)
		local st = string.sub(clo, 1, 1)

		if ch == "{" then
			clo = "}" .. clo
		elseif ch == "}" then
			if st ~= "}" then
				return ""
			end
			clo = string.sub(clo, 2)
		elseif ch == "(" then
			clo = ")" .. clo
		elseif ch == ")" then
			if st ~= ")" then
				return ""
			end
			clo = string.sub(clo, 2)
		elseif ch == "[" then
			clo = "]" .. clo
		elseif ch == "]" then
			if st ~= "]" then
				return ""
			end
			clo = string.sub(clo, 2)
		end
	end

	return clo
end

npairs.add_rule(Rule("[%(%{%[]", "")
	:use_regex(true)
	:replace_endpair(function(opts)
		return get_closing_for_line(opts.line)
	end)
	:end_wise(function(opts)
		-- do not endwise if there is no closing
		return get_closing_for_line(opts.line) ~= ""
	end))

npairs.add_rule(Rule("<", ">"))
