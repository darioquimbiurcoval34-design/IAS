-- QuantumKaitun/brain.lua
getgenv().QuantumKaitun = getgenv().QuantumKaitun or {}
local QuantumKaitun = getgenv().QuantumKaitun

do
    QuantumKaitun.Brain = QuantumKaitun.Brain or {
        Running = true,
        CurrentState = "Inicializando...",
        CurrentTask = "Idle"
    }

    local Brain = QuantumKaitun.Brain

    function Brain:SetState(state, taskName)
        self.CurrentState = state or self.CurrentState
        self.CurrentTask = taskName or self.CurrentTask
    end

    function Brain:TogglePause()
        self.Running = not self.Running
        if not self.Running then
            self:SetState("Pausado", "Ninguna")
        else
            self:SetState("En ejecucion", "Reanudando...")
        end
        return self.Running
    end

    function Brain:Start()
        task.spawn(function()
            while true do
                task.wait(1)
                if self.Running then
                    local level = 1
                    pcall(function()
                        level = game:GetService("Players").LocalPlayer.Data.Level.Value
                    end)

                    -- Coordinacion de tareas
                    if QuantumKaitun.Leveling then
                        self:SetState("Farming Nivel", "Auto Leveling (Lv. " .. tostring(level) .. ")")
                        pcall(function() QuantumKaitun.Leveling.FarmLevel() end)
                    elseif QuantumKaitun.Items then
                        self:SetState("Obteniendo Items", "Haki / Saber / Espadas")
                        pcall(function() QuantumKaitun.Items.GetBusoHaki() end)
                    elseif QuantumKaitun.RaidsSea then
                        self:SetState("Eventos / Raids", "Farmeo de Fragmentos")
                        pcall(function() QuantumKaitun.RaidsSea.FarmFragments() end)
                    else
                        self:SetState("En espera", "Cargando modulos...")
                    end
                end
            end
        end)
    end
end

QuantumKaitun.Brain:Start()
return QuantumKaitun.Brain
