-- Background
term.setBackgroundColor(colors.gray)
term.clear()

-- Variable Setup
local httpRoot = "https://raw.githubusercontent.com/SynicalMX/RedOS/master/"
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
paintutils.drawFilledBox(termx / 2+1, yLoc-1, termx-2, termy, colors.lightGray)
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
term.setCursorPos(5,4)
term.write("Made by SynicalMX")

-- Version
local versionHTTP = http.get(httpRoot.."version")
local version = versionHTTP.readAll()
yLoc = ((termy / 2) - 2)
xLoc = (termx / 2) - (string.len("RedOS v"..version) / 2)
term.setCursorPos(xLoc, yLoc)
term.write("RedOS v"..version)

-- Loop
local installing = true
while installing do
    local event, button, x, y = os.pullEvent("mouse_click")

    if button == 1 then
        if x >= cancel["xmin"] and x <= cancel["xmax"] and y >= cancel["ymin"] and y <= cancel["ymax"] then
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            term.clear()
            print("Installation canceled.")
            term.setCursorPos(1,2)
            installing = false
        elseif x >= install["xmin"] and x <= install["xmax"] and y >= install["ymin"] and y <= install["ymax"] then
            term.setBackgroundColor(colors.gray)
            term.clear()
            break
        end
    end
end

if installing then
    term.setBackgroundColor(colors.gray)
    term.setCursorPos((termx/2) - (string.len("Installing RedOS") / 2), termy/2)
    term.write("Installing RedOS")

    fs.makeDir("/RedOS/apis/")
    fs.makeDir("/RedOS/sys/assets/")
    fs.makeDir("/RedOS/themes/")

    local download = http.get(httpRoot.."src/startup.lua")
    local handle = download.readAll()
    download.close()

    local file = fs.open("startup.lua","w")
    file.write(handle)
    file.close()

    download = http.get(httpRoot.."src/RedOS/boot")
    handle = download.readAll()
    download.close()

    file = fs.open("/RedOS/boot", "w")
    file.write(handle)
    file.close()

    download = http.get(httpRoot.."src/RedOS/red32.lua")
    handle = download.readAll()
    download.close()

    file = fs.open("/RedOS/red32.lua", "w")
    file.write(handle)
    file.close()

    download = http.get(httpRoot.."src/RedOS/apis/drawing.lua")
    handle = download.readAll()
    download.close()

    file = fs.open("/RedOS/apis/drawing.lua", "w")
    file.write(handle)
    file.close()

    download = http.get(httpRoot.."src/RedOS/sys/theme")
    handle = download.readAll()
    download.close()

    file = fs.open("/RedOS/sys/theme", "w")
    file.write(handle)
    file.close()

    download = http.get(httpRoot.."src/RedOS/sys/assets/logo.nfp")
    handle = download.readAll()
    download.close()

    file = fs.open("/RedOS/sys/assets/logo.nfp", "w")
    file.write(handle)
    file.close()

    download = http.get(httpRoot.."src/RedOS/themes/default")
    handle = download.readAll()
    download.close()

    file = fs.open("/RedOS/themes/default", "w")
    file.write(handle)
    file.close()
end