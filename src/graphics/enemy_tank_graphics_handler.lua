-- Graphics handler for our tank. Handles images and movement of images.

local EnemyTankGraphicsHandler = {}
EnemyTankGraphicsHandler.__index = EnemyTankGraphicsHandler


function EnemyTankGraphicsHandler:new()
    local enemy_tank_graphics_handler = {}
    setmetatable(enemy_tank_graphics_handler, EnemyTankGraphicsHandler)
    return enemy_tank_graphics_handler
end

function EnemyTankGraphicsHandler:update()
end

function EnemyTankGraphicsHandler:draw(x, y, size_x, size_y)
    love.graphics.rectangle("fill", x - size_x/2, y - size_y/2, size_x, size_y)
end

return EnemyTankGraphicsHandler
