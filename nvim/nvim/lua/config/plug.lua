local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Allow vim to do tmux stuff, like open panes for the test plugin
    'benmills/vimux',
    -- Syntax highlighting for starlark
    'cappyzawa/starlark.vim',
    -- Add mappings to copy to clipboard - doesn't work over ssh
    'christoomey/vim-system-copy',
    -- Navigate through vim splits seamlessly
    'christoomey/vim-tmux-navigator',
    -- Light and configurable statusline
    {'nvim-lualine/lualine.nvim', config = true },
    -- Preview markdown files in the browser
    'JamshedVesuna/vim-markdown-preview',
    -- Test runner integration
    'janko/vim-test',
    -- Generates method stubs for implementing an interface
    'josharian/impl',
    -- Outline viewer for vim
    'majutsushi/tagbar',
    'mhinz/vim-grepper',
    -- Show git diff in the sign column
    'mhinz/vim-signify',
    -- Fancy start screen
    'mhinz/vim-startify',
    -- Toggle quickfix and location windows
    'milkypostman/vim-togglelist',
    -- Unobtrusive scratch window
    'mtth/scratch.vim',
    -- Our colorscheme
    'kabouzeid/nvim-jellybeans',
    'rktjmp/lush.nvim',
    -- Config for built-in nvim lsp
    'neovim/nvim-lspconfig',
    -- nvim-cmp and its plugins
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'quangnguyen30192/cmp-nvim-ultisnips',
        },
    },

    'quangnguyen30192/cmp-nvim-ultisnips',

    -- signature help
    {
        'ray-x/lsp_signature.nvim',
        opts = {
            doc_lines = 0,
            hint_enable = false,
        },
    },

    -- nvim-telescope and dependencies
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                config = function()
                    require"telescope".load_extension("fzf")
                end,
            },
            'nvim-lua/plenary.nvim',
        },
    },

    -- use built-in syntax highlighting engine
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "bash",
                    "c",
                    "comment",
                    "css",
                    "dockerfile",
                    "go",
                    "gomod",
                    "gowork",
                    "hcl",
                    "help",
                    "html",
                    "http",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "proto",
                    "regex",
                    "ruby",
                    "toml",
                    "vim",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },

    -- ANSI escape sequences concealed, but highlighted as specified
    'powerman/vim-plugin-AnsiEsc',
    -- prettier formatting
    {'prettier/vim-prettier', build = 'npm install', ft = {'json', 'markdown'}},
    -- Reveal the commit messages under the cursor in a 'popup window'
    'rhysd/git-messenger.vim',
    -- Make hlsearch more useful
    'romainl/vim-cool',
    -- Directory tree explorer
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        keys = {
            { "<C-n>", "<cmd>Neotree toggle reveal=true<cr>", desc = "Toggle NeoTree" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = true,
        },
    },
    -- Add various code snippets
    {
        'SirVer/ultisnips',
        config = function()
            vim.g.UltiSnipsExpandTrigger = '<C-j>'
        end,
    },
    -- Change case and case-sensitive substitutions
    'tpope/vim-abolish',
    -- Comment stuff out
    'tpope/vim-commentary',
    -- Unix utility commands
    'tpope/vim-eunuch',
    -- Git wrapper
    'tpope/vim-fugitive',
    -- Make . work with tpope's plugins
    'tpope/vim-repeat',
    -- Open selected code in githb in browser
    'tpope/vim-rhubarb',
    -- Provides mappings to easily delete, change and add surroundings (parentheses, brackets, quotes, XML tags, and more) in pairs
    'tpope/vim-surround',
    -- Useful mappings
    'tpope/vim-unimpaired',
    -- Add snippets for Ginkgo BDD testing library for go
    'trayo/vim-ginkgo-snippets',
    'trayo/vim-gomega-snippets',
    'towolf/vim-helm',
    -- Ruby plugin
    'vim-ruby/vim-ruby',
    -- ytt syntax highlighting
    'vmware-tanzu/ytt.vim',
    -- Runs shfmt to auto format the current buffer
    {'z0mbix/vim-shfmt', ft = 'sh' },
})
