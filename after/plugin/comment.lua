local status, comment_nvim = pcall(require, "Comment")
if (not status) then return end

comment_nvim.setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}
