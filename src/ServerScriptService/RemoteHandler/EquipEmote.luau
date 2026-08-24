local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Utils = require(ReplicatedStorage.Modules.Utils)
local Network = require(ReplicatedStorage.Modules.Network)

return function()
    Network:SetConnection("EquipEmote", "REMOTE_FUNCTION", function(Player: Player, Slot: number, Value: string)
        if typeof(Slot) ~= "number" or not math.isfinite(Slot) or Slot % 1 ~= 0 then
            return
        end
        if typeof(Value) ~= "string" or #Value > 64 then
            return
        end

        local EquippedSlot = Utils.PlayerData.GetPlayerEquipped(Player, "Emotes.Emote"..tostring(Slot), false)
        if not EquippedSlot then
            return
        end

        if #Value <= 0 then
            EquippedSlot.Value = ""
            return
        end

        if Utils.PlayerData.GetPlayerOwned(Player, "Emotes."..Value) then
            EquippedSlot.Value = Value
        end
    end)
end
