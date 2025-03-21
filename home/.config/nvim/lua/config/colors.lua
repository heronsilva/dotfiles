local colorscheme_path = vim.fn.stdpath("config") .. "/lua/config/colorscheme.vim"
local file = io.open(colorscheme_path, "r")

if file then
    local colorscheme = file:read("*l")
    file:close()

    -- Apply the colorscheme if it exists
    if colorscheme and colorscheme ~= "" then
        vim.schedule(function()
            -- vim.o.background = "light"
            -- vim.cmd("set background=dark")
            local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
            if not ok then
                vim.notify("Failed to load colorscheme: " .. colorscheme, vim.log.levels.ERROR)
            end
            vim.notify("Colorscheme set to " .. colorscheme, vim.log.levels.INFO)
        end)
    end
end
