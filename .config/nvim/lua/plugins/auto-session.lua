vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
    "rmagatti/auto-session",
    -- enabled = false,
    lazy = false,
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
        suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        log_level = "debug",
    },
    config = function()
        ---@type AutoSession.Config
        local opts = {
            auto_save = true, -- default is true
            auto_restore = true,
            -- use_git_branch = true,
            -- auto_restore_last_session = true,
            cwd_change_handling = true,
            -- lazy_support = true,
            auto_restore_last_session = false,
            show_auto_restore_notif = true,
            allowed_dirs = {
                "~/Workbench/**/*",
                "~/.config/nvim/",
            },
            args_allow_single_directory = false,
        }

        require("auto-session").setup()
    end,
}
