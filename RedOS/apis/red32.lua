

function popup(title, text)
    local termx, termy = term.getSize()
    local x = (termx / 2) / 1.5
    local y = (termy / 2) / 1.5
    local x2 = (termx / 2) * 1.5
    local y2 = (termy / 2) * 1.5
    paintutils.drawBox(x-1, y-1, x2-1, y2-1, colors.white)
 end