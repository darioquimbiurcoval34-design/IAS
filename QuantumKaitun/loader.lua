-- QuantumKaitun/loader.lua
local BaseUrl = "https://raw.githubusercontent.com/darioquimbiurcoval34-design/IAS/main/QuantumKaitun/"

local function LoadModule(fileName)
    local url = BaseUrl .. fileName
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)
    if success and result then
        local fn, err = loadstring(result)
        if fn then
            return fn()
        else
            warn("[QuantumKaitun Loader] Compilation error in " .. fileName .. ": " .. tostring(err))
        end
    else
        warn("[QuantumKaitun Loader] Failed to fetch " .. fileName)
    end
end

LoadModule("config.lua")
LoadModule("brain.lua")
