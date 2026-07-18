return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 
    'nvim-treesitter/nvim-treesitter',
    'echasnovski/mini.nvim',
    'echasnovski/mini.icons'
  },
  opts = {
    -- Keep Markdown rendered in every mode, including Insert mode.
    render_modes = true,

    -- Do not reveal markdown beneath the cursor
    anti_conceal = {
      enabled = false,
    },
  },
  keys = {
    {
      '<leader>mt',
      '<cmd>RenderMarkdown buf_toggle<cr>',
      desc = 'Toggle rendered/raw markdown'
    }
  }
}
