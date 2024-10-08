vim.keymap.set("n", "<leader>gs", ":Ge:<CR>")

vim.keymap.set("n", "<leader>gd", ":set nosplitright<CR>:execute 'Gvdiff ' .. g:git_base<CR>:set splitright<CR>")
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>")
vim.keymap.set("n", "<leader>gc", ":0Gclog<CR>", { noremap = false })

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("my_fugitive_group", {}),
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>gp", function()
      vim.cmd.Git('push')
    end, opts)

    -- rebase always
    vim.keymap.set("n", "<leader>gP", function()
      -- vim.cmd.Git({'pull',  '--rebase'})
      vim.cmd.Git({ 'pull' })
    end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    -- vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
  end,
})
