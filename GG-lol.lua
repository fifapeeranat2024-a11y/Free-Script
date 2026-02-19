_G.AutoFarm = true

local player = game:GetService("Players").LocalPlayer
local remote = game:GetService("ReplicatedStorage"):WaitForChild("MainEvent")

local function equipCombat()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local tool = player.Backpack:FindFirstChild("Combat") or character:FindFirstChild("Combat")
        
        if tool and tool.Parent ~= character then
            humanoid:EquipTool(tool)
        end
        
        
        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end

local function startFarming()
    local cashiers = game:GetService("Workspace").Cashiers:GetDescendants()
    
    while _G.AutoFarm do
        for _, obj in pairs(cashiers) do
            if not _G.AutoFarm then break end
            
            if obj.Name == "Open" and obj:IsA("BasePart") then
                local character = player.Character
                local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                
                if rootPart and character:FindFirstChild("Humanoid").Health > 0 then
                    equipCombat()
                    
                    
                    rootPart.Anchored = false
                    
                   
                     1.5 หน่วย
                    local targetPos = obj.CFrame * CFrame.new(0, 1.5, 1.5)
                    
                    
                    rootPart.CFrame = CFrame.lookAt(targetPos.Position, obj.Position)
                    
                    task.wait(0.2)
                    
                    rootPart.Anchored = true
                    
                    local startTime = tick()
                    while tick() - startTime < 8 do 
                        if not _G.AutoFarm or character:FindFirstChild("Humanoid").Health <= 0 then break end
                        
                        remote:FireServer("ChargeButton")
                        
                       
                        for _, money in pairs(game:GetService("Workspace").Ignored.Drop:GetChildren()) do
                            if money.Name == "MoneyDrop" and (money.Position - rootPart.Position).Magnitude <= 20 then
                                fireclickdetector(money.ClickDetector)
                            end
                        end
                        task.wait(0.15)
                    end
                end
            end
        end
        task.wait(1)
    end
    
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Anchored = false
    end
end

task.spawn(startFarming)
