local M = {}

function M.getMenu(cons)
    
    return {
        parentMenu = "mainMenu",
        menuHotkey = nil,
        menuHotkey = {mehkey, 'f19'},
        menuItems = {
            {cons.cat.action, '', 'V', 'Move node to workspace 1', {
                {cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 1' && zsh -c '/opt/homebrew/bin/aerospace workspace 1'"},
            }},
            {cons.cat.action, '', 'C', 'Move node to workspace 2', {
                {cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 2' && zsh -c '/opt/homebrew/bin/aerospace workspace 2'"},
            }},
            {cons.cat.action, '', 'X', 'Move node to workspace 3', {
                {cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 3' && zsh -c '/opt/homebrew/bin/aerospace workspace 3'"},
            }},
            {cons.cat.action, '', 'Z', 'Move node to workspace 4', {
                {cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace 4' && zsh -c '/opt/homebrew/bin/aerospace workspace 4'"},
            }},
            {cons.cat.action, '', 'S', 'Move workspace to other monitor', {
                {cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-workspace-to-monitor --wrap-around next'"},
            }},
            {cons.cat.action, '', 'D', 'Move node to next workspace', {
                {cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-workspace --focus-follows-window --wrap-around next'"},
            }}, 
            {cons.cat.action, '', 'F', 'Move node to other monitor', {
                {cons.act.shellcommand, "zsh -c '/opt/homebrew/bin/aerospace move-node-to-monitor --focus-follows-window --wrap-around next'"},
            }},
        }
    }
end

return M