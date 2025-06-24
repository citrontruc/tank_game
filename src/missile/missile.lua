-- An object to create a missile sent by a tank
-- This object will be associated to a tank

local Missile = {}
local t_afterimage = 0.5
Missile.__index = Missile


function Missile:new(position_x, position_y, angle, speed)
    local missile = {
        x = position_x,
        y = position_y,
        angle = angle,
        speed = speed,
        active = true,
        timer = 0
    }
    setmetatable(missile, self)
    return missile
end

--Setter
function Missile:set_graphics_handler(graphics_handler)
    self.graphics_handler = graphics_handler
end

-- Check for missile collisions with a tank or with a wall
-- Collision check is done by the missile_manager. Collision behaviour depends on the type of missile.
function Missile:check_collision()
end

--Updates position of the missile
function Missile:update(dt)
end

-- Uses the graphic handler to draw the player on screen.
function Missile:draw()
    self.graphics_handler:draw(self.x, self.y, self.speed, self.angle)
    if timer > t_afterimage then self.graphics_handler:draw_afterimage(self.x, self.y, self.speed, self.angle) end
end

return Missile
