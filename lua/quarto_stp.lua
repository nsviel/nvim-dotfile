local ok_runner, runner = pcall(require, "quarto.runner")
if not ok_runner then
  return
end

-- run cell / line / selection (optionnels mais utiles)
vim.keymap.set("n", "<localleader>rc", runner.run_cell,  { desc = "Quarto: run cell", silent = true })
vim.keymap.set("n", "<localleader>rl", runner.run_line,  { desc = "Quarto: run line", silent = true })
vim.keymap.set("v", "<localleader>r",  runner.run_range, { desc = "Quarto: run selection", silent = true })

-- run current slide: between current '##' and next '##'
local function run_current_slide()
  local bufnr = 0
  local cur = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- find start (last "## " above cursor)
  local start = 1
  for i = cur, 1, -1 do
    if lines[i]:match("^##%s") then
      start = i
      break
    end
  end

  -- find end (line before next "## ")
  local finish = #lines
  for i = cur + 1, #lines do
    if lines[i]:match("^##%s") then
      finish = i - 1
      break
    end
  end

  -- visually select slide and run_range (quarto.runner will send cells to Molten)
  vim.api.nvim_win_set_cursor(0, { start, 0 })
  vim.cmd("normal! V")
  vim.api.nvim_win_set_cursor(0, { finish, 0 })
  runner.run_range()
  vim.cmd("normal! <Esc>")
end

vim.keymap.set("n", "<localleader>rs", run_current_slide, { desc = "Quarto: run current slide", silent = true })

