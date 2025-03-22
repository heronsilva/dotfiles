local M = {}

M.is_single_file_mode = function()
    if vim.fn.argc() == 1 then
        local file = vim.fn.argv(0)
        return (vim.fn.isdirectory(file) == 0 and file) and true or false
    end
    return nil
end

M.get_project_root = function()
    -- Get the directory passed to Neovim
    local args = vim.fn.argv(0)
    local start_dir = nil

    -- If Neovim was launched with a directory, use it as the root
    if args and vim.fn.isdirectory(args) == 1 then
        start_dir = vim.fn.fnamemodify(args, ":p")
    elseif M.is_single_file_mode() then
        -- start_dir = vim.fn.getcwd() -- Default to current working directory
        start_dir = vim.fn.fnamemodify(args, ":h")
    else
        start_dir = vim.fn.getcwd() -- Default to current working directory
    end

    -- Find the Git root (if any)
    -- print(vim.inspect(vim.fn.shellescape(start_dir)))
    local git_dir = vim.fn.systemlist("git -C " .. vim.fn.shellescape(start_dir) .. " rev-parse --show-toplevel")[0]

    -- If inside a Git repo but `nvim .` was called, prioritize the passed directory
    -- if git_dir and vim.v.shell_error == 0 and vim.startswith(start_dir, git_dir) then
    if vim.v.shell_error == 0 and git_dir then
        return start_dir -- Respect explicitly passed directory
    end

    -- Otherwise, return Git root if no directory was explicitly given
    return git_dir or start_dir
end

M.ROOT = M.get_project_root()

-- @param path string The absolute file path
M.file_exists = function(path)
    return vim.loop.fs_stat(path) and vim.loop.fs_stat(path).type == "file"
end

--- Transforms a full file path into a dot-separated path relative to the home directory.
-- Removes the home directory prefix, replaces `/` with `.`, and avoids duplicate dots.
-- @param full_path string The absolute file path (e.g., "/Users/heron/a/.b/c").
-- @return string The transformed path relative to home, with `.` as a separator (e.g., "a.b.c").
M.get_session_path_normalized = function(full_path)
    local home = vim.fn.expand("~") -- Get the home directory
    local relative_path = full_path:gsub("^" .. home .. "/", "") -- Remove home prefix

    -- Replace "/" with ".", but avoid duplicate dots
    return relative_path:gsub("/+", "."):gsub("%.%.+", ".")
end

return M
