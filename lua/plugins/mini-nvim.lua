return {
    'echasnovski/mini.nvim',
    config = function()
        require('mini.diff').setup() -- Git diff
        require('mini.ai').setup() -- Better surround
    end
}
