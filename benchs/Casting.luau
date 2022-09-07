local BoxCast = require(script.Parent.Parent.BoxCast)

return {
    {
        title = "Casting - 4 thickness & quality",
        calls = 1000,
        CacheParamters = true,

        prerun = function()
            return BoxCast.new({
                Thickness = 4,
                Quality = 4,
                Ignore = {workspace.FirstPart}
            }) 
        end,

        run = function(cast)
            cast:cast(workspace.FirstPart.Position, workspace.SecondPart.Position)
        end
    },
    {
        title = "Casting - 6 thickness 4 quality",
        calls = 1000,
        CacheParamters = true,

        prerun = function()
            return BoxCast.new({
                Thickness = 6,
                Quality = 4,
                Ignore = {workspace.FirstPart}
            }) 
        end,
        
        run = function(cast)
            cast:cast(workspace.FirstPart.Position, workspace.SecondPart.Position)
        end
    },
    {
        title = "Casting - 6 thickness 4 quality - 0.1 Point/Plane advancement",
        calls = 1000,
        CacheParamters = true,

        prerun = function()
            return BoxCast.new({
                Thickness = 6,
                Quality = 4,
                PointAdvancement = 0.1,
                PlaneAdvancement  = 0.1,
                Ignore = {workspace.FirstPart}
            }) 
        end,
        
        run = function(cast)
            cast:cast(workspace.FirstPart.Position, workspace.SecondPart.Position)
        end
    },
    {
        title = "Casting - 6 thickness 4 quality - 0.1 Point/Plane distance",
        calls = 1000,
        CacheParamters = true,

        prerun = function()
            return BoxCast.new({
                Thickness = 6,
                Quality = 4,
                PointDistance = 0.1,
                PlaneDistance  = 0.1,
                Ignore = {workspace.FirstPart}
            }) 
        end,
        
        run = function(cast)
            cast:cast(workspace.FirstPart.Position, workspace.SecondPart.Position)
        end
    }
}