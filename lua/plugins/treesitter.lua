require'nvim-treesitter.configs'.setup{
  -- 支持的语言
  ensure_installed = {"python", "javascript", "go", "vim", "lua", "help"},
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil
  }
}
