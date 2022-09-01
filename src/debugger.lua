local create = require(script.Parent.create)

local function Point(props)
    return create "Part" {
        Name = props.Name, 
        Anchored = true,
        Position = props.Position,
        Size = Vector3.new(0.1,0.1,0.1),
        CanCollide = false,
        CanTouch = false,
        CanQuery = false,
        Children = props.Children,
        Parent = props.Parent
    } :: Instance
end

local function attach(props)
    return create "Attachment" {
        Name = props.Name,
        Parent = props.Parent
    }
end

local function beam(props)
    return create "Beam" {
        Width0 = 0.4,
        Width1 = 0.4,
        Attachment0 = props.Attachment0,
        Attachment1 = props.Attachment1,
        Parent = props.Parent
    }   
end

local createmodel =  function(props)
    local model = create "Model" {
        Name ="TESTING",
        Parent = props.Parent,
        Children = {
            Point {
                Name = "StartPoint",
                Position = props.Origin + Vector3.new(0.1, 0.1 , 0.1),

                Children = {
                    attach {
                        Name = "attach0",
                    }
                }
            },

            Point {
                Name = "EndPoint",
                Position = props.Origin + props.Direction,

                Children = {
                    attach {
                        Name = "attach1",
                    }
                }
            }
        }
    }



    local Beam = beam {
        Attachment0 = model.StartPoint.attach0,
        Attachment1 = model.EndPoint.attach1,
        Parent = model
    }

    model.Parent = props.Parent

    return model
end

return createmodel