-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function gh(repo) return 'https://github.com/' .. repo end

-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end

-- ============================================================
-- CUSTOM PLUGINS
-- ============================================================

-- 1. Install required dependencies
-- (Oil uses devicons, and Hardtime uses plenary, but Kickstart already installed both earlier!)
-- Hardtime also requires 'nui.nvim', so we must explicitly add it:
vim.pack.add { gh 'MunifTanjim/nui.nvim' }

-- 2. Install and configure oil.nvim
vim.pack.add { gh 'stevearc/oil.nvim' }
require('oil').setup {
  -- Oil will replace netrw (the default file explorer) entirely
  default_file_explorer = true,
}
-- Map the "-" key to open Oil in the current directory
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory via Oil' })

-- 3. Install and configure hardtime.nvim
vim.pack.add { gh 'm4xshen/hardtime.nvim' }
require('hardtime').setup {
  -- Hardtime is enabled by default.
  -- You can tweak the max repeated keys allowed before it yells at you here.
  max_count = 3,
  disable_mouse = true,
}
vim.pack.add { gh 'nvzone/volt' }
vim.pack.add { gh 'nvzone/typr' }
vim.pack.add { gh 'CRAG666/code_runner.nvim' }
-- Install Molten for interactive Jupyter execution
vim.pack.add { gh 'benlubas/molten-nvim' }

-- Use pcall to prevent crashes during the initial background download
local molten_ok, molten = pcall(require, 'molten')
if molten_ok then
  molten.setup {
    -- Keep it empty for now
  }
end
-- Install Jupytext to translate .ipynb JSON into readable Python
vim.pack.add { gh 'GCBallesteros/jupytext.nvim' }
require('jupytext').setup {
  style = 'light', -- This strips away the ugly metadata formatting
  output_extension = 'py', -- Presents the file to you as a standard Python file
  force_ft = 'python', -- Forces Neovim to give you Python syntax highlighting
}
