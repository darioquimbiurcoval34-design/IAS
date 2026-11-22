-- QuantumKaitun/tasks/items.lua
local Items = {}

getgenv().QuantumKaitun = getgenv().QuantumKaitun or {}
getgenv().QuantumKaitun.Items = Items

Items.Config = {
    GetHaki = true,
    GetSaber = true,
    KeySwords = true
}

function Items.GetBusoHaki()
    -- Logic to buy / unlock Enhancement Haki
end

function Items.GetSaber()
    -- Saber quest automation logic
end

function Items.FarmKeySwords()
    -- Logic to farm key swords (Rengoku, Buddy Sword, etc.)
end

function Items.Init()
    task.spawn(function()
        while task.wait(2) do
            if Items.Config.GetHaki then Items.GetBusoHaki() end
            if Items.Config.GetSaber then Items.GetSaber() end
            if Items.Config.KeySwords then Items.FarmKeySwords() end
        end
    end)
end

Items.Init()
return Items
