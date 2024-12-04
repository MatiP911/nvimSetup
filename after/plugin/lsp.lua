require("mason").setup()
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

require('mason').setup({})
require('mason-lspconfig').setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    }
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({}),
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        -- Simple tab complete
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1

            if cmp.visible() then
                cmp.select_next_item({ behavior = 'insert' })
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),

        -- Go to previous item
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'insert' }),
    }),
})

local show_hints = true -- Zmienna kontrolująca widoczność hintów

function ToggleHints()
    show_hints = not show_hints

    if show_hints then
        vim.diagnostic.config({
            severity_sort = true,
            virtual_text = {
                prefix = '●',
                spacing = 4,
                severity = nil, -- Pokazuj wszystkie rodzaje (w tym hinty)
            },
            signs = true,
            underline = true, -- Włącz podkreślanie dla wszystkich
            update_in_insert = false,
        })
        print("Hints ON")
    else
        vim.diagnostic.config({
            severity_sort = true,
            virtual_text = {
                prefix = '●',
                spacing = 4,
                severity = { min = vim.diagnostic.severity.WARN }, -- Ukryj hinty
            },
            signs = true,
            underline = {
                severity = { min = vim.diagnostic.severity.WARN }, -- Wyłącz podkreślanie dla hintów
            },
            update_in_insert = false,
        })
        print("Hints OFF")
    end
end

vim.keymap.set('n', '<Leader>th', ToggleHints, { desc = "Toggle LSP hints" })
