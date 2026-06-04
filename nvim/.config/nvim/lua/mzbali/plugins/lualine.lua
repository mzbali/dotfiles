return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup {
            sections = {
                lualine_x = { 'copilot', 'encoding', { "fileformat", symbols = { unix = "" } }, 'filetype' }, -- I added copilot here
            }
        }
    end
}
