local CAN_TEST = false

if CAN_TEST then

local ServerStorage = game:GetService("ServerStorage")
local BoxCast = require(ServerStorage.BoxCast)


local caster = BoxCast.new({
    Thickness = 4,
    Quality = 5,
    PointAdvancement = 1,
    PlaneAdvancement = 1,
    PointDistance = 1,
    PlaneDistance = 1,
    Ignore = {}
})


local result  =  caster:cast(workspace.FirstPart.Position, Vector3.new(100, 0, 0))

if result then
    print(result[1].Instance.Name)
end


end