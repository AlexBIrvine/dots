local map = require("helpers.keys").map

-- Blazingly fast way out of insert mode
map("i", "jk", "<esc>")

-- Quick access to some common actions
map("n", "<leader>s", "<cmd>w<cr>", "Save")
map("n", "<leader>q", "<cmd>q<cr>", "Quit")

-- Diagnostic keymaps
map('n', 'gx', vim.diagnostic.open_float, "Show diagnostics under cursor")

-- Better window navigation
map("n", "<C-h>", "<C-w><C-h>", "Navigate windows to the left")
map("n", "<C-j>", "<C-w><C-j>", "Navigate windows down")
map("n", "<C-k>", "<C-w><C-k>", "Navigate windows up")
map("n", "<C-l>", "<C-w><C-l>", "Navigate windows to the right")

-- Deleting buffers
local buffers = require("helpers.buffers")
map("n", "<leader>d", buffers.delete_this, "Current buffer")

-- Navigate buffers
map("n", "<S-j>", ":bnext<CR>")
map("n", "<S-k>", ":bprevious<CR>")

-- Telescope Keymaps
map('n', '<leader>ff', "<cmd>Telescope find_files<cr>", "Files")
map('n', '<leader>fg', "<cmd>Telescope live_grep<cr>",  "grep")
map('n', '<leader>fb', "<cmd>Telescope buffers<cr>",    "Buffers")
map('n', '<leader>fh', "<cmd>Telescope help_tags<cr>",  "Help")
map('n', '<leader>fr', "<cmd>Telescope oldfiles<cr>",   "Recent")
map('n', '<leader>fc', "<cmd>Telescope commands<cr>",   "Commands")
map('n', '<leader>fp', "<cmd>Telescope projects<cr>",   "Projects")
map("n", "/", function() require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({winblend = 10, previewer = false,})) end, "Search in current buffer")

-- Sniprun
map('n', '<leader>r', "<cmd>SnipRun<cr>", "Run")

-- Lazygit
map('n', '<leader>g', "<cmd>LazyGit<cr>", "Git")

-- Color Toggle
map('n', '<leader>c', "<cmd>HighlightColorsToggle<cr>", "Color highlight")
