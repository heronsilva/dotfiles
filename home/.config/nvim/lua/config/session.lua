-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- vim.opt.sessionoptions = "buffers,tabpages,curdir,folds,help,winsize,winpos,terminal,localoptions"

-- if not Heron.is_single_file_mode() then end
-- local SESSION_DIR = vim.fn.stdpath("data") .. "/sessions/"
-- local SESSION_PATH = SESSION_DIR .. Heron.get_session_path_normalized(Heron.ROOT .. ".session.vim")

local SESSION_DIR = Heron.ROOT .. ".nvim/"
local SESSION_PATH = SESSION_DIR .. "session.vim"

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if Heron.file_exists(SESSION_PATH) then
            vim.cmd(":source " .. SESSION_PATH)
            vim.notify(SESSION_PATH, vim.log.levels.INFO, { title = "Session restored" })
        else
            vim.notify(SESSION_PATH, vim.log.levels.WARN, { title = "No session found" })
        end
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        vim.schedule(function()
            local choice = vim.fn.confirm("Save session before exiting?", "&Yes\n&No", 1)
            if choice == 1 then
                local success, err = pcall(vim.fn.mkdir, SESSION_DIR, "p")
                if not success then
                    vim.notify("Failed to create session directory: " .. err, vim.log.levels.ERROR)
                    return
                end

                local success, err = pcall(vim.cmd, "mksession! " .. SESSION_PATH)
                if not success then
                    vim.notify("Failed to save session: " .. err, vim.log.levels.ERROR)
                end
            end
        end)
    end,
})

vim.keymap.set("n", "<leader>qs", ":mksession! " .. SESSION_PATH .. "<CR>", { desc = "Save session" })
vim.keymap.set("n", "<leader>ql", ":source " .. SESSION_PATH .. "<CR>", { desc = "Load session" })
