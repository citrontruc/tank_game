-- A class top create normal missiles

local Missile = require("src.missile.missile")

local NormalMissile = setmetatable({}, {__index = Missile})
NormalMissile.__index = NormalMissile

function NormalMissile:new(position_x, position_y, angle, speed)
    local normal_missile = Missile:new(position_x, position_y, angle, speed)
    setmetatable(normal_missile, self)
    return normal_missile
end

--Updates position of the missile
function NormalMissile:update(dt)
    self.x = self.x * math.cos(self.angle) * self.speed * dt
    self.y = self.y * math.sin(self.angle) * self.speed * dt
    self:check_collision()
end

-- Functions to check if the missile has a collision with its target or a wall.
function NormalMissile:check_collision()
    self:check_for_walls()
    self:check_for_target()
end

-- Check if the missile hurst a wall
function NormalMissile:check_wall_collision()
    local x = math.min(math.max(self.size_x/2, self.x), love.graphics.getWidth() - self.size_x/2)
    local y = math.min(math.max(self.size_y/2, self.y), love.graphics.getHeight() - self.size_y/2)
    if self.x ~= x or self.y ~= y then self.active = false end
end

return NormalMissile
