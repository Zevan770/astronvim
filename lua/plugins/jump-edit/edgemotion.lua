return {
  "haya14busa/vim-edgemotion",
  config = function()
    vim.cmd [[
    nmap \|j m'<Plug>(edgemotion-j)
    nmap \|k m'<Plug>(edgemotion-k)
    xmap \|j m'<Plug>(edgemotion-j)
    xmap \|k m'<Plug>(edgemotion-k)
    omap \|j <Plug>(edgemotion-j)
    omap \|k <Plug>(edgemotion-k)
    ]]
  end,
}
