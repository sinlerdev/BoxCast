local Workspace = game:GetService("Workspace")
local CAN_TEST = false

if CAN_TEST then
    local ServerStorage = game:GetService("ServerStorage")
    local BoxCast = require(ServerStorage.BoxCast)
    local FirstPart = workspace.FirstPart :: Part
    local SecondPart = workspace.SecondPart :: Part

    local caster = BoxCast.new({
        Thickness = 4,
        Quality = 5,
        PointAdvancement = 1,
        PlaneAdvancement = 1,
        PointDistance = 1,
        PlaneDistance = 1,
        Ignore = {}
    })


    FirstPart:GetPropertyChangedSignal("Position"):Connect(function()
        caster:rebuild({
            Quality = 5
        })

        local direction = SecondPart.Position - FirstPart.Position
        
       local result = caster:cast(FirstPart.Position, direction)

       if result then
        print(result[1].Instance.Name)
       end
    end)

    SecondPart:GetPropertyChangedSignal("Position"):Connect(function()
        caster:rebuild({
            Quality = 1
        })

        local direction = FirstPart.Position - SecondPart.Position

        local result = caster:cast(SecondPart.Position, direction)
        
       if result then
        print(result[1].Instance.Name)
       end
    end)
end