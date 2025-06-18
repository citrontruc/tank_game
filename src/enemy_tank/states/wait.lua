-- An object to create a state for our enemy
-- In the wait state, the enemy waits until the timer is at 1 second.

local WaitState = {}
WaitState.__index = WaitState


function WaitState:new(object)
    local wait_state = {object = object}
    setmetatable(wait_state, WaitState)
    return wait_state
end

function WaitState:update(dt)
    if self.object.timer >= 1 then return true end
    return false
end

return WaitState
