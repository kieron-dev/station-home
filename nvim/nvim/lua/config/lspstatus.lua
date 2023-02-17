local lsp_status = require 'lsp-status'

lsp_status.config{
    status_symbol = '',
    indicator_hint = '',
}
lsp_status.register_progress()
