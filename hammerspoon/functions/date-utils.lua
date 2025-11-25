local M = {}

function M.getLongDate()
    local weekdays = {"zondag","maandag","dinsdag","woensdag","donderdag","vrijdag","zaterdag"}
    local months   = {"januari","februari","maart","april","mei","juni","juli","augustus","september","oktober","november","december"}
    local t = os.date("*t")  -- t.wday: 1=zondag .. 7=zaterdag
    return string.format("%s %d %s %d", weekdays[t.wday], t.day, months[t.month], t.year)
end

function M.getShortDate()
    return os.date("%Y-%m-%d")
end

function M.getDatePrefix()
    return os.date("%y%m%d-")
end

function M.getWeekNumber()
    return os.date("%V")
end

return M