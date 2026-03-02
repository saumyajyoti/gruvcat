local M = {}

-- Stores the resolved config after setup() is called
M._config = nil

--- Configure gruvcat. Call this before :colorscheme gruvcat (optional).
---@param opts table|nil
function M.setup(opts)
  local config = require("gruvcat.config")
  M._config = config.resolve(opts)
end

--- Load the colorscheme. Called automatically by colors/gruvcat.lua.
function M.load()
  -- Ensure config is initialized even if setup() was never called
  if not M._config then
    local config = require("gruvcat.config")
    M._config = config.resolve(nil)
  end

  local cfg = M._config

  -- 1. Resolve variant
  local variant = cfg.variant
  if variant == "auto" then
    variant = vim.o.background == "light" and "light" or "dark"
  end

  -- 2. Determine catppuccin flavor to activate
  local flavour = variant == "light" and "latte" or "mocha"

  -- 3. Attempt to load catppuccin
  local ok, catppuccin = pcall(require, "catppuccin")
  if not ok then
    vim.notify(
      "[gruvcat] catppuccin/nvim is not installed or could not be loaded.\n"
        .. "Please install it as a dependency: https://github.com/catppuccin/nvim",
      vim.log.levels.ERROR
    )
    return
  end

  -- 4. Build catppuccin options, injecting both palettes via color_overrides.
  -- Both latte and mocha are always overridden so switching vim.o.background
  -- works without calling setup() again.
  local dark_palette  = require("gruvcat.palettes.dark")
  local light_palette = require("gruvcat.palettes.light")
  local user_overrides = (cfg.catppuccin.color_overrides or {})

  local cat_opts = vim.deepcopy(cfg.catppuccin)
  cat_opts.color_overrides = {
    all   = user_overrides.all,
    mocha = vim.tbl_extend("force", dark_palette,  user_overrides.mocha or {}),
    latte = vim.tbl_extend("force", light_palette, user_overrides.latte or {}),
  }

  -- 5. Apply catppuccin setup and activate the specific flavor colorscheme.
  catppuccin.setup(cat_opts)

  -- catppuccin's compiler captures `require("catppuccin").options` into a
  -- module-level local at require()-time. catppuccin.setup() replaces the
  -- M.options table entirely, so the cached compiler still holds a reference
  -- to the old (pre-setup) options and compiles with vanilla catppuccin colors.
  -- Purging catppuccin submodules from package.loaded forces the compiler to
  -- re-require catppuccin and pick up the updated options on the next compile,
  -- which is the same approach used by catppuccin's own :CatppuccinCompile.
  for name in pairs(package.loaded) do
    if name:match("^catppuccin%.") then
      package.loaded[name] = nil
    end
  end

  if type(catppuccin.compile) == "function" then
    catppuccin.compile()
  end
  vim.cmd("colorscheme catppuccin-" .. flavour)

  -- Re-apply after UIEnter so the colorscheme survives other eager plugins
  -- (e.g. snacks.nvim) that also run at priority=1000 and may reset it.
  vim.api.nvim_create_autocmd("UIEnter", {
    once = true,
    nested = true,
    callback = function()
      vim.cmd("colorscheme catppuccin-" .. flavour)
    end,
  })
end

return M
