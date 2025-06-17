return {
    enabled = false,

    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
        { "<leader>cc", ":CodeSnap<cr>", mode = "x", desc = "Save selected code snapshot into clipboard" },
        { "<leader>cs", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in ~/Pictures" },
        {
            "<leader>cl",
            "<cmd>CodeSnapHighlight<cr>",
            mode = "x",
            desc = "Save selected code snapshot in ~/Pictures",
        },
    },
    opts = {
        -- bg_color = "#000000FF",
        bg_theme = "summer",
        bg_x_padding = 10,
        bg_y_padding = 10,
        border = "rounded",
        code_font_family = "Iosevka",
        has_breadcrumbs = true,
        mac_window_bar = false,
        save_path = "~/Pictures/nvim-codesnap",
        watermark = "",
    },
}
