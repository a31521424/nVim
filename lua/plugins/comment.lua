require("Comment").setup{
   toggler = {
        line = '<C-/>',
        block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = '<C-/>',
        ---Block-comment keymap
        block = 'gb',
    },
}
