drawing = {}

term.setTextColor(colors.white)
local button = {}

function clearTable()
   button = {}
end

function drawing.setButtonText(name, text)
   button[name]["text"] = text
   drawing:screen()
end

function drawing.setButtonToggle(name, buttonOn)
   print(name)
   print(button[name]["active"])
   button[name]["active"] = buttonOn
   drawing:screen()
end

function drawing.setButtonColors(name, color, secondary_color)
   button[name]["color"] = color
   button[name]["secondary_color"] = secondary_color
   drawing:screen()
end

function drawing.getButtonToggle(name)
   local toggle = button[name]["active"]
   return toggle
end
                                             
function drawing.addButton(name, text, func, param, xmin, xmax, ymin, ymax)
   button[name] = {}
   button[name]["text"] = text
   button[name]["func"] = func
   button[name]["active"] = false
   button[name]["param"] = param
   button[name]["xmin"] = xmin
   button[name]["ymin"] = ymin
   button[name]["xmax"] = xmax
   button[name]["ymax"] = ymax
   button[name]["color"] = THEME_buttons["state_off"]["outer"]
   button[name]["secondary_color"] = THEME_buttons["state_off"]["inner"]
   button[name]["text_color"] = THEME_buttons["state_off"]["text"]
end  

function drawing.fill(text, color, secondary_color, bData)
   local bgcol = term.getBackgroundColor()

   local xLoc = ((bData["xmin"] + bData["xmax"]) / 2) - (text:len() / 2) + 1
   local yLoc = (bData["ymin"] + bData["ymax"]) / 2

   term.setBackgroundColor(color)
   paintutils.drawFilledBox(bData["xmin"], bData["ymin"], bData["xmax"], bData["ymax"], secondary_color)
   paintutils.drawBox(bData["xmin"], bData["ymin"], bData["xmax"], bData["ymax"], color)

   term.setBackgroundColor(secondary_color)
   term.setCursorPos(xLoc, yLoc)
   term.setTextColor(bData["text_color"])
   term.write(text)

   term.setBackgroundColor(bgcol)
end
     
function drawing.screen()
   for name,data in pairs(button) do
      drawing:fill(data["text"], data["color"], data["secondary_color"], data)
   end
end

function drawing.toggleButton(name)
   button[name]["active"] = not button[name]["active"]
   drawing:screen()
end     

function drawing.flash(name)
   drawing:toggleButton(name)
   drawing:screen()
   drawing:sleep(0.15)
   drawing:toggleButton(name)
   drawing:screen()
end
                                             
function drawing.checkxy(x, y)
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

--function heading(text)
--   local w, h = term.getSize()
--   term.setCursorPos((w-string.len(text))/2+1, 1)
--   term.write(text)
--end
     
--function label(w, h, text)
--   term.setCursorPos(w, h)
--   term.write(text)
--end