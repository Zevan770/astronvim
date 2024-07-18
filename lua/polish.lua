-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
    -- see zsh as bash
    ["%.zsh"] = "bash",
    ["%.zshrc"] = "bash",
    ["%.zshenv"] = "bash",
    ["%.zprofile"] = "bash",
    ["%.zlogin"] = "bash",
    ["%.zlogout"] = "bash",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
    [".*settings.*%.json"] = "jsonc",
    [".*keybindings.*%.json"] = "jsonc",
  },
}
