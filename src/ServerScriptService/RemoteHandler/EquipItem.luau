local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Utils = require(ReplicatedStorage.Modules.Utils)
local Network = require(ReplicatedStorage.Modules.Network)

return function()
    Network:SetConnection("EquipItem", "REMOTE_EVENT", function(plr: Player, name: string, Type: string, SkinPath: string?)
        if typeof(name) ~= "string" or #name > 64 or typeof(Type) ~= "string" then
            return
        end

        local Characters = ReplicatedStorage:FindFirstChild("Characters")
        local SkinRoots = Characters and Characters:FindFirstChild("Skins")
        if not Characters or not SkinRoots then
            return
        end

        if Type == "Skin" then
            if typeof(SkinPath) ~= "string" then
                return
            end

            local CharacterName = SkinPath:match("^Skins%.([^%.]+)$")
            if not CharacterName then
                return
            end

            local CharacterRole
            for _, RoleName in {"Killers", "Survivors"} do
                local RoleFolder = Characters:FindFirstChild(RoleName)
                if RoleFolder and RoleFolder:FindFirstChild(CharacterName) then
                    CharacterRole = RoleName
                    break
                end
            end

            if not CharacterRole then
                return
            end

            local SkinRoleFolder = SkinRoots:FindFirstChild(CharacterRole)
            local CharacterSkins = SkinRoleFolder and SkinRoleFolder:FindFirstChild(CharacterName)
            local SkinModule = CharacterSkins and CharacterSkins:FindFirstChild(name)
            if #name > 0 and (not SkinModule or not SkinModule:IsA("ModuleScript")) then
                return
            end

            local EquippedSkin = Utils.PlayerData.GetPlayerEquipped(plr, SkinPath, false)
            if not EquippedSkin then
                return
            end
            if #name <= 0 then
                EquippedSkin.Value = ""
                return
            end
            if not SkinModule or not Utils.PlayerData.GetPlayerOwned(plr, "Skins."..CharacterName.."."..name, false) then
                return
            end

            EquippedSkin.Value = name
            return
        end

        if Type ~= "Killer" and Type ~= "Survivor" then
            return
        end
        if not Utils.PlayerData.GetPlayerOwned(plr, Type.."s."..name, false) then
            return
        end

        local EquippedCharacter = Utils.PlayerData.GetPlayerEquipped(plr, Type, false)
        if EquippedCharacter then
            EquippedCharacter.Value = name
        end
    end)
end