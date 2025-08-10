-- telescope
vim.keymap.set("n", "<leader>fs", ":Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fp", ":Telescope git_files<cr>")
vim.keymap.set("n", "<leader>fz", ":Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- icon picker
-- vim.keymap.set("n", "<leader>ic", ":IconPickerNormal<cr>", { noremap = true, silent = true })

-- twilight
-- vim.keymap.set("n", "<leader>il", ":Twilight<cr>")

-- zen mode
-- vim.keymap.set("n", "<leader>zm", ":ZenMode<cr>")

--format code using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- markdown preview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>")

-- nvim-comment
vim.keymap.set({"n", "v"}, "<leader>/", ":CommentToggle<cr>")

--toggleterm
--------------------
vim.keymap.set("n", "<leader>t", ":ToggleTerm<cr>")
-- goto-preview --
------------------
--
-- note: lsp config (from lsp.lua)
-- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
-- nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
-- nmap('gt', vim.lsp.buf.type_definition, 'Type [D]efinition')
-- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--
--vim.keymap.set('n', '<leader>gd', ":lua require('goto-preview').goto_preview_definition()<CR>")
--vim.keymap.set('n', '<leader>gt', ":lua require('goto-preview').goto_preview_type_definition()<CR>")
--vim.keymap.set('n', '<leader>gi', ":lua require('goto-preview').goto_preview_implementation()<CR>")
--vim.keymap.set('n', '<leader>gp', ":lua require('goto-preview').close_all_win()<CR>")

-- Run Python file in terminal with leader+enter
vim.keymap.set("n", "<leader><cr>", function()
  if vim.bo.filetype == "python" then
    local file = vim.fn.expand("%")
    vim.cmd("write") -- Save first
    
    local Terminal = require('toggleterm.terminal').Terminal
    local python_term = Terminal:new({
      cmd = "python3 " .. vim.fn.shellescape(file),
      direction = "horizontal",
      size = 15,
      close_on_exit = false,
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })
    python_term:toggle()
  end
end, { desc = "Run Python file in terminal" })

-- Example keymaps for buffer navigation
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')
vim.keymap.set('n', '<leader>1', ':BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', '<leader>2', ':BufferLineGoToBuffer 2<CR>')
-- ... etc

-- Close buffers
vim.keymap.set('n', '<leader>X', ':BufferLinePickClose<CR>')
