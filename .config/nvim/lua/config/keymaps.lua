local keymap = vim.keymap

-- delete sends text to 'black hole' instead of clipboard
-- https://stackoverflow.com/q/54255
keymap.set("n", "d", '"_d')
keymap.set("n", "x", '"_x')
keymap.set("n" , "dd", '"_dd')
keymap.set("v", "d", '"_d')
keymap.set("v", "x",  '"_x"')

keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("i", "<leader>w", "<ESC>:w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")
keymap.set("n", "<leader>wq", ":wq<CR>")

-- keymap.set("x", '\"+y', "y:call system(\"wl-copy\", @\")<cr>")
-- keymap.set("n", "\"+p", ":let @\"=substitute(system(\"wl-paste --no-newline\"), '<C-v><C-m>', '', 'g')<cr>p")
-- keymap.set("n", "\"*p", ":let @\"=substitute(system(\"wl-paste --no-newline --primary\"), '<C-v><C-m>', '', 'g')<cr>p")
keymap.set("x", "y", '"+y')
keymap.set("n", "p", '"+p')
keymap.set("n", "p", '"*p')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Allow moving code
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep J in place when appending line below
keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the center while navigating page up and down
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the center while navigating search results
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- Keep pasted text after pasting over selection
keymap.set("x", "<leader>p", '"_dP')

keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
