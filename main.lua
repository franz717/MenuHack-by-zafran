-- Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/GRPGaming/Key-System/refs/heads/Xycer-Hub-Script/ZusumeLib(Slider)"))()

-- Setup UI
local Window = OrionLib:MakeWindow({
    Name = "🚀 Menu Hack Pro - Mobile Ready",
    HidePremium = false,
    SaveConfig = false,
    IntroEnabled = true,
    IntroText = "Memuat Menu Hack...",
    Icon = "rbxassetid://4483345998",
    IntroIcon = "rbxassetid://4483345998"
})

-- Tab utama
local Tab = Window:MakeTab({
    Name = "Menu Hack",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

Tab:AddSection({Name = "⚙️ Fitur Hack Mobile"})

-- Speed Hack
Tab:AddSlider({
    Name = "Speed Hack",
    Min = 1,
    Max = 999,
    Default = 16,
    Color = Color3.fromRGB(0,255,0),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(val)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
})

-- Fly Hack
local flying = false
local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local char, hrp = player.Character or player.CharacterAdded:Wait(), nil
local flySpeed = 2
local bv, bg = nil, nil
local directions = {F = 0, B = 0, L = 0, R = 0, U = 0, D = 0}

function StartFlying()
    char = player.Character or player.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
    bv = Instance.new("BodyVelocity", hrp)
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.P = 9e4
    game:GetService("RunService").Heartbeat:Connect(function()
        if flying and hrp then
            local cam = workspace.CurrentCamera
            local cf = cam.CFrame
            local moveVec = Vector3.new(
                (directions.R - directions.L),
                (directions.U - directions.D),
                (directions.B - directions.F)
            )
            local dir = (cf.RightVector * moveVec.X + cf.UpVector * moveVec.Y + cf.LookVector * moveVec.Z).Unit
            if moveVec.Magnitude > 0 then
                bv.Velocity = dir * flySpeed * 10
            else
                bv.Velocity = Vector3.zero
            end
            bg.CFrame = cf
        end
    end)
end

Tab:AddToggle({
    Name = "Fly Hack",
    Default = false,
    Callback = function(val)
        flying = val
        if flying then
            StartFlying()
        else
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
    end
})

Tab:AddSlider({
    Name = "Fly Speed",
    Min = 1,
    Max = 100,
    Default = 10,
    Increment = 1,
    ValueName = "Power",
    Callback = function(val)
        flySpeed = val
    end
})

-- Keybind input (untuk pengguna keyboard eksternal atau kontrol tambahan di Arceus X)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.W then directions.F = 1 end
    if input.KeyCode == Enum.KeyCode.S then directions.B = 1 end
    if input.KeyCode == Enum.KeyCode.A then directions.L = 1 end
    if input.KeyCode == Enum.KeyCode.D then directions.R = 1 end
    if input.KeyCode == Enum.KeyCode.Space then directions.U = 1 end
    if input.KeyCode == Enum.KeyCode.LeftShift then directions.D = 1 end
end)
UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then directions.F = 0 end
    if input.KeyCode == Enum.KeyCode.S then directions.B = 0 end
    if input.KeyCode == Enum.KeyCode.A then directions.L = 0 end
    if input.KeyCode == Enum.KeyCode.D then directions.R = 0 end
    if input.KeyCode == Enum.KeyCode.Space then directions.U = 0 end
    if input.KeyCode == Enum.KeyCode.LeftShift then directions.D = 0 end
end)

-- No Clip
local noclip = false
game:GetService("RunService").Stepped:Connect(function()
    if noclip then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
end)

Tab:AddToggle({
    Name = "No Clip",
    Default = false,
    Callback = function(val)
        noclip = val
    end
})

-- ∞ Jump (Infinite Jump)
local infiniteJumpEnabled = false
Tab:AddToggle({
    Name = "∞ Jump",
    Default = false,
    Callback = function(val)
        infiniteJumpEnabled = val
    end
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infiniteJumpEnabled then
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Inisialisasi GUI
OrionLib:Init()
