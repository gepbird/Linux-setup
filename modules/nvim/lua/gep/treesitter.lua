require 'nvim-treesitter.configs'.setup {
  autopairs = {
    enable = true,
  },
  highlight = {
    enable = true,
    -- disable slow treesitter highlight for large files
    disable = function(_, buffer)
      return require 'gep.utils'.is_file_big(buffer)
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
  },
}

vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#FAD430' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterPurple', { fg = '#c792ea' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#64B5F6' })
local rainbow = require 'rainbow-delimiters'
require 'rainbow-delimiters.setup'.setup {
  strategy = {
    html = rainbow.strategy.noop,
  },
  highlight = {
    'RainbowDelimiterYellow',
    'RainbowDelimiterPurple',
    'RainbowDelimiterBlue',
  },
  -- blacklisted because opening these filetypes takes a long time
  blacklist = { 
    'markdown', -- nvim docs
    'latex', -- ~450ms improvement~
  },
}

require 'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['a-'] = '@comment.outer',
        ['as'] = '@statement.outer',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['a,'] = '@parameter.outer',
        ['i,'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
      selection_modes = {
        ['@function.outer'] = '<s-v>',
        ['@class.outer'] = '<s-v>',
      },
      include_surrounding_whitespace = true,
    },
    swap = {
      enable = true,
      swap_next = {
        ['<space>s,'] = '@parameter.inner',
      },
      swap_previous = {
        ['<space><s-s>,'] = '@parameter.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ['gf'] = '@function.outer',
        --['gc'] = '@class.outer',
      },
    },
  },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
}
