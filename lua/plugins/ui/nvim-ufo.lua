---@type LazySpec
return {
  --{{{
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   -- note that nvim 0.11 doesn't require this plugin
  --   version = false,
  --   enabled = true,
  --   opts = {
  --     provider_selector = function(_, filetype, buftype)
  --       local function handleFallbackException(bufnr, err, providerName)
  --         if type(err) == "string" and err:match "UfoFallbackException" then
  --           return require("ufo").getFolds(bufnr, providerName)
  --         else
  --           return require("promise").reject(err)
  --         end
  --       end
  --
  --       return (filetype == "") and "indent" -- only use indent until a file is opened
  --         or function(bufnr)
  --           return require("ufo")
  --             .getFolds(bufnr, "lsp")
  --             :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
  --             :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
  --         end
  --     end,
  --   },
  -- },
  --}}}

  --#region
  --#endregion

  {
    "kevinhwang91/nvim-ufo",
    version = false,
    enabled = true,
    ---@module "ufo"
    ---@param opts UfoConfig
    opts = function(_, opts)
      opts.provider_selector = function(_, filetype, buftype)
        ---https://github.com/kevinhwang91/nvim-ufo/commit/5450532a233706ea9b8ad8ce9763220c7d8b537d
        ---Merge ufo providers in one
        ---Pass all ufo providers in a list of strings or functions. If the element is a string, it will be
        ---treated as a default ufo provider, and this method will query the folds from it. If it is a
        ---function, it will be executed to get the folds.
        ---This method will return a new function that gets the folds of all merged providers. The
        ---returned function can be used to configure the `ufo.setup.provider_selector`. E.g.:
        ---    require('ufo').setup({
        ---        provider_selector = function(bufnr, filetype, buftype)
        ---            return require('ufo').mergeProviders({ 'lsp', 'indent', funcThatReturnsFoldRanges })
        ---        end,
        ---    })
        ---@alias ProviderToMerge string|fun(bufnr: number): UfoFoldingRange[]
        ---@param providers ProviderToMerge[] Ufo providers names or functions that gets folds
        ---@return function(bufnr): Promise|UfoFoldingRange[] A function that gets the folds of all merged providers
        local function mergeProviders(providers)
          local ufo = require "ufo"

          return function(bufnr)
            local allFolds = {}

            -- Gets the folds from each provider and merge it before returning. Strings are
            -- treated as default UFO providers and functions are executed to get the folds
            for _, provider in ipairs(providers) do
              local providerFolds = {}

              if type(provider) == "string" then
                providerFolds = ufo.getFolds(bufnr, provider)
                if type(providerFolds) == "table" and type(providerFolds.thenCall) == "function" then
                  return providerFolds
                end
              elseif type(provider) == "function" then
                providerFolds = provider(bufnr)
              end

              -- `providerFolds` can be nil if the `getFolds` method does not return anything,
              -- so need to add a 'or {}' at the end
              vim.list_extend(allFolds, providerFolds or {})
            end

            return allFolds
          end
        end
        local function handleFallbackException(bufnr, err, providerName)
          if type(err) == "string" and err:match "UfoFallbackException" then
            return mergeProviders { "marker", providerName }(bufnr)
          else
            return require("promise").reject(err)
          end
        end

        --
        return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
          or function(bufnr)
            return mergeProviders { "marker", "lsp" }(bufnr)
              :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
              :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
          end
      end
      opts.close_fold_kinds_for_ft = {
        default = { "comment", "marker" },
      }

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      opts.fold_virt_text_handler = handler
    end,
  },
}
