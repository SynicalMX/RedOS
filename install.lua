-- Background
term.setBackgroundColor(colors.gray)
term.clear()

-- Variable Setup
local termx, termy = term.getSize()
local xLoc = (termx / 2) - 2
local yLoc = (termy / 2) + (termy / 4)

local cancel = {
    ["xmin"] = 2,
    ["xmax"] = 23,
    ["ymin"] = 12,
    ["ymax"] = 18
}

local install = {
    ["xmin"] = 27,
    ["xmax"] = 50,
    ["ymin"] = 12,
    ["ymax"] = 18
}

-- Cancel Button
paintutils.drawFilledBox(1, yLoc-1,xLoc-1, termy, colors.lightGray)
paintutils.drawFilledBox(2, yLoc-2,xLoc, termy-1, colors.red)

-- Install Button
paintutils.drawFilledBox(termx / 2+1, yLoc-1, termx-1, termy, colors.lightGray)
paintutils.drawFilledBox(termx-1, yLoc-2, xLoc+4, termy-1, colors.lime)

-- Cancel Text
xLoc = ((2 + xLoc) / 2) - (string.len("Cancel") / 2)
yLoc = (termy-2) - ((termy-1) - yLoc-2)
term.setBackgroundColor(colors.red)
term.setTextColor(colors.black)
term.setCursorPos(xLoc, yLoc)
term.write("Cancel")

-- Install Text
xLoc = (termx / 2) - 2
xLoc = (((xLoc+4) + (termx-1)) / 2) - (string.len("Install") / 2)
term.setBackgroundColor(colors.lime)
term.setCursorPos(xLoc, yLoc)
term.write("Install")

-- Credit
term.setBackgroundColor(colors.gray)
term.setCursorPos(3,3)
term.write("RedOS Installer")
term.setCursorPos(5,3)
term.write("Made with <3 by SynicalMX")

-- Version
yLoc = ((termy / 2) - 2)
xLoc = (termx / 2) - (string.len("RedOS v0.1") / 2)
term.setCursorPos(xLoc, yLoc)
term.write("RedOS v0.1")

local mon = peripheral.find("monitor")

-- Loop
local installing = true
while installing do
    local event, button, x, y = os.pullEvent("mouse_click")

    if button ~= 1 then return end

    if x >= cancel["xmin"] and x <= cancel["xmax"] and y >= cancel["ymin"] and y <= cancel["ymax"] then
        mon.clear()
        mon.setCursorPos(1,1)
        mon.write("Clicked!")
    else
        mon.clear()
        mon.setCursorPos(1,1)
        mon.write("Not Clicked!")
    end
end