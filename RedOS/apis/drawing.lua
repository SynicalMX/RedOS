term.setTextColor(colors.white)
local button = {}

function clearTable()
   button = {}
end

function setButtonText(name, text)
   button[name]["text"] = text
   screen()
end

function setButtonToggle(name, buttonOn)
   print(name)
   print(button[name]["active"])
   button[name]["active"] = buttonOn
   screen()
end

function setButtonColors(name, color, secondary_color)
   button[name]["color"] = color
   button[name]["secondary_color"] = secondary_color
   screen()
end

function getButtonToggle(name)
   local toggle = button[name]["active"]
   return toggle
end
                                             
function addButton(name, text, func, param, xmin, xmax, ymin, ymax, color, secondary_color)
   button[name] = {}
   button[name]["text"] = text
   button[name]["func"] = func
   button[name]["active"] = false
   button[name]["param"] = param
   button[name]["xmin"] = xmin
   button[name]["ymin"] = ymin
   button[name]["xmax"] = xmax
   button[name]["ymax"] = ymax
   button[name]["color"] = color
   button[name]["secondary_color"] = secondary_color
end  

function fill(text, color, secondary_color, bData)
   local bgcol = term.getBackgroundColor()

   local xLoc = ((bData["xmin"] + bData["xmax"]) / 2) - (text:len() / 2)
   local yLoc = (bData["ymin"] + bData["ymax"]) / 2

   term.setBackgroundColor(color)
   paintutils.drawFilledBox(bData["xmin"], bData["ymin"], bData["xmax"], bData["ymax"], secondary_color)
   paintutils.drawBox(bData["xmin"], bData["ymin"], bData["xmax"], bData["ymax"], color)

   term.setBackgroundColor(secondary_color)
   term.setCursorPos(xLoc, yLoc)
   term.write(text)

   term.setBackgroundColor(bgcol)
end
     
function screen()
   for name,data in pairs(button) do
      fill(data["text"], data["color"], data["secondary_color"], data)
   end
end

function toggleButton(name)
   button[name]["active"] = not button[name]["active"]
   screen()
end     

function flash(name)
   toggleButton(name)
   screen()
   sleep(0.15)
   toggleButton(name)
   screen()
end
                                             
function checkxy(x, y)
   for name, data in pairs(button) do
      if y>=data["ymin"] and  y <= data["ymax"] then
         if x>=data["xmin"] and x<= data["xmax"] then
            if data["param"] == "" then
              data["func"]()
            else
              data["func"](data["param"])
            end
            return true
            --data["active"] = not data["active"]
            --print(name)
         end
      end
   end
   return false
end
     
function heading(text)
   local w, h = term.getSize()
   term.setCursorPos((w-string.len(text))/2+1, 1)
   term.write(text)
end
     
function label(w, h, text)
   term.setCursorPos(w, h)
   term.write(text)
end

function parseTheme(file)
   if fs.exists(file) == false then error("Theme doesn't exist.") end
   
   file = file:sub(1, file:find(".lua")-1)
   local path = ""
   for i=1, file:len() do
      local char = file:sub(i, i)
      if char == "/" then
         path = path.."."
      else
         path = path..char
      end
   end

   require(path)
   textutils.serialise(theme)


end