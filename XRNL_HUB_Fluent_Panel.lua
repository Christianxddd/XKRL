
-- XRNL HUB - Fluent Version By Sebastian

-- Cargar librerías necesarias
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Crear ventana principal con InterfaceManager
local Window = InterfaceManager:Create({
    Name = "XRNL HUB - By Sebastian",
    Icon = "rbxassetid://6031275975",
    Hide = false
})

-- Crear pestañas
local Tabs = {
    Home = Window:AddTab({ Title = "🏠 Home", Icon = "home" }),
    Main = Window:AddTab({ Title = "🖥 Main", Icon = "monitor" }),
    Rollback = Window:AddTab({ Title = "🔁 Rollback", Icon = "rotate-ccw" }),
    BallHack = Window:AddTab({ Title = "⚽ Ball Hack", Icon = "circle" }),
    Misc = Window:AddTab({ Title = "📁 Misc", Icon = "folder" }),
    Event = Window:AddTab({ Title = "🎁 Event", Icon = "gift" }),
    Visual = Window:AddTab({ Title = "👁 Visual", Icon = "eye" }),
    Server = Window:AddTab({ Title = "🖧 Server", Icon = "server" }),
    Config = Window:AddTab({ Title = "⚙ Configuración", Icon = "settings" }),
    Theme = Window:AddTab({ Title = "🎨 Tema", Icon = "palette" })
}

-- Funciones de ejemplo en cada pestaña
Tabs.Home:AddParagraph({ Title = "Bienvenido", Content = "Gracias por usar XRNL HUB - Panel optimizado para Blue Lock." })
Tabs.Main:AddButton({ Title = "Resetear Jugador", Callback = function() game.Players.LocalPlayer:LoadCharacter() end })
Tabs.Main:AddToggle({
    Title = "Speed Hack",
    Default = false,
    Callback = function(on)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = on and 100 or 16
    end
})
Tabs.Rollback:AddButton({ Title = "Rollback Posición", Callback = function()
    local char = game.Players.LocalPlayer.Character
    if char then char:MoveTo(Vector3.new(0, 5, 0)) end
end })

Tabs.BallHack:AddButton({ Title = "TP al Balón", Callback = function()
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChildWhichIsA("Part", true)
    if ball then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ball.CFrame + Vector3.new(0, 3, 0) end
end })

Tabs.BallHack:AddToggle({
    Title = "Auto Portero (detectar balón cerca)",
    Default = false,
    Callback = function(enabled)
        getgenv().AutoGoalie = enabled
        while getgenv().AutoGoalie do
            local ball = workspace:FindFirstChild("Ball")
            if ball and (ball.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 20 then
                game.Players.LocalPlayer.Character.Humanoid:MoveTo(ball.Position)
            end
            task.wait(0.2)
        end
    end
})

Tabs.Misc:AddToggle({
    Title = "Noclip",
    Default = false,
    Callback = function(state)
        if state then
            game:GetService("RunService").Stepped:Connect(function()
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end)
        end
    end
})

Tabs.Visual:AddSlider({
    Title = "Aumentar Hitbox (jugador)",
    Description = "Modifica el tamaño de colisión del personaje",
    Min = 2,
    Max = 20,
    Default = 2,
    Callback = function(size)
        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") then
                v.Size = Vector3.new(size, size, size)
            end
        end
    end
})

Tabs.Server:AddButton({
    Title = "Reunirse (Rejoin)",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

Tabs.Config:AddButton({
    Title = "Guardar Configuración",
    Callback = function()
        SaveManager:Save()
    end
})

-- Guardar configuraciones
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("XRNL HUB")
SaveManager:BuildConfigSection(Tabs.Config)

-- Crear selector de tema
Fluent:BuildThemeSection(Tabs.Theme)

-- Notificación al iniciar
Fluent:Notify({ Title = "XRNL HUB", Content = "Panel cargado con éxito.", Duration = 6 })
