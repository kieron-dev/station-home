local nvim_lsp = require 'lspconfig'

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- disable inline diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
		underline = true,
		signs = true,
    }
)

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gd', ':Telescope lsp_definitions<cr>', opts)
    buf_set_keymap('n', 'gr', ':Telescope lsp_references<cr>', opts)
    buf_set_keymap('n', 'gi', ':Telescope lsp_implementations<cr>', opts)
    buf_set_keymap('n', 'gy', ':Telescope lsp_type_definitions<cr>', opts)
    buf_set_keymap('n', 'gs', ':Telescope lsp_document_symbols<CR>', opts)

    buf_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', opts)
    -- once the range version of code_action is fixed, we can ditch the params below
    buf_set_keymap('v', '<leader>ca', ':lua vim.lsp.buf.code_action({range = { start = {vim.fn.getpos("\'<")[2], 0}, [\'end\'] = {vim.fn.getpos("\'>")[2], 0}}})<CR>', opts)

    buf_set_keymap('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', opts)

    buf_set_keymap('n', '[g', ':lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']g', ':lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<leader>eb', ":lua require'telescope.builtin'.diagnostics{bufnr = 0}<cr>", opts)
    buf_set_keymap('n', '<leader>ea', ":lua require'telescope.builtin'.diagnostics{severity = 'error'}<cr>", opts)

    buf_set_keymap('n', '<leader>oi', ':lua vim.lsp.buf.code_action({context = {only = {"source.organizeImports"}}, apply = true})<CR>', opts)
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "tsserver", "bashls" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

nvim_lsp.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'gopls', '--remote=auto' },
    settings = {
        gopls = {
            completeUnimported = true,
            staticcheck = true,
            gofumpt = true,
            analyses = {
                nilness = true,
                shadow = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
                unusedvariable = true,
            },
        }
    },
}
