local BoxCast = require(script.Parent.Parent.BoxCast)

return {
    {
        title = "Building - 4 thickness & quality",
        calls = 1000,

        run = function()
            BoxCast.new({
                Thickness = 4,
                Quality = 4,
                Ignore = {}
            })
        end
    },
    {
        title = "Building - 4 Thickness/Quality and 0.1 Advancements",
        calls = 1000,

        run = function()
            BoxCast.new({
                Thickness = 5,
                Quality = 5,
                
                PointAdvancement = 0.1,
                PlaneAdvancement = 0.1,

                Ignore = {}

            })
        end
    },
    {
        title = "Building - 4 Thickness/Quality and 10 Distances",
        calls = 1000,

        run = function()
            BoxCast.new({
                Thickness = 5,
                Quality = 5,
                
                PointDistance = 10,
                PlaneDistance = 10,

                Ignore = {}

            })
        end
    }
}