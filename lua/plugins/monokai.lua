local opts = {
    dark_style_background = "default",  -- default, dark, transparent, #color
    light_style_background = "default", -- default, dark, transparent, #color
    hl_styles = {
        -- Style to be applied to selected syntax groups: (See `:help nvim_set_hl` for supported keys)
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = {},
        -- Background styles for sidebars (panels) and floating windows:
        floats = "default",   -- default, dark, transparent
        sidebars = "default", -- default, dark, transparent
    },

    color_headers = false,         -- Enable header colors for each header level (h1, h2, etc.)
    dim_inactive = false,          -- dims inactive windows
    lualine_bold = true,           -- Lualine headers will be bold or regular
    lualine_style = "default",     -- "dark", "light" or "default" (default follows dark/light style)
    markdown_header_marks = true, -- Add headers marks highlights (the `#` character) to Treesitter highlight query

    -- Set the colors for terminal-mode (`:h terminal-config`). `false` to disable it.
    -- Pass a table with `terminal_color_x` values: `{ terminal_color_8 = "#e6e6e6" }`.
    -- Also accepts a function:
    -- ```lua
    -- function(colors) return { fg = colors.fg_dark, terminal_color_4 = "#ff00ff" } end
    -- ```
    -- > Use the `fg` key to apply colors to the normal text.
    terminal_colors = true,

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with the Monokai ColorScheme table.
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with the Monokai Highlights and ColorScheme table.
    ---@param highlights monokai.Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,

    -- When `true` the theme will be cached for better performance.
    cache = true,

    --- Automatically enable highlights for supported plugins in the lazy.nvim config.
    auto_enable_plugins = true,

    --- List of manually enabled/disabled plugins.
    --- Check the supported plugins here:
    ---   https://github.com/polirritmico/monokai-nightasty.nvim/tree/main/lua/monokai-nightasty/highlights
    ---@type table<string, boolean>
    plugins = {
        -- Use the ["<repository name>"]. For example:
        -- ["telescope.nvim"] = true,

        -- `all`: enable or disable all plugins. By default if lazy.nvim is not loaded enable all the plugins
        all = package.loaded.lazy == nil,
    },
}

require("monokai-nightasty").load(opts)
vim.cmd("set background=dark")
vim.cmd("colorscheme monokai-nightasty")
