local api = require 'nvim-tree.api'

require 'nvim-tree'.setup {
  auto_reload_on_write = true,
  create_in_closed_folder = false,
  disable_netrw = false,
  hijack_cursor = true,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  open_on_tab = false,
  ignore_buf_on_tab_change = {},
  sort_by = 'name',
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = true,
  reload_on_bufenter = false,
  respect_buf_cwd = true,
  view = {
    adaptive_size = false,
    centralize_selection = false,
    width = 30,
    hide_root_folder = false,
    side = 'left',
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = 'none',
    root_folder_modifier = ':~',
    indent_markers = {
      enable = true,
      icons = {
        corner = '└',
        edge = '│',
        item = '│',
        none = ' ',
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = 'before',
      padding = ' ',
      symlink_arrow = ' ➛ ',
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = '',
        symlink = '',
        bookmark = '',
        folder = {
          arrow_closed = '',
          arrow_open = '',
          default = '',
          open = '',
          empty = '',
          empty_open = '',
          symlink = '',
          symlink_open = '',
        },
        git = {
          unstaged = 'M',
          staged = 'S',
          unmerged = '',
          renamed = 'R',
          deleted = '',
          untracked = 'U',
          ignored = '◌',
        },
      },
    },
    special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
    symlink_destination = true,
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_root = false,
    ignore_list = {},
  },
  system_open = {
    cmd = '',
    args = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    debounce_delay = 50,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  filters = {
    dotfiles = false,
    custom = { '\\.git$' },
    exclude = {},
  },
  filesystem_watchers = {
    enable = true,
    debounce_delay = 50,
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = {},
    },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
    remove_file = {
      close_window = true,
    },
  },
  trash = {
    cmd = 'gio trash',
    require_confirm = false,
  },
  live_filter = {
    prefix = '[FILTER]: ',
    always_show_folders = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },
  on_attach = function(bufnr)
    local opts = function(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    vim.keymap.set('n', '<c-e>', api.node.open.replace_tree_buffer, opts 'Open: In Place')
    vim.keymap.set('n', '<s-o>', api.node.open.no_window_picker, opts 'Open: No Window Picker')
    vim.keymap.set('n', 'c', api.tree.change_root_to_node, opts 'CD')
    vim.keymap.set('n', '<c-v>', api.node.open.vertical, opts 'Open: Vertical Split')
    vim.keymap.set('n', '<c-x>', api.node.open.horizontal, opts 'Open: Horizontal Split')
    vim.keymap.set('n', '<c-t>', api.node.open.tab, opts 'Open: New Tab')
    vim.keymap.set('n', '<c-k>', api.node.navigate.sibling.prev, opts 'Previous Sibling')
    vim.keymap.set('n', '<c-j>', api.node.navigate.sibling.next, opts 'Next Sibling')
    vim.keymap.set('n', '<s-p>', api.node.navigate.parent, opts 'Parent Directory')
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts 'Close Directory')
    vim.keymap.set('n', 'l', api.node.open.edit, opts 'Open')
    vim.keymap.set('n', '<s-h>', api.tree.collapse_all, opts 'Collapse')
    vim.keymap.set('n', '<s-l>', api.tree.expand_all, opts 'Expand All')
    vim.keymap.set('n', '<tab>', api.node.open.preview, opts 'Open Preview')
    vim.keymap.set('n', '<s-i>', api.tree.toggle_gitignore_filter, opts 'Toggle Git Ignore')
    vim.keymap.set('n', '<s-d>', api.tree.toggle_hidden_filter, opts 'Toggle Dotfiles')
    vim.keymap.set('n', '<s-u>', api.tree.toggle_custom_filter, opts 'Toggle Hidden')
    vim.keymap.set('n', '<s-r>', api.tree.reload, opts 'Refresh')
    vim.keymap.set('n', 'a', api.fs.create, opts 'Create')
    vim.keymap.set('n', '<s-d>', api.fs.remove, opts 'Delete')
    vim.keymap.set('n', 'd', api.fs.trash, opts 'Trash')
    vim.keymap.set('n', '<c-r>', api.fs.rename, opts 'Rename')
    vim.keymap.set('n', 'r', api.fs.rename_sub, opts 'Rename: Omit Filename')
    vim.keymap.set('n', 'x', api.fs.cut, opts 'Cut')
    vim.keymap.set('n', 'y', api.fs.copy.node, opts 'Copy')
    vim.keymap.set('n', 'p', api.fs.paste, opts 'Paste')
    vim.keymap.set('n', '<c-y>', api.fs.copy.filename, opts 'Copy Name')
    vim.keymap.set('n', '<s-y>', api.fs.copy.relative_path, opts 'Copy Relative Path')
    vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts 'Copy Absolute Path')
    vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts 'Prev Diagnostic')
    vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts 'Prev Git')
    vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts 'Next Diagnostic')
    vim.keymap.set('n', ']c', api.node.navigate.git.next, opts 'Next Git')
    vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts 'Up')
    vim.keymap.set('n', 's', api.node.run.system, opts 'Run System')
    vim.keymap.set('n', 'f', api.live_filter.start, opts 'Filter')
    vim.keymap.set('n', 'F', api.live_filter.clear, opts 'Clean Filter')
    vim.keymap.set('n', 'q', api.tree.close, opts 'Close')
    vim.keymap.set('n', '<s-s>', api.tree.search_node, opts 'Search')
    vim.keymap.set('n', '.', api.node.run.cmd, opts 'Run Command')
    vim.keymap.set('n', '<space>k', api.node.show_info_popup, opts 'Info')
    vim.keymap.set('n', 'g?', api.tree.toggle_help, opts 'Help')
    vim.keymap.set('n', 'm', api.marks.toggle, opts 'Toggle Bookmark')
    vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts 'Move Bookmarked')
  end,
}

require 'user.utils'.register_maps {
  { 'n', '<space>e', api.tree.toggle },
}
