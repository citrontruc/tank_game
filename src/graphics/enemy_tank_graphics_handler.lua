-- Graphics handler for our tank. Handles images and movement of images.

local EnemyTankGraphicsHandler = {}
EnemyTankGraphicsHandler.__index = EnemyTankGraphicsHandler


function EnemyTankGraphicsHandler:new(image_item)
    local enemy_tank_graphics_handler = {
        image_item = image_item
    }
    setmetatable(enemy_tank_graphics_handler, EnemyTankGraphicsHandler)
    return enemy_tank_graphics_handler
end

function EnemyTankGraphicsHandler:update()
end

function EnemyTankGraphicsHandler:draw(x, y, rotation, size_x, size_y)
    --love.graphics.rectangle("fill", x - size_x/2, y - size_y/2, size_x, size_y)
    love.graphics.draw(
        self.image_item:getImage(),
        x, y, --position
        rotation, --rotation
        size_x / self.image_item:getWidth(), size_y / self.image_item:getHeight(), --scaling factor
        self.image_item:getWidth()/2, self.image_item:getHeight()/2 --offset. Put original image size values not final radius values
    )
end

return EnemyTankGraphicsHandler
