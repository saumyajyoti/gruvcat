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
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {},
    highlight_overrides = {},
    custom_highlights = {},
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
