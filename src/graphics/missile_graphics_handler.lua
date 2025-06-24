-- An object to draw all missiles (player and ennemies alike)

local MissileGraphicsHandler = {}
MissileGraphicsHandler.__index = MissileGraphicsHandler

function MissileGraphicsHandler:new()
    local missile_graphics_handler = {}
    setmetatable(missile_graphics_handler, MissileGraphicsHandler)
    return missile_graphics_handler
end

function MissileGraphicsHandler:update()
end

function MissileGraphicsHandler:draw()
end

function MissileGraphicsHandler:draw_afterimage()
end

return MissileGraphicsHandler
