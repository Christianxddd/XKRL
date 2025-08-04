
-- Cargar librerías Fluent y addons
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Crear ventana principal usando InterfaceManager
local Window = InterfaceManager:Create({
    Name = "XRNL HUB - By Sebastian",
    Icon = "rbxassetid://6031275975", -- ícono simple
    Hide = false
})

-- Crear pestañas en el panel
local Tabs = {
    Home = Window:AddTab({ Title = "🏠 Home", Icon = "home" }),
    Main = Window:AddTab({ Title = "🖥 Main", Icon = "monitor" }),
    Rollback = Window:AddTab({ Title = "🔁 Rollback", Icon = "refresh" }),
    BallHack = Window:AddTab({ Title = "⚽ Ball Hack", Icon = "soccer-ball" }),
    Misc = Window:AddTab({ Title = "📁 Misc", Icon = "folder" }),
    Event = Window:AddTab({ Title = "🎁 Event", Icon = "gift" }),
    Visual = Window:AddTab({ Title = "👁 Visual", Icon = "eye" }),
    Server = Window:AddTab({ Title = "🖧 Server", Icon = "server" }),
    Config = Window:AddTab({ Title = "⚙ Configuración", Icon = "settings" }),
    Theme = Window:AddTab({ Title = "🎨 Tema", Icon = "palette" })
}

-- Ejemplo de botón en pestaña Home
Tabs.Home:AddButton({
    Title = "Bienvenido al XRNL HUB",
    Description = "Hecho por Sebastian. Usa las pestañas de arriba.",
    Callback = function()
        print("Panel funcionando correctamente.")
    end
})

-- Ejemplo de toggle en pestaña Main
Tabs.Main:AddToggle({
    Title = "Speed Hack",
    Default = false,
    Callback = function(state)
        print("Speed Hack activado:", state)
    end
})

-- Guardado de configuraciones
SaveManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
SaveManager:SetFolder("XRNL HUB")
SaveManager:BuildConfigSection(Tabs.Config)

-- Opciones de tema
Fluent:Notify({ Title = "XRNL HUB", Content = "Panel cargado correctamente", Duration = 5 })
