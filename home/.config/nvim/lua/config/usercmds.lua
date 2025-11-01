-- Copy relative path (relative to current working directory)
vim.api.nvim_create_user_command("CRelPath", function()
    local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Copy absolute path
vim.api.nvim_create_user_command("CAbsPath", function()
    local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":p")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
