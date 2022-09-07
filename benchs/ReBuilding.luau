local BoxCast = require(script.Parent.Parent.BoxCast)

return {
    {
        title = "ReBuilding - 4 thickness",
        calls = 1000,
        CacheParamters = true,

        prerun = function()
            return BoxCast.new({
                    Thickness = 4,
                    Quality = 4,
                    Ignore = {}
                })
        end,

        run = function(caster)
            caster:rebuild({
                Thickness = 4,
            })
        end
    },
    {
        title = "ReBuilding - Quality",
        calls = 1000,
        CacheParamters = true,

        prerun = function()
            return BoxCast.new({
                    Thickness = 4,
                    Quality = 4,
                    Ignore = {}
                })
        end,

        run = function(caster)
            caster:rebuild({
                Quality = 4,
            })
        end
    },
}