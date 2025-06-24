-- An object to check for collisions on all our missiles

local MissileManager = {}
MissileManager.__index = MissileManager

function MissileManager:new()
    local missile_manager = {}
    setmetatable(missile_manager, MissileManager)
    return missile_manager
end

function MissileManager:update()
end

return MissileManager
