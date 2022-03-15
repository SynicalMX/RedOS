term.setBackgroundColor(colors.white)
term.clear()

local termx, termy = term.getSize()

local xLoc = (termx / 2) - 2
local yLoc = (termy / 2) + (termy / 4)

paintutils.drawPixel(xLoc, yLoc, colors.red)