--[[
	BoxCast is a fast, simple, efficient solution for casting boxes
	with the same flexibilty that you have with workspace:Raycast() .
]]


local DEBUG_MODE = false -- determines whether BoxCast visuialize rays or not

type BoxConfig = {
	Thickness : number,
	Quality : number,
	Ignore : {Instance}
}

export type BoxCaster = {
	Thickness : number,
	Quality : number,
	RaycastParams : RaycastParams,
	
	_internalRays : {RaycastResult?},
	cast : (Vector3, Vector3, RaycastParams?) -> ({RaycastResult} | nil)
}


local function vRay(origin, direction)
	local midPoint = (origin + direction) / 2

	local part = Instance.new("Part")
	part.Anchored = true
	part.CFrame = CFrame.new(midPoint, origin)
	part.Size = Vector3.new(.01,.01,direction.Magnitude)
	part.Color = Color3.new(1, 0, 0)
	part.Material = Enum.Material.Neon
	part.CanQuery = false
	part.CanTouch = false
	part.CanCollide = false
	
	part.Parent = workspace
	
	return part
end


local Caster = {}
Caster.__index = Caster

function Caster.new(config : BoxConfig)
	local self = setmetatable({
		Thickness = config.Thickness,
		Quality = config.Quality,
		_internalRays = table.create(config.Thickness * config.Quality),
		_debugParts = {}
	}, Caster)
	
	self.RaycastParams = RaycastParams.new()
	self.RaycastParams.FilterDescendantsInstances = config.Ignore
	self.RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	return self
end

function Caster:cast(origin : Vector3, direction : Vector3, raycastParams : RaycastParams?) : {RaycastResult} | nil
	--[[
		We get our internalRays table and then clear it up so that rays from the last call
		don't get mixed up with the rays we are going to cast right now
	]]
	
	local _internalRays = self._internalRays
	table.clear(_internalRays) 
	
	if DEBUG_MODE then
		for i, instanc in self._debugParts do
			instanc:Destroy()
			self._debugParts[i] = nil
		end
	end
	
	local thickness = self.Thickness
	local quality = self.Quality
	
	local halfQuality = quality / 2
	local halfThickness = thickness / 2
	
	
	--[[
		We calculate the following to ensure that the Box will be casted at the center
	]]
	
	local Q_Start = -halfQuality
	local Q_End = quality - (halfQuality + 1)
	
	local T_Start = - halfThickness
	local T_End = thickness - (halfThickness + 1)

	
	local isIntersected = false -- this is so we can decide whether to return nil, or the tables of rays
	
	for T = T_Start, T_End do
		for Q = Q_Start, Q_End  do
			local increaseBy = Vector3.new(Q / 10,T /10,0)
			
			local rayOrigin = origin + increaseBy
			local rayDirection = direction + increaseBy

			local Result = workspace:Raycast(rayOrigin, rayDirection, raycastParams or self.RaycastParams)
			
			if DEBUG_MODE then
				table.insert(self._debugParts,vRay(rayOrigin, rayDirection))
			end
			
			if Result then
				isIntersected = true
				table.insert(_internalRays, Result)
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