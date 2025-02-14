require 'window-picker'.setup {
  -- type of hints you want to get
  -- following types are supported
  -- 'statusline-winbar' | 'floating-big-letter'
  -- 'statusline-winbar' draw on 'statusline' if possible, if not 'winbar' will be
  -- 'floating-big-letter' draw big letter on a floating window
  -- used
  hint = 'statusline-winbar',

  -- when you go to window selection mode, status bar will show one of
  -- following letters on them so you can use that letter to select the window
  selection_chars = 'FJDKSLAÉCMRUEIWOQP',

  -- This section contains picker specific configurations
  picker_config = {
    statusline_winbar_picker = {
      -- You can change the display string in status bar.
      -- It supports '%' printf style. Such as `return char .. ': %f'` to display
      -- buffer file path. See :h 'stl' for details.
      --selection_display = function(char, windowid)
      --  return '%=' .. char .. '%='
      --end,

      -- whether you want to use winbar instead of the statusline
      -- "always" means to always use winbar,
      -- "never" means to never use winbar
      -- "smart" means to use winbar if cmdheight=0 and statusline if cmdheight > 0
      use_winbar = 'never', -- "always" | "never" | "smart"
    },
  },

  -- whether to show 'Pick window:' prompt
  show_prompt = false,

  -- if you want to manually filter out the windows, pass in a function that
  -- takes two parameters. You should return window ids that should be
  -- included in the selection
  -- EX:-
  -- function(window_ids, filters)
  --    -- folder the window_ids
  --    -- return only the ones you want to include
  --    return {1000, 1001}
  -- end
  --filter_func = nil,

  -- following filters are only applied when you are using the default filter
  -- defined by this plugin. If you pass in a function to "filter_func"
  -- property, you are on your own
  filter_rules = {
    -- when there is only one window available to pick from, use that window
    -- without prompting the user to select
    autoselect_one = true,

    -- whether you want to include the window you are currently on to window
    -- selection or not
    include_current_win = false,

    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'neo-tree', 'neo-tree-popup', 'Trouble', 'qf', 'fugitive', 'fidget' },

      -- if the buftype is one of following, the window will be ignored
      buftype = { 'terminal', 'quickfix' },
    },

    -- filter using window options
    --wo = {},

    -- if the file path contains one of following names, the window
    -- will be ignored
    --file_path_contains = {},

    -- if the file name contains one of following names, the window will be
    -- ignored
    --file_name_contains = {},
  },
}
