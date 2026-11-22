-- QuantumKaitun/config.lua
local HttpService = game:GetService("HttpService")

getgenv().QuantumKaitun = getgenv().QuantumKaitun or {
    CurrentTheme = "QuantumDark",
    AutoFarm = false,
    FastAttack = true,
    BringMobs = false,
    Themes = {
        QuantumDark = {
            BG = Color3.fromHex("0a0a0f"),
            Panel = Color3.fromHex("15151a"),
            Accent = Color3.fromRGB(0, 170, 255),
            BackgroundImage = "rbxassetid://1316045217"
        },
        SakuraAnime = {
            BG = Color3.fromHex("1f0a14"),
            Panel = Color3.fromHex("2a1220"),
            Accent = Color3.fromRGB(255, 105, 180),
            BackgroundImage = "rbxassetid://1316045218"
        }
    }
}

local CONFIG_FILE = "QuantumKaitun_Config.json"

function getgenv().QuantumKaitun:Save()
    if writefile then
        local data = {
            CurrentTheme = self.CurrentTheme,
            AutoFarm = self.AutoFarm,
            FastAttack = self.FastAttack,
            BringMobs = self.BringMobs
        }
        pcall(writefile, CONFIG_FILE, HttpService:JSONEncode(data))
    end
end

function getgenv().QuantumKaitun:Load()
    if isfile and readfile and isfile(CONFIG_FILE) then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(readfile(CONFIG_FILE))
        end)
        if ok and type(data) == "table" then
            for k, v in pairs(data) do
                self[k] = v
            end
        end
    end
end

return getgenv().QuantumKaitun
