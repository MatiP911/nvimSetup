return {
    'm4xshen/autoclose.nvim',
    config = function()
        require('nvim_comment').setup({line_mapping = "<leader>c", operator_mapping = "<C-_>", comment_chunk_text_object = "ic",
        -- z jakiegoś powodu <C-_> oznaczca ctrl+/
        hook = function()
            if vim.api.nvim_buf_get_option(0, "filetype") == "cpp" or vim.api.nvim_buf_get_option(0, "filetype") == "c" then
                vim.api.nvim_buf_set_option(0, "commentstring", "//%s")
            end
        end})
    end}
