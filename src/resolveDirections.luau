return function(Vector : Vector3)

    --[[
        We round the axies from the given vector to avoid unwanted results like (0.01, 0.001, 0.02)
    ]]

    local X = math.round(Vector.X)
    local Y = math.round(Vector.Y)
    local Z = math.round(Vector.Z)

    local absX = math.abs(X)
    local absZ = math.abs(Z)

    local newVector : Vector3

    if absX > absZ then
        newVector = Vector3.new(X, Y, 0)
    else
        newVector = Vector3.new(0, Y , Z)
    end

    return newVector
end
