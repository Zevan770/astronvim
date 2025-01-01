---@type LazySpec
return {
  {
    "kevinhwang91/nvim-ufo",
    version = false,
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

        --#region
        --#endregion

        return (filetype == "" or buftype == "nofile") and "indent" -- only use indent until a file is opened
          or function(bufnr)
            return mergeProviders { "marker", "lsp" }(bufnr)
              :catch(function(err) return handleFallbackException(bufnr, err, "treesitter") end)
              :catch(function(err) return handleFallbackException(bufnr, err, "indent") end)
          end
      end
    end,
  },
}
