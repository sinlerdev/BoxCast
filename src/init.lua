--[[
	BoxCast is a fast, simple, efficient solution for casting boxes
	with the same flexibilty that you have with workspace:Raycast() .
]]

local Caster = {}
Caster.__index = Caster

type BoxConfig = {
	Thickness : number,
	Quality : number,
	PointAdvancement : number,
	Ignore : {Instance}
}

export type BoxCaster = typeof(Caster)


function Caster.new(config : BoxConfig)
	local Params = RaycastParams.new()
	Params.FilterDescendantsInstances = config.Ignore
	Params.FilterType = Enum.RaycastFilterType.Blacklist
	
	local self = setmetatable({
		Thickness = config.Thickness,
		Quality = config.Quality,
		PointAdvancement = config.PointAdvancement or 1,
		_internalRays = table.create(config.Thickness * config.Quality),
		RaycastParams = Params
	} :: BoxCaster, Caster)
	
	return self
end

function Caster:cast(origin : Vector3, direction : Vector3, raycastParams : RaycastParams?) : {RaycastResult} | nil
	--[[
		We get our internalRays table and then clear it up so that rays from the last call
		don't get mixed up with the rays we are going to cast right now
	]]
	
	local _internalRays = self._internalRays
	table.clear(_internalRays) 
	
	--[[
		We calculate the half of both thickness and quality so we can 
		cast the box the closest it can to the center of the destination.
	]]
	
	local halfQuality = math.floor(self.Quality / 2)
	local halfThickness = math.floor(self.Thickness / 2)
	
	local isIntersected = false -- this is so we can decide whether to return nil, or the tables of rays
	
	local newCFrame = CFrame.lookAt(origin, direction)
	
	for T = -halfThickness, halfThickness do	
		
		for Q = -halfQuality, halfQuality -1, self.PointAdvancement  do -- We do this so the box will be pointing at the center of the direction
			
			local Q_Decimal = Q / 10
			local T_Decimal = T / 10
			
			local right = newCFrame.RightVector * Vector3.new(Q_Decimal, Q_Decimal, Q_Decimal)				
			local forward = newCFrame.UpVector * Vector3.new(T_Decimal, T_Decimal, T_Decimal)
			
			local increaseBy =  right + forward
			
			local rayOrigin = origin + increaseBy
			local rayDirection = direction + increaseBy

			local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams or self.RaycastParams)
			
			if result then
				isIntersected = true
				table.insert(self._internalRays, result)
			end
		end
	end
	--[[
		internalRays are considered immutable by the public user, 
		so we are free to return it instead of deep copying
	]]
	return if isIntersected then _internalRays else nil
end

return Caster