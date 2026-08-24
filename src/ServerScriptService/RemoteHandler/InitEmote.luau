local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = require(ReplicatedStorage.Modules.Network)

local EmoteFolder = ReplicatedStorage.Assets.Emotes
local EmoteCooldown = 0.25
local LastEmoteUse = {}

return function()
    Players.PlayerRemoving:Connect(function(plr: Player)
        LastEmoteUse[plr.UserId] = nil
    end)

    Network:SetConnection("InitEmote", "REMOTE_EVENT", function(plr: Player, emoteName: string)
        if typeof(emoteName) ~= "string" or #emoteName > 64 then
            return
        end

        local now = os.clock()
        if LastEmoteUse[plr.UserId] and now - LastEmoteUse[plr.UserId] < EmoteCooldown then
            return
        end
        LastEmoteUse[plr.UserId] = now
        if not plr.Character or not plr.Character:FindFirstChild("Humanoid") or not plr.Character.Humanoid:FindFirstChild("Animator") then
            return
        end

        local EmoteModule = EmoteFolder:FindFirstChild(emoteName)
        if not EmoteModule or not EmoteModule:IsA("ModuleScript") then
            return
        end

        local Success, Emote = pcall(require, EmoteModule)
        if not Success or type(Emote) ~= "table" or type(Emote.Init) ~= "function" then
            return
        end

        local InitSuccess = pcall(Emote.Init, Emote, plr)
        if not InitSuccess then
            return
        end
    end)
end
