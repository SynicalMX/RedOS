_G.red32 = {}

red32.themeLoaded = false

red32.loadTheme = function()
    red32.themeLoaded = false
    local path = "/RedOS/sys/theme"
    local sys = fs.open(path, "r")
    path = "/RedOS/themes/"..sys.readAll()
    print(sys.readAll())
    sys.close()
    if _G.THEME then
        _G.THEME = nil
    end
    dofile(path)
    red32.themeLoaded = true
end

red32.popup = function(title, text)
    repeat
        sleep()
    until red32.themeLoaded

    local termx, termy = term.getSize()
    local x = (termx / 2) / 1.5
    local y = (termy / 2) / 1.5
    local x2 = (termx / 2) * 1.5
    local y2 = (termy / 2) * 1.5

    paintutils.drawFilledBox(x - 1, y - 1, x2 - 1, y2 - 1, THEME["popup"]["inner"])
    paintutils.drawBox(x - 1, y - 1, x2 - 1, y2 - 1, THEME["popup"]["border"])

    local xLoc = (termx / 2) - (title:len() / 2) + 1
    term.setCursorPos(xLoc, y - 1)
    term.setBackgroundColor(THEME["popup"]["title_back"])
    term.setTextColor(colors.black)
    term.write(title)

    xLoc = (termx / 2) - (text:len() / 2) + 1
    local yLoc = termy / 2

    term.setBackgroundColor(THEME["popup"]["inner"])
    term.setTextColor(THEME["popup"]["text"])
    term.setCursorPos(xLoc, yLoc)
    term.write(text)

    term.setBackgroundColor(THEME["popup"]["btn"])
    term.setTextColor(THEME["popup"]["btn_text"])
    xLoc = (termx / 2) + 1
    yLoc = y2 - 1
    term.setCursorPos(xLoc, yLoc)
    term.write("Ok")
    repeat local event, button, x, y = os.pullEvent("mouse_click") until x == 26 or
        x == 27 and y == 13
    return true
end
