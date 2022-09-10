return function(half, Advancement, distance)
    local Table = table.create((half * 2) * Advancement)
    for I = -half, half - 1, Advancement do
        local I_DECIMAL = (I / 10) * distance
        
        table.insert(Table, Vector3.new(I_DECIMAL, I_DECIMAL, I_DECIMAL))
    end
    return Table
end
