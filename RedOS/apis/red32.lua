red32 = {}

function red32:getTheme(file)
    if fs.exists(file) == false then error("Theme doesn't exist.") end

    file = file:sub(1, file:find(".lua") - 1)
    local path = ""
    for i = 1, file:len() do
        local char = file:sub(i, i)
        if char == "/" then
            path = path .. "."
        else
            path = path .. char
        end
    end
    return path
end

function red32:popup(title, text, theme)
    local termx, termy = term.getSize()
    local x = (termx / 2) / 1.5
    local y = (termy / 2) / 1.5
    local x2 = (termx / 2) * 1.5
    local y2 = (termy / 2) * 1.5

    paintutils.drawFilledBox(x - 1, y - 1, x2 - 1, y2 - 1, theme["inner"][1])
    paintutils.drawBox(x - 1, y - 1, x2 - 1, y2 - 1, theme["border"][1])

    local xLoc = (termx / 2) - (title:len() / 2) + 1
    term.setCursorPos(xLoc, y - 1)
    term.setBackgroundColor(theme["title_back"][1])
    term.setTextColor(colors.black)
    term.write(title)

    xLoc = (termx / 2) - (text:len() / 2) + 1
    local yLoc = termy / 2

    term.setBackgroundColor(theme["inner"][1])
    term.setTextColor(theme["text"][1])
    term.setCursorPos(xLoc, yLoc)
    term.write(text)

    term.setBackgroundColor(theme["btn"][1])
    term.setTextColor(theme["btn_text"][1])
    xLoc = (termx / 2) + 1
    yLoc = y2 - 1
    term.setCursorPos(xLoc, yLoc)
    term.write("Ok")
    repeat local event, button, x, y = os.pullEvent("mouse_click") until x == 26 or
        x == 27 and y == 13
    return true
end
