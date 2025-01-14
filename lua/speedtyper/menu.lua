local M = {}
local game = require("speedtyper.game_modes")
local util = require("speedtyper.util")
local window = require("speedtyper.window")

---disables some things that may be distracting
local function disable()
    vim.opt_local.nu = false
    vim.opt_local.rnu = false
    vim.opt_local.fillchars = { eob = " " }
    vim.opt_local.wrap = false
    if package.loaded["cmp"] then
        -- disable cmp if loaded, we don't want the completion while practising typing :)
        require("cmp").setup.buffer({ enabled = false })
    end
end

function M.show()
    vim.ui.select(game.available_game_modes, {
        prompt = "Select game mode:",
    }, function(selected)
        if not selected then
            util.error("Please select game mode.")
            return
        end
        local winnr, bufnr = window.open_float()
        game.set_game_mode(selected)
        disable()
        require("speedtyper.runner").start()
    end)
end

return M
