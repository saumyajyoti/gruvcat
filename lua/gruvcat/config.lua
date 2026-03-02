local M = {}

M.defaults = {
  -- "dark" | "light" | "auto" (follows vim.o.background)
  variant = "auto",

  -- All keys under `catppuccin` are forwarded to catppuccin.setup() as-is.
  -- This avoids key collisions with gruvcat's own options.
  catppuccin = {
    default_integrations = true,
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = false,
    dim_inactive = {
      enabled = false,
      shade = "dark",
      percentage = 0.15,
    },
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = { "italic", "nocombine" },
      conditionals = { "italic" },
      loops = { "italic", "nocombine" },
      functions = { "bold", "italic" },
      keywords = { "italic", "nocombine" },
      strings = {},
      variables = { "nocombine" },
      numbers = {},
      booleans = { "italic" },
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      alpha = true,
      sandwich = false,
      noice = true,
      leap = true,
      markdown = true,
      neotest = true,
      cmp = true,
      overseer = true,
      lsp_trouble = true,
      rainbow_delimiters = true,
      mason = true,
      neotree = true,
      notify = true,
      which_key = true,
      treesitter = true,
      flash = true,
      aerial = true,
      semantic_tokens = true,
      telescope = { enabled = true, style = "nvchad" },
      dap = { enabled = true, enable_ui = true },
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        scope_color = "overlay1",
        colored_indent_levels = true,
      },
      mini = {
        enabled = true,
        indentscope_color = "overlay2",
      },
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = {},
          information = {},
        },
        underlines = {
          errors = {},
          hints = {},
          warnings = {},
          information = {},
        },
        inlay_hints = {
          background = true,
        },
      },
    },
    highlight_overrides = {},
    custom_highlights = function(colors)
      return {
        NormalFloat                  = { bg = colors.surface0 },
        FloatBorder                  = { fg = colors.overlay0 },
        VertSplit                    = { bg = colors.base, fg = colors.surface1 },
        FoldColumn                   = { fg = colors.overlay0, bg = colors.mantle },
        LineNr                       = { fg = colors.overlay0, bg = colors.mantle },
        CursorLineNr                 = { fg = colors.mauve, bg = colors.surface0, style = {} },
        CursorLineSign               = { bg = colors.surface0 },
        CursorLineFold               = { bg = colors.surface0 },
        Pmenu                        = { bg = colors.mantle, fg = "" },
        PmenuSel                     = { bg = colors.surface0, fg = colors.subtext0 },
        LazySpecial                  = { style = {} },
        LazyProgressDone             = { fg = colors.blue, style = { "nocombine" } },
        LazyProgressTodo             = { fg = colors.overlay0, style = { "nocombine" } },
        IndentBlanklineContextChar   = { fg = colors.peach },
        TelescopePreviewNormal       = { bg = colors.crust },
        TelescopePreviewBorder       = { bg = colors.crust, fg = colors.crust },
        IndentBlanklineChar          = { fg = colors.blue },
        GitSignsChange               = { fg = colors.peach },
        GitSignsCurrentLineBlame     = { fg = colors.crust, bg = colors.surface2 },
        String                       = { fg = colors.yellow },
        Function                     = { fg = colors.green },
        ["@function.macro"]          = { fg = colors.mauve },
        Type                         = { fg = colors.blue },
        ["@type.builtin.cpp"]        = { fg = colors.blue, style = { "bold" } },
        ["@type.builtin"]            = { fg = colors.blue, style = { "bold" } },
        ["@lsp.type.type"]           = {},
        Structure                    = { fg = colors.teal },
        Comment                      = { fg = colors.overlay1 },
        cTypedef                     = { fg = colors.pink, style = { "italic" } },
        cDefine                      = { fg = colors.pink, style = { "italic" } },
        cStructure                   = { fg = colors.yellow },
        StorageClass                 = { fg = colors.pink, style = { "italic" } },
        cStorageclass                = { fg = colors.pink, style = { "italic" } },
        PreProc                      = { fg = colors.flamingo, style = { "italic", "nocombine" } },
        Keyword                      = { fg = colors.maroon },
        Conditional                  = { fg = colors.red },
        Repeat                       = { fg = colors.red },
        ["@keyword.return"]          = { fg = colors.flamingo, style = { "bold", "italic", "nocombine" } },
        ["@parameter"]               = { fg = colors.sapphire, style = { "italic" } },
        ["@property"]                = { fg = colors.subtext1 },
        WinBar                       = { fg = colors.overlay2, bg = colors.mantle },
        MatchParen                   = { fg = colors.lavender, bg = colors.surface0, style = {} },
        ["@lsp.type.property.c"]     = {},
        ["@function.call.c"]         = { fg = colors.green, style = { "bold", "italic", "nocombine" } },
        ["@lsp.type.property.lua"]   = {},
        ["@variable.member"]         = { fg = colors.subtext1 },
      }
    end,
  },
}

--- Deep-merge `src` into `dst`. Values in `src` take precedence.
--- Tables are merged recursively; scalar values are overwritten.
---@param dst table
---@param src table
---@return table
local function deep_merge(dst, src)
  for k, v in pairs(src) do
    if type(v) == "table" and type(dst[k]) == "table" then
      deep_merge(dst[k], v)
    else
      dst[k] = v
    end
  end
  return dst
end

--- Resolve user options against defaults, returning a new merged table.
--- Uses vim.deepcopy to prevent mutation of M.defaults across calls.
---@param user_opts table|nil
---@return table
function M.resolve(user_opts)
  local opts = vim.deepcopy(M.defaults)
  if user_opts then
    deep_merge(opts, user_opts)
  end
  return opts
end

return M
