---@type LazySpec
return {
  { import = "astrocommunity.pack.nix" },
  {
    "AstroNvim/astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(self, opts)
      opts.servers = opts.servers or {}
      -- opts.servers = vim.tbl_filter(function(server) return server ~= "nixd" end, opts.servers)
      -- require("astrocore").list_insert_unique(opts.servers, { "tix" })
      return require("lazy.util").merge(opts, {
        config = {
          nixd = {
            settings = {
              nixd = {
                nixpkgs = {
                  expr = "import <nixpkgs> { }",
                },
                options = {
                  nixos = {
                    expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.nixos.options',
                  },
                  home_manager = {
                    expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.nixos.options.home-manager.users.type.getSubOptions []",
                  },
                },
                formatting = {
                  command = { "alejandra" },
                },
              },
            },
          },
        },
      })
    end,
  },
}
