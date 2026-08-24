local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Network = require(ReplicatedStorage.Modules.Network)
local Utils = require(ReplicatedStorage.Modules.Utils)

return function()
    Network:SetConnection("DropItem", "REMOTE_EVENT", function(Player: Player, Tool: Instance)
        if typeof(Tool) ~= "Instance" or not Tool:IsA("Tool") then
            return
        end
        if not Player.Character or (Tool.Parent ~= Player.Character and Tool.Parent ~= Player.Backpack) then
            return
        end

        local PickableItems = ReplicatedStorage.Assets:FindFirstChild("PickableItems")
        local PickableItemEquivalent = PickableItems and PickableItems:FindFirstChild(Tool.Name)
        if not PickableItemEquivalent or not PickableItemEquivalent:IsA("ModuleScript") then
            return
        end

        local HRP = Utils.Character.GetRootPart(Player.Character)
        if not HRP then
            return
        end

        local Success, PickableItem = pcall(function()
            local Item = Utils.Type.CopyTable(require(PickableItemEquivalent))
            if type(Item.Init) ~= "function" then
                return nil
            end
            Item:Init()
            return Item
        end)
        if not Success or not PickableItem or not PickableItem.ModelInstance then
            return
        end

        Tool:Destroy()
        PickableItem.ModelInstance:PivotTo(HRP.CFrame * CFrame.new(0, -3, 0))
    end)
end
