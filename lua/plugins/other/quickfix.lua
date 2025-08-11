---@type LazySpec
return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    dependencies = {
      "AstroNvim/astrocore",
      ---@param opts AstroCoreOpts
      opts = function(_, opts)
        if not opts.signs then opts.signs = {} end
        opts.signs.BqfSign = { text = " " .. require("astroui").get_icon "Selected", texthl = "BqfSign" }
      end,
    },
    ---@module "bqf"
    ---@type BqfConfig
    opts = {
      func_map = {
        open = "<CR>",
        openc = "o",
        drop = "O",
        split = "<C-x>",
        vsplit = "<C-v>",
        tab = "t",
        tabb = "T",
        tabc = "<C-t>",
        tabdrop = "",
        ptogglemode = "<localleader>m",
        ptoggleitem = "zp",
        ptoggleauto = "<a-p>",
        pscrollup = "<C-b>",
        pscrolldown = "<C-f>",
        pscrollorig = "zo",
        prevfile = "[[",
        nextfile = "]]",
        prevhist = "<",
        nexthist = ">",
        lastleave = [['"]],
        stoggleup = "<S-Tab>",
        stoggledown = "<Tab>",
        stogglevm = "<Tab>",
        stogglebuf = [['<Tab>]],
        sclear = "z<Tab>",
        filter = "zn",
        filterr = "zN",
        fzffilter = "zf",
      },
    },
  },
  { import = "astrocommunity.quickfix.quicker-nvim" },
  {
    "romainl/vim-qf",
    dependencies = {

      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          g = {},
        },
      },
    },
  },
}
