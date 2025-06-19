-- An object to create a state for our enemy
-- In the idle state, the enemy walks randomly in a direction for 1 second.

local IdleState = {}
IdleState.__index = IdleState


function IdleState:new(object)
    local idle_state = {object = object}
    setmetatable(idle_state, IdleState)
    return idle_state
end

-- Helper function for angles
function IdleState:shortest_angle_diff()
    local diff = (self.object.angle - self.object.current_angle + math.pi) % (2 * math.pi) - math.pi
    return diff
end


function IdleState:update_angle(dt)
    local diff = self:shortest_angle_diff()
    local max_step = self.object.rotation_speed * dt

    if math.abs(diff) < max_step then
        self.object.current_angle = self.object.angle -- snap to target
    else
        self.object.current_angle = self.object.current_angle + max_step * (diff > 0 and 1 or -1)
    end
end

function IdleState:update(dt)
    self.object.x = self.object.x + self.object.speed * self.object.idle_coefficient_x * dt
    self.object.y = self.object.y + self.object.speed * self.object.idle_coefficient_y * dt
    self:update_angle(dt) 
    if self.object.timer >= 1 then return true end
    return false
end

return IdleState
