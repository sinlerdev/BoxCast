local ServerStorage = game:GetService("ServerStorage")
local BoxCast = require(ServerStorage.BoxCast)


local caster = BoxCast.new({
    Thickness = 4,
    Quality = 4,
    PointAdvancement = 0.2,
    Ignore = {}
})


local result  =  caster:cast(workspace.FirstPart.Position, workspace.SecondPart.Position)

if result then
    print(result[1].Instance.Name)
end


