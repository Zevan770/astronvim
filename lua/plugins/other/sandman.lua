if true then return {} end
return {
  -- blocking network access from plugins
  -- 其实就是君子协定，顶多防一防直接用 curl 的
  {
    "stasfilin/nvim-sandman",
    config = function()
      require("nvim_sandman").setup {
        enabled = false,
        mode = "block_all", -- block_all | blocklist | allowlist
        allow = { "lazy.nvim", "blink.cmp", "nvim-treesitter", "mason.nvim" },
        policy = {
          enabled = true,
          mode = "enforce", -- monitor | enforce
          default = "allow", -- allow | deny | prompt_once
          audit = {
            enabled = true,
            path = vim.fn.stdpath "state" .. "/nvim-sandman-policy-audit.jsonl",
          },
          rules = {
            { id = "deny-curl", action = "exec", exe = "curl", decision = "deny" },
            { id = "prompt-node", action = "exec", exe = "node", decision = "prompt_once" },
            { id = "prompt-npx", action = "exec", exe = "npx", decision = "prompt_once" },
          },
        },
      }
    end,
  },
}
