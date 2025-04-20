return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.diff').setup()    -- Git diff
        require('mini.ai').setup()      -- Better surround
        require('mini.animate').setup({ -- Animations
            cursor = { enable = false },
            scroll = {
                enable = true,
                timing = function() return 1 end,
            },
        })
    end
}
