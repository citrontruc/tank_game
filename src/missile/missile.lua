-- An object to create a missile sent by a tank
-- This object will be associated to a tank

local MissileGraphicsHandler = require("src.graphics.missile_graphics_handler")

local Missile = {}
Missile.__index = Missile


function Missile:new(position_x, position_y, angle, speed)
    local missile = {
        x = position_x,
        y = position_y,
        angle = angle,
        speed = speed
    }
    setmetatable(missile, Missile)
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
    self.graphics_handler:draw()
end

return Missile
