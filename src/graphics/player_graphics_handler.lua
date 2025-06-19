-- Handles how the player position updates and how the animations play out

local PlayerGraphicsHandler = {}
PlayerGraphicsHandler.__index = PlayerGraphicsHandler  -- set up proper metatable for OOP

--creation
function PlayerGraphicsHandler:new(image_item)
    local object = {
        image_item = image_item
    }
    setmetatable(object, PlayerGraphicsHandler)
    return object
end

function PlayerGraphicsHandler:update()
end

function PlayerGraphicsHandler:draw(x, y, rotation, size_x, size_y)
    -- x, y, width height, can have round corners if needed
    -- love.graphics.rectangle("fill", self.x - self.size_x/2, self.y - self.size_y/2, self.size_x, self.size_y)
    love.graphics.draw(
        self.image_item:getImage(),
        x, y, --position
        rotation, --rotation
        size_x / self.image_item:getWidth(), size_y / self.image_item:getHeight(), --scaling factor
        self.image_item:getWidth()/2, self.image_item:getHeight()/2 --offset. Put original image size values not final radius values
    )
end

return PlayerGraphicsHandler
