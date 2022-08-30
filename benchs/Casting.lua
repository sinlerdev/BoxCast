local BoxCast = require(script.Parent.Parent.BoxCast)

return {
    {
        title = "Casting - 4 thickness & quality",
        calls = 2000,

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
        calls = 2000,

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
    }
}