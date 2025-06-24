-- An object to draw all types of missiles (player and ennemies alike)

local MissileGraphicsHandler = {}
MissileGraphicsHandler.__index = MissileGraphicsHandler

function MissileGraphicsHandler:new()
    local missile_graphics_handler = {}
    setmetatable(missile_graphics_handler, MissileGraphicsHandler)
    return missile_graphics_handler
end

-- Setter method (set new image for graphics handler)
function MissileGraphicsHandler:set_new_image(image_key, image_item)
    local image_key_complete = "image_" .. image_key
    self.image_key_complete = image_item
end

function MissileGraphicsHandler:update()
end

function MissileGraphicsHandler:draw(position_x, position_y, angle, missile_type, missile_origin)
    
end

function MissileGraphicsHandler:draw_afterimage()
end

return MissileGraphicsHandler
