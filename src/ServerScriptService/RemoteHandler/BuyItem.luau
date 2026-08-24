local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Utils = require(ReplicatedStorage.Modules.Utils)
local Network = require(ReplicatedStorage.Modules.Network)

return function()
    Network:SetConnection("BuyItem", "REMOTE_FUNCTION", function(SourcePlayer: Player, Module: ModuleScript, _Quotation: boolean?)
        if typeof(Module) ~= "Instance" or not Module:IsA("ModuleScript") then
            return false
        end

        local Characters = ReplicatedStorage:FindFirstChild("Characters")
        local Assets = ReplicatedStorage:FindFirstChild("Assets")
        local Killers = Characters and Characters:FindFirstChild("Killers")
        local Survivors = Characters and Characters:FindFirstChild("Survivors")
        local Skins = Characters and Characters:FindFirstChild("Skins")
        local SkinKillers = Skins and Skins:FindFirstChild("Killers")
        local SkinSurvivors = Skins and Skins:FindFirstChild("Survivors")
        local Emotes = Assets and Assets:FindFirstChild("Emotes")
        if not Characters or not Assets then
            return false
        end

        local ItemType: string
        local ParentName: string?
        if Killers and Module:IsDescendantOf(Killers) then
            ItemType = "Killers"
        elseif Survivors and Module:IsDescendantOf(Survivors) then
            ItemType = "Survivors"
        elseif (SkinKillers and Module:IsDescendantOf(SkinKillers)) or (SkinSurvivors and Module:IsDescendantOf(SkinSurvivors)) then
            ItemType = "Skins"
            ParentName = Module.Parent and Module.Parent.Name or nil
        elseif Emotes and Module:IsDescendantOf(Emotes) then
            ItemType = "Emotes"
        else
            return false
        end

        if ItemType == "Skins" and not ParentName then
            return false
        end

        local ownedPath = ItemType == "Skins"
            and "Skins."..ParentName.."."..Module.Name
            or ItemType.."."..Module.Name
        if Utils.PlayerData.GetPlayerOwned(SourcePlayer, ownedPath, false) then
            return false
        end

        local ItemInfo = require(Module)
        local Price = ItemInfo.Config and ItemInfo.Config.Price
        if typeof(Price) ~= "number" or not math.isfinite(Price) or Price < 0 then
            return false
        end

        local Money = Utils.Instance.FindFirstChild(SourcePlayer, "PlayerData.Stats.Currency.Money")
        local NetWorth = Utils.Instance.FindFirstChild(SourcePlayer, "PlayerData.Stats.Currency.NetWorth")
        if not Money or not NetWorth or Price > Money.Value then
            return false
        end

        Money.Value -= Price
        NetWorth.Value += Price

        local Product = Instance.new("IntValue")
        Product.Name = Module.Name
        Product.Value = 0

        local Parent = SourcePlayer.PlayerData.Purchased[ItemType]
        if ItemType == "Skins" then
            Parent = Parent:FindFirstChild(ParentName) or Utils.PlayerData.CreateMissingPurchasedSkinValue(SourcePlayer, ParentName)
        end

        Product.Parent = Parent
        Network:FireClientConnection(SourcePlayer, "ShowRewardNotification", "REMOTE_EVENT", Module, "Quoted"..ItemType:sub(1, -2))

        return true
    end)
end
