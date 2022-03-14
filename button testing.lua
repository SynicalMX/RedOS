require("RedOS.apis.drawing")
term.clear()

local function click()
    toggleButton("test")
    local toggle = getButtonToggle("test")
    if toggle then
        setButtonText("test", "Hello!")
    else
        setButtonText("test", "World!")
    end
end

local function click2()
    
end

addButton("test", "Hello!", click, "", 10, 20, 3, 9, colors.gray, colors.lightGray)
addButton("button", "Button!", click2, "", 29, 40, 3, 9, colors.gray, colors.lightGray)
heading("hello!")
screen()

while true do
    local event, button, x, y = os.pullEvent("mouse_click")
    checkxy(x, y)
end