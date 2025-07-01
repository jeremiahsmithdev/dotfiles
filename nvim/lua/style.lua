vim.opt.cursorline = true

-- COLORSCHEME
-- vim.g.colors_name = 'gruvbox'
-- vim.g.gruvbox_sign_column = 'bg0' -- sign colunm same as bg

vim.cmd 'colo gruvbox'

-- new? (for gruvbox-material by sainnhe - do I have?)
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_palette = "material" -- material, mix & original

-- Floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e1e", fg = "#c0c0c0" }) -- match your background
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e1e", fg = "#3c3c3c" }) -- subtle border
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e1e", fg = "#1e1e1e" })

