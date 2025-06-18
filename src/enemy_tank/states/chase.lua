-- An object to create a state for our enemy
-- In the chase state, the enemy walks towards the player.

local ChaseState = {}
ChaseState.__index = ChaseState


function ChaseState:new(object)
    local chase_state = {object = object}
    setmetatable(chase_state, ChaseState)
    return chase_state
end

function ChaseState:update(dt)
    self.object.x = self.object.x + self.object.speed_run * math.cos(self.object.angle) * dt
    self.object.y = self.object.y + self.object.speed_run * math.sin(self.object.angle) * dt
    return true
end

return ChaseState
