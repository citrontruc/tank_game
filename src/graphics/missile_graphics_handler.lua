-- An object to draw all missiles (player and ennemies alike)

local MissileGraphicsHandler = {}
MissileGraphicsHandler.__index = MissileGraphicsHandler

function MissileGraphicsHandler:new()
end

function MissileGraphicsHandler:update()
end

function MissileGraphicsHandler:draw()
end

function MissileGraphicsHandler:draw_afterimage()
end

return MissileGraphicsHandler
