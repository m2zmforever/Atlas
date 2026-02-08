local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local function safeNotify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = 4})
    end)
end

local function fetchRaw(url)
    local ok, body = pcall(function()
        if type(syn) == "table" and type(syn.request) == "function" then
            local res = syn.request({Url = url, Method = "GET"})
            return res and (res.Body or res.body or res.response)
        end
        if type(request) == "function" then
            local res = request({Url = url, Method = "GET"})
            return res and (res.Body or res.body)
        end
        if type(http) == "table" and type(http.request) == "function" then
            local res = http.request({Url = url, Method = "GET"})
            return res and (res.Body or res.body)
        end
        return game:HttpGet(url)
    end)
    if ok and type(body) == "string" and #body > 0 then
        return body
    end
    return nil
end

local function runCode(code)
    local loader = loadstring or load
    local fn, err = loader(code)
    if not fn then
        return false, err
    end
    local ok, res = pcall(fn)
    if not ok then
        return false, res
    end
    return true, res
end

local baseUrl = "https://raw.githubusercontent.com/m2zmforever/Atlas/Release/"
local pcUrl = baseUrl .. "script-pc.lua"
local mobileUrl = baseUrl .. "script-mobile.lua"

local function detectMobile()
    if getgenv and getgenv().AtlasForceMobile ~= nil then
        return getgenv().AtlasForceMobile
    end
    local touch = false
    pcall(function() touch = UserInputService.TouchEnabled end)
    if touch then
        return true
    end
    return false
end

local function tryLoad(url)
    safeNotify("Atlas Loader", "Fetching script...")
    local code = fetchRaw(url)
    if not code then
        return false, "fetch_failed"
    end
    local ok, err = runCode(code)
    if not ok then
        return false, err
    end
    return true
end

local isMobile = detectMobile()
local primary = isMobile and mobileUrl or pcUrl
local fallback = isMobile and pcUrl or mobileUrl

safeNotify("Atlas Loader", "Detected " .. (isMobile and "Mobile" or "PC") .. " environment. Loading...")
local ok, err = tryLoad(primary)
if not ok then
    safeNotify("Atlas Loader", "Primary load failed, trying fallback")
    local ok2, err2 = tryLoad(fallback)
    if not ok2 then
        safeNotify("Atlas Loader", "Failed to load scripts: " .. tostring(err2))
        error("Atlas loader failed: " .. tostring(err2))
    end
end
