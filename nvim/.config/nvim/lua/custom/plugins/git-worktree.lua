local function delete_worktree()
  local result = vim.system({ 'git', 'worktree', 'list', '--porcelain' }, { text = true }):wait()

  if result.code ~= 0 then
    vim.notify(result.stderr or 'Unable to list Git worktrees', vim.log.levels.ERROR)
    return
  end

  local root_result = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true }):wait()
  local current_root = root_result.code == 0 and vim.trim(root_result.stdout) or nil
  local worktrees = {}
  local current_worktree

  for line in result.stdout:gmatch '[^\r\n]+' do
    local path = line:match '^worktree (.+)$'
    if path then
      current_worktree = { path = path, branch = '(detached)' }
      if path ~= current_root then
        table.insert(worktrees, current_worktree)
      end
    elseif current_worktree then
      current_worktree.branch = line:match '^branch refs/heads/(.+)$' or current_worktree.branch
      current_worktree.locked = line:match '^locked%s*(.*)$' or current_worktree.locked
    end
  end

  if vim.tbl_isempty(worktrees) then
    vim.notify 'No other Git worktrees to delete'
    return
  end

  vim.ui.select(worktrees, {
    prompt = 'Delete Git worktree',
    format_item = function(worktree)
      local lock_status = worktree.locked and ' [locked]' or ''
      return string.format('%s%s  %s', worktree.branch, lock_status, worktree.path)
    end,
  }, function(worktree)
    if not worktree then
      return
    end

    if worktree.locked then
      vim.notify(
        string.format(
          'Worktree is locked: %s\nStop its owning process, then run `git worktree unlock %s` before deleting it.',
          worktree.locked ~= '' and worktree.locked or 'no reason provided',
          worktree.path
        ),
        vim.log.levels.WARN
      )
      return
    end

    local choice = vim.fn.confirm('Delete worktree at ' .. worktree.path .. '?', '&Yes\n&No', 2)
    if choice == 1 then
      local command = { 'git' }
      if current_root then
        vim.list_extend(command, { '-C', current_root })
      end
      vim.list_extend(command, { 'worktree', 'remove', worktree.path })

      vim.system(command, { text = true }, function(remove_result)
        vim.schedule(function()
          if remove_result.code == 0 then
            vim.notify('Deleted Git worktree: ' .. worktree.path)
          else
            local message = vim.trim(remove_result.stderr or '')
            vim.notify(message ~= '' and message or 'Failed to delete Git worktree', vim.log.levels.ERROR)
          end
        end)
      end)
    end
  end)
end

return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('git-worktree').setup {
      change_directory_command = 'cd',
      update_on_change = true,
      update_on_change_command = 'e .',
      clearjumps_on_change = true,
      autopush = false,
    }

    require('telescope').load_extension 'git_worktree'
  end,
  keys = {
    {
      '<leader>gwt',
      function()
        require('telescope').extensions.git_worktree.git_worktrees()
      end,
      desc = 'Switch/delete Git worktree',
    },
    {
      '<leader>gW',
      function()
        require('telescope').extensions.git_worktree.create_git_worktree()
      end,
      desc = 'Create Git worktree',
    },
    {
      '<leader>gwd',
      delete_worktree,
      desc = 'Delete Git worktree',
    },
  },
}
