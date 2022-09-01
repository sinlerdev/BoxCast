return function(Vector : Vector3)
    local X = math.round(Vector.X)
    local Y = math.round(Vector.Y)
    local Z = math.round(Vector.Z)

    local absX = math.abs(X)
    local absY = math.abs(Y)
    local absZ = math.abs(Z)

    local newVector = Vector3.new(X, Y, Z)

    if absX > absZ then
        newVector = Vector3.new(X, Y, 0)
    else
        newVector = Vector3.new(0, Y , Z)
    end

    return newVector
end



