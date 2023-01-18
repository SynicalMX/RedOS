local args = table.pack(...)

local function expect(obj, type)
    local objType = type(obj)
    
    if objType == type then
        return true
    else
        return false
    end
end

local function download(url, path)
    -- Check parameters for invalid types
    if expect(url, "string") then
        error("URL has to be a string!")
    else if expect(path, "string") then
        error("Path has to be a string!")
    end
    
    -- Check if URL is valid
    if not http.checkURL(url) then
        print("Error: URL is invalid")
        return 0
    end
    
    -- Check if path is valid
    if fs.exists(path) then
        print("Error: Path exists")
        return 0
    end
    
    -- Get content file
    local dwnld = http.get(url)
    local contents = dwnld.readAll()
    dwnld.close()
    
    local file = fs.open(path, "w")
    file.write(contents)
    file.close()
    print("Downloaded file succesfully.")
    return 1
end

local function runURL(url)
    local download = download(url, "./download.lua")
    if download == 0 then
        return 0
    end
    
    dofile("./download.lua")
    return 1
end

if #args > 2 or #args < 2 then 
    error("Invalid arguments were provided.")
end

local mode = args[1]
local url = args[2]

if mode == "run" then
    runURL(url)
else if mode == "download" then
    local path = args[3]
    if not path then
        path = "."
    end
    download(url, path)
else
    error("Invalid arguments were provided")
end


