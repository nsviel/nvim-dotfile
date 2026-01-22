vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>")

-- Normal: buffers
vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { silent = true })

-- Visual/Select: indent
vim.keymap.set("x", "<Tab>", function() vim.cmd("normal! >gv") end, { silent = true })
vim.keymap.set("x", "<C-i>", function() vim.cmd("normal! >gv") end, { silent = true })

vim.keymap.set("x", "<S-Tab>", function() vim.cmd("normal! <gv") end, { silent = true })
vim.keymap.set("x", "<S-C-i>", function() vim.cmd("normal! <gv") end, { silent = true }) -- au cas où

-- SELECT mode (smap) (souvent souris)
vim.keymap.set("s", "<Tab>", function()
  vim.cmd("normal! \27")   -- <Esc>
  vim.cmd("normal! gv")    -- re-sélection
  vim.cmd("normal! >gv")   -- indent + garder sélection
end, { silent = true })

vim.keymap.set("s", "<C-i>", function()
  vim.cmd("normal! \27")
  vim.cmd("normal! gv")
  vim.cmd("normal! >gv")
end, { silent = true })

vim.keymap.set("s", "<S-Tab>", function()
  vim.cmd("normal! \27")
  vim.cmd("normal! gv")
  vim.cmd("normal! <gv")
end, { silent = true })

vim.keymap.set("s", "<S-C-i>", function()
  vim.cmd("normal! \27")
  vim.cmd("normal! gv")
  vim.cmd("normal! <gv")
end, { silent = true })
