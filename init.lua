-- Official Git Symbol Overrides
th.git = th.git or {}
th.git.modified_sign  = "M"
th.git.untracked_sign = "U"
th.git.added_sign     = "A"

-- 1. Official Git Plugin Setup
require("git"):setup()

-- 2. FZF Plugin Setup (Default to jump/reveal)
require("fg"):setup({
    default_action = "jump",
})

-- 3. Zoxide Setup (Update database on navigation)
require("zoxide"):setup({
	update_db = true,
})

-- require("full-border"):setup {
--     type = ui.Border.ROUNDED,
-- }

-- Helper to get the current Git branch
local function get_branch()
    local output = io.popen("git branch --show-current 2>/dev/null"):read("*l")
    return (output and output ~= "") and (" (" .. output .. ")") or ""
end

local branch_name = get_branch()

-- 1. Disable the Header (to hide the top-left date)
function Header:render() return ui.Line {} end

-- 2. Official-style Custom Linemode (Permissions, Size, Date, Branch)
function Linemode:size_and_mtime()
	local year = os.date("%Y")
	local time = math.floor(self._file.cha.mtime or 0)
	local time_str = os.date(os.date("%Y", time) == year and "%b %d %H:%M" or "%b %d  %Y", time)
	local size_str = self._file:size() and ya.readable_size(self._file:size()) or "-"
	
	-- Convert mode to permissions string (rwxr-xr-x format)
	local function mode_to_perm(mode)
		if not mode then return "" end
		local perm = ""
		local bits = {"r", "w", "x"}
		for i = 8, 0, -1 do
			local bit = math.floor(mode / (2 ^ i)) % 2
			perm = perm .. (bit == 1 and bits[(8 - i) % 3 + 1] or "-")
		end
		return perm
	end
	
	local perm_str = ""
	if ya.target_family() == "unix" and self._file.cha.mode then
		local perms = mode_to_perm(self._file.cha.mode)
		local user = ya.user_name(self._file.cha.uid) or tostring(self._file.cha.uid)
		local group = ya.group_name(self._file.cha.gid) or tostring(self._file.cha.gid)
		perm_str = perms .. " " .. user .. ":" .. group .. " "
	end

	return ui.Line {
		ui.Span(perm_str):fg("magenta"),       -- Permissions (rwxr-xr-x user:group)
		ui.Span(size_str .. " "),              -- Size
		ui.Span(time_str):fg("gray"),          -- Date
		ui.Span(branch_name or ""):fg("blue"), -- Git Branch
	}
end
