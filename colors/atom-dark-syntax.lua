-- Atom Dark Syntax (ported from Pulsar atom-dark-syntax)
vim.opt.termguicolors = true
vim.o.background = "dark"

local set = vim.api.nvim_set_hl

vim.cmd("highlight clear")
vim.g.colors_name = "atom-dark-syntax"

local c = {
  bg        = "#161616",
  fg        = "#c5c8c6",
  cursor    = "#ffffff",
  selection = "#444444",

  comment   = "#8A8A8A", 
  string    = "#A8FF60", 
  keyword   = "#96CBFE", 
  variable  = "#C6C5FE", 
  func      = "#FFD2A7",
  builtin   = "#DAD085", 
  constant  = "#FF73FD", 
  number    = "#FF73FD", 

  error     = "#FD5FF1", 
  line_nr   = "#373b41",
  cursorline= "#282a2e",

  -- Folding
  fold_bg   = "#202224",  
  fold_fg   = "#9da1a6", 
  fold_col  = "#8e9aa5",
}

-- UI
set(0, "Normal",       { fg = c.fg, bg = c.bg })
set(0, "Cursor",       { fg = c.bg, bg = c.cursor })
set(0, "Visual",       { bg = c.selection })
set(0, "CursorLine",   { bg = c.cursorline })
set(0, "LineNr",       { fg = c.line_nr })
set(0, "CursorLineNr", { fg = c.fg, bold = true })

-- Vim highlight groups
set(0, "Comment",    { fg = c.comment, italic = true })
set(0, "String",     { fg = c.string })
set(0, "Character",  { fg = c.string })

set(0, "Keyword",    { fg = c.keyword })
set(0, "Statement",  { fg = c.keyword })
set(0, "PreProc",    { fg = c.keyword })

set(0, "Identifier", { fg = c.variable })  -- important (violet)
set(0, "Function",   { fg = c.func })      -- important (jaune)
set(0, "Constant",   { fg = c.constant })
set(0, "Number",     { fg = c.number })
set(0, "Boolean",    { fg = c.number })
set(0, "Float",      { fg = c.number })

-- Diagnostics (simple)
set(0, "DiagnosticError", { fg = c.error })
set(0, "Error",           { fg = c.error })

-- Tree-sitter mappings
set(0, "@comment",          { link = "Comment" })
set(0, "@string",           { link = "String" })
set(0, "@character",        { link = "Character" })

set(0, "@keyword",          { link = "Keyword" })
set(0, "@function",         { link = "Function" })
set(0, "@function.builtin", { fg = c.builtin })   -- pour coller à css.less
set(0, "@variable",         { link = "Identifier" })
set(0, "@constant",         { link = "Constant" })
set(0, "@number",           { link = "Number" })
set(0, "@boolean",          { link = "Boolean" })

-- LSP semantic tokens (si activés)
set(0, "@lsp.type.function", { link = "Function" })
set(0, "@lsp.type.variable", { link = "Identifier" })
set(0, "@lsp.type.keyword",  { link = "Keyword" })
set(0, "@lsp.type.number",   { link = "Number" })

-- Python-specific refinements (match Pulsar)
-- function calls / methods
vim.api.nvim_set_hl(0, "@method",         { link = "Function" })
vim.api.nvim_set_hl(0, "@function.call",  { link = "Function" })

-- named arguments: exists_ok
vim.api.nvim_set_hl(0, "@parameter",      { link = "Identifier" })
vim.api.nvim_set_hl(0, "@variable.parameter", { link = "Identifier" })

-- booleans / None
vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })
vim.api.nvim_set_hl(0, "@boolean",           { link = "Constant" })

-- Folding
set(0, "Folded", {fg = c.fg, bg = c.bg,})
set(0, "FoldColumn", {fg = c.fg, bg = c.bg,})
set(0, "UfoFoldedFg", { fg = c.fg })
set(0, "UfoFoldedBg", { bg = c.bg })
