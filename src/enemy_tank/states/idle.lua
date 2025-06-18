-- An object to create a state for our enemy
-- In the idle state, the enemy walks randomly in a direction for 1 second.

local IdleState = {}
IdleState.__index = IdleState


function IdleState:new(object)
    local idle_state = {object = object}
    setmetatable(idle_state, IdleState)
    return idle_state
end

function IdleState:update(dt)
    self.object.x = self.object.x + self.object.speed * self.object.idle_coefficient_x * dt
    self.object.y = self.object.y + self.object.speed * self.object.idle_coefficient_y * dt
    if self.object.timer >= 1 then return true end
    return false
end

return IdleState
