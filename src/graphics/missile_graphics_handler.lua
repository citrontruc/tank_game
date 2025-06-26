-- An object to draw all types of missiles (player and ennemies alike)

local MissileGraphicsHandler = {}
MissileGraphicsHandler.__index = MissileGraphicsHandler

function MissileGraphicsHandler:new(image_list, trail_max)
    local missile_graphics_handler = {
        image_list = image_list,
        trail = {},
        trail_max = trail_max
    }
    setmetatable(missile_graphics_handler, MissileGraphicsHandler)
    return missile_graphics_handler
end

-- Setter method (set new image for graphics handler)
function MissileGraphicsHandler:set_new_image(image_key, image_item)
    self.image_list[iamge_key] = image_item
end

function MissileGraphicsHandler:update()
end

function MissileGraphicsHandler:draw(position_x, position_y, angle, missile_type)
    self:draw_afterimage(angle, missile_type)
    self:draw_one_missile(position_x, position_y, angle, missile_type)
    table.insert(self.trail, 1, {x = position_x, y = position_y})

    -- Limit trail length
    if #self.trail > self.trail_max then
        table.remove(self.trail)
    end
end

function MissileGraphicsHandler:draw_one_missile(position_x, position_y, angle, missile_type)
    local missile_image = self.image_list[missile_type]
    love.graphics.draw(
        missile_image:getImage(),
        position_x, position_y, --position
        rotation, --rotation
        size_x / missile_image:getWidth(), size_y / missile_image:getHeight(), --scaling factor
        missile_image:getWidth()/2, missile_image:getHeight()/2 --offset. Put original image size values not final radius values
    )
end

function MissileGraphicsHandler:draw_afterimage(angle, missile_type)
    for i, trail_position in ipairs(self.trail) do
        local alpha = i/self.trail_max
        -- Add a shader on our bullets.
        love.graphics.setColor(1, 1, 1, alpha)
        self:draw_one_missile(trail_position.x, trail_position.y, angle, missile_type)
    end
    love.graphics.setColor(1, 1, 1, 1)
end


return MissileGraphicsHandler
