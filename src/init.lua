--[[
	BoxCast is a fast, simple, efficient solution for casting boxes
	with the same flexibilty that you have with workspace:Raycast() .
]]

local debugger = require(script.debugger)
local resolveDirections = require(script.resolveDirections)

local DEBUG_MODE = false

local Caster = {}
Caster.__index = Caster

type BoxConfig = {
	Thickness : number,
	Quality : number,
	PointAdvancement : number,
	PlaneAdvancement : number,
	PointDistance : number,
	PlaneDistance: number,
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
		PlaneAdvancement = config.PlaneAdvancement or 1,
		PointDistance = config.PointDistance or 1,
		PlaneDistance = config.PlaneDistance or 1,
		_internalRays = table.create(config.Thickness * config.Quality),
		RaycastParams = Params
	} :: BoxCaster, Caster)

	if DEBUG_MODE then
		self._debugParts = {}
	end
	
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
		for _, part in self._debugParts do
			part:Destroy()
		end

		table.clear(self._debugParts)
	end

	--[[
		We calculate the half of both thickness and quality so we can 
		cast the box the closest it can to the center of the destination.
	]]
	
	local halfQuality = self.Quality / 2
	local halfThickness = self.Thickness / 2
	
	local isIntersected = false -- this is so we can decide whether to return nil, or the tables of rays
	
	local newCFrame = CFrame.lookAt(origin, direction)

	--[[
			
		We "resolve" both the upVector and the rightVector coming from `newCFrame` because sometimes they 
		return for example (0.9, 0, 0.5) which causes some origin-calculation issues
	]]

	local upVector = resolveDirections(newCFrame.UpVector)
	local rightVector = resolveDirections(newCFrame.RightVector)

	for T = -halfThickness, halfThickness - 1, self.PlaneAdvancement do	

		local T_Decimal = (T / 10) * self.PlaneDistance

		local up = upVector * Vector3.new(T_Decimal,  T_Decimal,  T_Decimal)

		for Q = -halfQuality, halfQuality -1 , self.PointAdvancement  do -- We do this so the box will be pointing at the center of the direction
			
			local Q_Decimal = (Q / 10) * self.PointDistance
			
			local right =  rightVector * Vector3.new(Q_Decimal,  Q_Decimal,   Q_Decimal)
			local increaseBy =  right + up
			
			local rayOrigin = origin + increaseBy
			local rayDirection = direction

			local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams or self.RaycastParams)
			
			if DEBUG_MODE then
				table.insert(self._debugParts, debugger {
					Origin = rayOrigin,
					Direction = rayDirection,
					Parent = workspace
				})
			end

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