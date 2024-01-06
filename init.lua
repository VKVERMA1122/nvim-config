local opt = vim.opt -- for conciseness

vim.g.mapleader = " "

--colorscheme set
vim.cmd([[colorscheme habamax]])

vim.g.skip_ts_context_commentstring_module = true

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = false -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

--cmd height
--opt.cmdheight = 0

--folds
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- clipboard
vim.o.clipboard = "unnamedplus"

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 50
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

--setting shell to powershell
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or vim.fn.has("win16") == 1 then
    local powershell_options = {
        shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = ""
    }
    for option, value in pairs(powershell_options) do
        vim.opt[option] = value
    end
end

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {clear = true})
vim.api.nvim_create_autocmd(
    "TextYankPost",
    {
        callback = function()
            vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = "*"
    }
)
-- FILE BROWSING:
-- Tweaks for browsing
vim.g.netrw_banner = 0 -- disable annoying banner
vim.g.netrw_altv = 1
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_winsize = 25
vim.g.netrw_keepdir = 0
--vim.g.netrw_list_hide=netrw_gitignore#Hide()
--vim.g.netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
--
-- NOW WE CAN:
-- - :edit a folder to open a file browser
-- - <CR>/v/t to open in an h-split/v-split/tab
-- - check |netrw-browse-maps| for more mappings

--neovide
if vim.g.neovide then
    -- Put anything you want to happen only in Neovide here

    vim.o.guifont = "JetBrainsMono NFM:h12" -- text below applies for VimScript
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    vim.g.neovide_cursor_antialiasing = true
    -- vim.g.neovide_fullscreen = true
    vim.g.neovide_refresh_rate_idle = 5
    vim.g.neovide_refresh_rate = 60
end

--keymaps
local keymap = vim.keymap -- for conciseness

-- General Keymaps

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", {desc = "Exit insert mode with jk"})

-- clear search highlights
keymap.set("n", "<ESC><ESC>", ":nohl<CR>", {desc = "Clear search highlights"})

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", {desc = "Increment number"}) -- increment
keymap.set("n", "<leader>-", "<C-x>", {desc = "Decrement number"}) -- decrement

--buffer navigation
keymap.set("n", "[b", "<cmd>bnext<cr>", {desc = "Switch to next buffer"})
keymap.set("n", "]b", "<cmd>bprev<cr>", {desc = "Switch to previous buffer"})
keymap.set("n", "'b", "<cmd>bd<cr>", {desc = "Switch close current buffer"})

--buffers
keymap.set("n", "<leader>fb", ":ls<CR>:b<Space>", {desc = "buffer switch"})
keymap.set("n", "<C-1>", ":b1<CR>", {desc = "buffer switch 1"})
keymap.set("n", "<C-2>", ":b2<CR>", {desc = "buffer switch 2"})
keymap.set("n", "<C-3>", ":b3<CR>", {desc = "buffer switch 3"})
keymap.set("n", "<C-4>", ":b4<CR>", {desc = "buffer switch 4"})
--keymap.set("n", "<leader:", "<cmd>bprev<cr>", { desc = "Switch to previous buffer" })

--open new file
keymap.set("n", "<leader>o", ":e<Space>", {desc = "open new file"})

--terminal navigation
keymap.set("n", "<C-h>", "<cmd>wincmd h<cr>", {desc = "Terminal left window navigation"})
keymap.set("n", "<C-j>", "<cmd>wincmd j<cr>", {desc = "Terminal down window navigation"})
keymap.set("n", "<C-k>", "<cmd>wincmd k<cr>", {desc = "Terminal up window navigation"})
keymap.set("n", "<C-l>", "<cmd>wincmd l<cr>", {desc = "Terminal right window navigation"})
keymap.set("n", "|", "<cmd>vsplit<cr>", {desc = "Vertical Split"})
keymap.set("n", "\\", "<cmd>split<cr>", {desc = "Horizontal Split"})

-- Smart Splits
keymap.set("n", "<C-h>", "<C-w>h", {desc = "Move to left split"})
keymap.set("n", "<C-j>", "<C-w>j", {desc = "Move to below split"})
keymap.set("n", "<C-k>", "<C-w>k", {desc = "Move to above split"})
keymap.set("n", "<C-l>", "<C-w>l", {desc = "Move to right split"})
keymap.set("n", "<C-Up>", "<cmd>resize -2<CR>", {desc = "Resize split up"})
keymap.set("n", "<C-Down>", "<cmd>resize +2<CR>", {desc = "Resize split down"})
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", {desc = "Resize split left"})
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", {desc = "Resize split right"})

--netrw
keymap.set("n", "<leader>e", "<cmd>Lexplore<CR>", {desc = "Open netrw"})

--hop navigation
-- keymap.set("n", "s", "<cmd>HopWord<cr>", { desc = "Hop word" })

--status line
local function git_branch()
    local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    if string.len(branch) > 0 then
        return branch
    else
        return ":"
    end
end

local function statusline()
    local set_color_1 = "%#PmenuSel#"
    local branch = git_branch()
    local set_color_2 = "%#LineNr#"
    local file_name = " %f"
    local modified = "%m"
    local align_right = "%="
    local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
    local fileformat = " [%{&fileformat}]"
    local filetype = " %y"
    local percentage = " %p%%"
    local linecol = " %l:%c"

    return string.format(
        "%s %s %s%s%s%s%s%s%s%s%s",
        set_color_1,
        branch,
        set_color_2,
        file_name,
        modified,
        align_right,
        filetype,
        fileencoding,
        fileformat,
        percentage,
        linecol
    )
end

vim.opt.statusline = statusline()
