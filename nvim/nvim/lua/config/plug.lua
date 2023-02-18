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
    -- lsp status helper
    'nvim-lua/lsp-status.nvim',

    -- nvim-cmp and its plugins
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'quangnguyen30192/cmp-nvim-ultisnips',

    -- signature help
    'ray-x/lsp_signature.nvim',

    -- nvim-telescope and dependencies
    'nvim-lua/plenary.nvim',
    {'nvim-telescope/telescope.nvim', branch = '0.1.x' },
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- use built-in syntax highlighting engine
    {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
    -- ANSI escape sequences concealed, but highlighted as specified
    'powerman/vim-plugin-AnsiEsc',
    -- prettier formatting
    {'prettier/vim-prettier', build = 'npm install', ft = {'json', 'markdown'}},
    -- Reveal the commit messages under the cursor in a 'popup window'
    'rhysd/git-messenger.vim',
    -- Make hlsearch more useful
    'romainl/vim-cool',
    -- Directory tree explorer
    'scrooloose/nerdtree',
    -- Add various code snippets
    {'SirVer/ultisnips',
    lazy = false,
    config = function()
        vim.g.UltiSnipsExpandTrigger = '<C-j>'
    end,
    },
    -- Comment stuff out
    'tpope/vim-abolish',
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
