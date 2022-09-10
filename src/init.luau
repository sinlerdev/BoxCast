--[[
	BoxCast is a fast, simple, efficient solution for casting boxes
	with the same flexibilty that you have with workspace:Raycast() .
]]

local resolveDirections = require(script.resolveDirections)
local Visualizer = require(script.Visualizer)
local BuildBox = require(script.BuildBox)

local DEBUG_MODE = false

local CONFIG_TYPES = {

	ThicknessProperties = {
		["Thickness"] = true,
		["PlaneAdvancement"] = true,
		["PlaneDistance"] = true,
	},
	QualityProperties = {
		["Quality"] = true,
		["PointAdvancement"] = true,
		["PointDistance"] = true
	}
}


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
		RaycastParams = Params,
		_planeDifference = BuildBox(config.Thickness / 2, (config.PlaneAdvancement or 1), config.PlaneDistance or 1),
		_pointDifference = BuildBox(config.Quality / 2, (config.PointAdvancement or 1), config.PointDistance or 1),

	} , Caster)

	if DEBUG_MODE then
		self._debugger = Visualizer.new({
			RAY_COLOR = Color3.new(1,0,0),
			RAY_WIDTH = 4,
			RAY_NAME = "VISUALIZER",
			FAR_AWAY_CFRAME = CFrame.new(0, math.huge, 0),
			EXPIRE_AFTER =  0.2
		})
	end
	return self
end


function Caster:rebuild(config : BoxConfig)
	local shouldRebuildThickness = false
	local shouldRebuildQuality = false

	for Title, Value in config do
		if CONFIG_TYPES.ThicknessProperties[Title] then
			self[Title] = Value
			shouldRebuildThickness = true
		end

		if CONFIG_TYPES.QualityProperties[Title] then
			self[Title] = Value
			shouldRebuildQuality = true
		end
	end

	if shouldRebuildQuality then
		self._pointDifference = BuildBox(self.Quality / 2, (self.PointAdvancement), self.PointDistance)
	end

	if shouldRebuildThickness then
		self._planeDifference = BuildBox(self.Thickness / 2, (self.PlaneAdvancement), self.PlaneDistance)

	end
end


function Caster:cast(origin : Vector3, direction : Vector3, raycastParams : RaycastParams?) : {RaycastResult} | nil
	--[[
		We get our internalRays table and then clear it up so that rays from the last call
		don't get mixed up with the rays we are going to cast right now
	]]
	
	local _internalRays = self._internalRays
	table.clear(_internalRays) 


	local isIntersected = false -- this is so we can decide whether to return nil, or the tables of rays

	--[[
		We create a cframe from the origin and destination so that we can determine which axies is our right
		and upwards.
	]]
	local newCFrame = CFrame.lookAt(origin, origin + direction)
	local upVector = resolveDirections(newCFrame.UpVector)
	local rightVector = resolveDirections(newCFrame.RightVector)


	for T, ThicknessDiffernce : Vector3 in self._planeDifference do
		local up = upVector * ThicknessDiffernce

		for Q, QualityDifference : Vector3 in self._pointDifference do
			local right = rightVector * QualityDifference

			local rayOrigin = origin + (right + up)
			local rayDirection = direction


			local result = workspace:Raycast(rayOrigin, rayDirection, raycastParams or self.RaycastParams)


			if DEBUG_MODE then
				self._debugger:castRay(rayOrigin, rayDirection)
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