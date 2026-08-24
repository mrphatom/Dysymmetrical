local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Modules.Network)

return function()
    Network:SetConnection("UpdateSetting", "REMOTE_EVENT", function(sourcePlayer: Player, ValueObj: Instance, Value: any)
        if typeof(ValueObj) ~= "Instance" then
            return
        end

        local PlayerData = sourcePlayer:FindFirstChild("PlayerData")
        local Settings = PlayerData and PlayerData:FindFirstChild("Settings")
        if not Settings or not ValueObj:IsDescendantOf(Settings) then
            return
        end

        if ValueObj:IsA("BoolValue") then
            if typeof(Value) ~= "boolean" then
                return
            end
        elseif ValueObj:IsA("NumberValue") then
            if typeof(Value) ~= "number" or not math.isfinite(Value) then
                return
            end

            local MinValue = ValueObj:GetAttribute("MinValue")
            local MaxValue = ValueObj:GetAttribute("MaxValue")
            if (MinValue ~= nil and Value < MinValue) or (MaxValue ~= nil and Value > MaxValue) then
                return
            end
        elseif ValueObj:IsA("StringValue") then
            if typeof(Value) ~= "string" or #Value > 200 then
                return
            end
        else
            return
        end

        ValueObj.Value = Value
    end)
end