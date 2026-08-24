local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RoundState: StringValue = ReplicatedStorage.RoundInfo.CurrentState

local ObjectiveManager = {
    Tag = "DysObjective",
    Connections = {},
}

function ObjectiveManager._UpdateCounts()
    local total = 0
    local completed = 0
    for _, objective in CollectionService:GetTagged(ObjectiveManager.Tag) do
        if ObjectiveManager.Connections[objective] then
            total += 1
            if objective:GetAttribute("Completed") == true then
                completed += 1
            end
        end
    end

    workspace:SetAttribute("ObjectiveTotal", total)
    workspace:SetAttribute("ObjectiveCompleted", completed)
    workspace:SetAttribute("ObjectivesComplete", total > 0 and completed >= total)
end

function ObjectiveManager._PrepareObjective(objective: Instance)
    if ObjectiveManager.Connections[objective] then
        return
    end

    local prompt = objective:FindFirstChild("ObjectivePrompt", true)
    if not prompt then
        local promptParent = (objective:IsA("BasePart") or objective:IsA("Model") or objective:IsA("Attachment")) and objective
        if not promptParent then
            return
        end
        prompt = Instance.new("ProximityPrompt")
        prompt.Name = "ObjectivePrompt"
        local objectiveName = objective:GetAttribute("ObjectiveName")
        local holdDuration = objective:GetAttribute("HoldDuration")
        local activationDistance = objective:GetAttribute("ActivationDistance")
        prompt.ActionText = "Complete"
        prompt.ObjectText = typeof(objectiveName) == "string" and objectiveName or "Objective"
        prompt.HoldDuration = typeof(holdDuration) == "number" and math.max(0, holdDuration) or 4
        prompt.MaxActivationDistance = typeof(activationDistance) == "number" and math.max(1, activationDistance) or 10
        prompt.RequiresLineOfSight = true
        prompt.Parent = promptParent
    end

    if not prompt:IsA("ProximityPrompt") then
        return
    end

    objective:SetAttribute("Completed", false)
    prompt.Enabled = RoundState.Value == "InRound"
    ObjectiveManager.Connections[objective] = prompt.Triggered:Connect(function(player: Player)
        if RoundState.Value ~= "InRound" or objective:GetAttribute("Completed") == true then
            return
        end

        local character = player.Character
        local role = character and character:FindFirstChild("Role")
        if not role or role.Value ~= "Survivor" then
            return
        end

        objective:SetAttribute("Completed", true)
        prompt.Enabled = false
        ObjectiveManager._UpdateCounts()
    end)

    ObjectiveManager._UpdateCounts()
end

function ObjectiveManager._RemoveObjective(objective: Instance)
    local connection = ObjectiveManager.Connections[objective]
    if connection then
        connection:Disconnect()
        ObjectiveManager.Connections[objective] = nil
    end
    ObjectiveManager._UpdateCounts()
end

function ObjectiveManager:Init()
    CollectionService:GetInstanceAddedSignal(self.Tag):Connect(function(objective)
        self._PrepareObjective(objective)
    end)
    CollectionService:GetInstanceRemovedSignal(self.Tag):Connect(function(objective)
        self._RemoveObjective(objective)
    end)
    RoundState.Changed:Connect(function(state)
        for objective in self.Connections do
            local prompt = objective:FindFirstChild("ObjectivePrompt", true)
            if prompt and prompt:IsA("ProximityPrompt") then
                prompt.Enabled = state == "InRound" and objective:GetAttribute("Completed") ~= true
            end
            if state ~= "InRound" then
                objective:SetAttribute("Completed", false)
            end
        end
        self._UpdateCounts()
    end)
    for _, objective in CollectionService:GetTagged(self.Tag) do
        self._PrepareObjective(objective)
    end
    self._UpdateCounts()
end

return ObjectiveManager
