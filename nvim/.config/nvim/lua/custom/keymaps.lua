-- Navigation keymaps
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- Go to first character of the line
vim.keymap.set('n', 'H', '^')
-- Go to last character of the line
vim.keymap.set('n', 'L', '$')

-- Move selected line / block of text in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- greatest remap ever(Keep clipboard when pasting in visual mode)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Exit insert mode more easily
vim.keymap.set('i', '<C-j>', '<Esc>', { noremap = true, silent = true, desc = 'Exit Insert mode' })

-- Magic keymaps
vim.keymap.set('n', '<leader>m1', ':CellularAutomaton game_of_life<CR>', { desc = 'Run Random Cellular Automaton' })
vim.keymap.set('n', '<leader>m2', ':CellularAutomaton scramble<CR>', { desc = 'Run Glider Cellular Automaton' })
vim.keymap.set('n', '<leader>m3', ':CellularAutomaton make_it_rain<CR>', { desc = 'Run make it rain Cellular automation' })

-- reload current buffer
vim.keymap.set('n', '<leader>r', ':e<CR>')

-- copy current file relative path to clipboard 
vim.keymap.set('n', '<leader>cr', function()
  local file_path = vim.fn.expand('%')
  vim.fn.setreg('+', file_path)
  print('Copied: ' .. file_path)
end, { desc = 'Copy relative file path to clipboard' })

-- copy current file absolute path to clipboard
vim.keymap.set('n', '<leader>cf', function()
  local file_path = vim.fn.expand('%:p')
  vim.fn.setreg('+', file_path)
  print('Copied: ' .. file_path)
end, { desc = 'Copy absolute file path to clipboard' })

-- quickfix and location list navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Rails keymap
vim.keymap.set("n", "<leader>grs", ":A<CR>", { desc = "Switch to spec file" })
vim.keymap.set("n", "<leader>grm", ":Emodel<CR>", { desc = "Edit model" })
vim.keymap.set("n", "<leader>grc", ":Econtroller<CR>", { desc = "Edit controller" })

-- Window management keymaps

-- Close pane 2
vim.keymap.set('n', '<leader>wc', ':wincmd w | close<CR>', { noremap = true, silent = true, desc = 'Close current window' })

-- Navigate between windows
vim.keymap.set('n', '<leader>wj', ':wincmd j<CR>', { noremap = true, silent = true, desc = 'Move to window below' })
vim.keymap.set('n', '<leader>wk', ':wincmd k<CR>', { noremap = true, silent = true, desc = 'Move to window above' })
vim.keymap.set('n', '<leader>wh', ':wincmd h<CR>', { noremap = true, silent = true, desc = 'Move to window left' })
vim.keymap.set('n', '<leader>wl', ':wincmd l<CR>', { noremap = true, silent = true, desc = 'Move to window right' })
vim.keymap.set('n', '<leader>ww', ':wincmd w<CR>', { noremap = true, silent = true, desc = 'Cycle to next window' })

-- Create new windows (splits)
vim.keymap.set('n', '<leader>ws', ':split<CR>', { noremap = true, silent = true, desc = 'Horizontal split'})
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Vertical split' })

-- Resize windows
vim.keymap.set('n', '<leader>w+', ':resize +5<CR>', { noremap = true, silent = true, desc = 'Increase height by 5' })
vim.keymap.set('n', '<leader>w-', ':resize -5<CR>', { noremap = true, silent = true, desc = 'Decrease height by 5' })
vim.keymap.set('n', '<leader>w>', ':vertical resize +5<CR>', { noremap = true, silent = true, desc = 'Increase width by 5' })
vim.keymap.set('n', '<leader>w<', ':vertical resize -5<CR>', { noremap = true, silent = true, desc = 'Decrease width by 5' })

-- Equalize window sizes
vim.keymap.set('n', '<leader>w=', ':wincmd =<CR>', { noremap = true, silent = true, desc = 'Equalize all window sizes' })

-- Close all other windows
vim.keymap.set('n', '<leader>wo', ':only<CR>', { noremap = true, silent = true, desc = 'Close all windows except current' })

-- Swap windows
vim.keymap.set('n', '<leader>wx', ':wincmd x<CR>', { noremap = true, silent = true, desc = 'Swap current window with next' })

-- Move current window to a new tab
vim.keymap.set('n', '<leader>wt', ':wincmd T<CR>', { noremap = true, silent = true, desc = 'Move window to new tab' })

-- Rotate windows
vim.keymap.set('n', '<leader>wr', ':wincmd r<CR>', { noremap = true, silent = true, desc = 'Rotate windows clockwise' })

-- Telescope neoclip
vim.keymap.set('n', '<leader>cb', ':Telescope neoclip<CR>', { desc = 'Open neoclip' })
