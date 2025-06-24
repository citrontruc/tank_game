-- A class top create normal missiles

local Missile = require("src.missile.missile")

local NormalMissile = setmetatable({}, {__index = Missile})
NormalMissile.__index = NormalMissile

function NormalMissile:new(position_x, position_y, angle, speed)
    local normal_missile = Missile:new(position_x, position_y, angle, speed)
    setmetatable(normal_missile, self)
    return normal_missile
end

function NormalMissile:check_collision()
end

--Updates position of the missile
function NormalMissile:update(dt)
end

return NormalMissile
