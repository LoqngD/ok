peat wait() until game:IsLoaded()
repeat wait() until game.Players.LocalPlayer
local Plr = game.Players.LocalPlayer
repeat wait() until Plr.Character
repeat wait() until Plr.Character:FindFirstChild("HumanoidRootPart")
repeat wait() until Plr.Character:FindFirstChild("Humanoid") 
local Plrgui =game.Players.LocalPlayer.PlayerGui
local vim = game:GetService("VirtualInputManager")
local ListCode = {"DELAY","RELEASE","10KLIKES","100KLIKES","200KLIKES","300KLIKES","10MVISITS","25MVISITS","400KLIKES"}
for i,v in pairs(ListCode) do 
    game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("CodesEvent"):FireServer(v)
end
function SendWebHook(UnitName,UnitRarity)
    local msg = {
        ['content'] = '@everyone',
        ["embeds"] = {{
            ["title"] = "Anime Vanguard",
            ["description"] = "Unit Summoned",
            ["type"] = "rich",
            ["color"] = tonumber(0xbdce44),
            ["fields"] = {
                {
                    ["name"] = "User",
                    ["value"] = game.Players.LocalPlayer.Name,                                            
                    ["inline"] = false
                },
                {
                    ["name"] = "Name",
                    ["value"] = UnitName,                                            
                    ["inline"] = true
                },
                {
                    ["name"] = "Rarity",
                    ["value"] = UnitRarity,                                            
                    ["inline"] = true
                },
                
            }
        }}
    }
    request({
        Url = getgenv().Webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = game:GetService("HttpService"):JSONEncode(msg)
    }) 
end
wait(5)
local GemText = Plrgui.HUD.Main.Currencies.Gems.Gems.Text:gsub(",","")  
spawn(function()
    while wait() do 
        if tonumber(GemText)/50 > 1 then 
            game:GetService("ReplicatedStorage"):WaitForChild("Networking"):WaitForChild("Units"):WaitForChild("SummonEvent"):FireServer("SummonOne","Special")
            wait()
            GemText = Plrgui.HUD.Main.Currencies.Gems.Gems.Text:gsub(",","")
            wait()
        else 
            game:Shutdown()
        end 
    end 
end)
local ListRarity = {"Mythic","Legendary","Secret"}
Plrgui.ViewFrames.ChildAdded:Connect(function(Unit)
	if table.find(ListRarity,Unit.Holder.Main.UnitName.UnitRarity.Text) then 
        SendWebHook(Unit.Holder.Main.UnitName.UnitName.Text,Unit.Holder.Main.UnitName.UnitRarity.Text) 
    end 
end)
