-- An object to create a enemy_tank
-- enemy_tank are controlled by a state machine.

local EnemyTank = {}
EnemyTank.__index = EnemyTank


function EnemyTank:new(initial_x, initial_y, size_x, size_y, speed, speed_run, distance_threshold, rotation_speed, initial_angle)
    local enemy_tank = {
        x = initial_x,
        y = initial_y,
        size_x = size_x,
        size_y = size_y,
        speed = speed,
        speed_run = speed_run,
        distance_from_player_square = (distance_threshold + 1)^2,
        distance_threshold = distance_threshold,
        angle = 0,
        current_state = "idle",
        timer = 0,
        idle_coefficient_x = 0,
        idle_coefficient_y = 0,
        states = {},
        current_angle = 0,
        rotation_speed = rotation_speed,
        initial_angle = initial_angle

    }
    setmetatable(enemy_tank, EnemyTank)
    return enemy_tank
end

function EnemyTank:set_state(state_key, state_object)
    self.states[state_key] = state_object
end

function EnemyTank:set_graphic_handler(graphics_handler)
    self.graphics_handler = graphics_handler
end

-- function to compute relationship to player

function EnemyTank:compute_distance_from_player(player_x, player_y)
    return (self.y - player_y)^2 + (self.x - player_x)^2
end

function EnemyTank:get_angle(player_x, player_y)
    return math.atan2(player_y - self.y, player_x - self.x)
end

-- Helper function for angles
function EnemyTank:shortest_angle_diff()
    local diff = (self.angle - self.current_angle + math.pi) % (2 * math.pi) - math.pi
    return diff
end


function EnemyTank:update_angle(dt)
    local diff = self:shortest_angle_diff()
    local max_step = self.rotation_speed * dt

    if math.abs(diff) < max_step then
        self.current_angle = self.angle -- snap to target
    else
        self.current_angle = self.current_angle + max_step * (diff > 0 and 1 or -1)
    end
end

--function to update tank
function EnemyTank:update(dt, player_x, player_y)
    -- Do update action from whichever state the zombie is in
    local reset_timer = self.states[self.current_state]:update(dt)
    -- Update variables
    self.distance_from_player_square = self:compute_distance_from_player(player_x, player_y)
    if self.current_state ~= "wait" then self:update_angle(dt) end
    if self.current_state =="chase" then self.angle = self:get_angle(player_x, player_y) end
    self:check_for_walls()
    self:update_timer(dt, reset_timer)
    self.current_state = self:update_state(dt, reset_timer)
end

-- Check for walls
function EnemyTank:check_for_walls()
    self.x = math.min(math.max(self.size_x/2, self.x), love.graphics.getWidth() - self.size_x/2)
    self.y = math.min(math.max(self.size_y/2, self.y), love.graphics.getHeight() - self.size_y/2)
end
-- function to update zombie state
function EnemyTank:update_state(dt, reset_timer)
    -- If the player is close, we chase him
    if self.distance_from_player_square < self.distance_threshold then return "chase" end
    
    -- If we are idle, we continue until the timer runs out. Same for waiting
    if self.current_state == "idle" and not reset_timer then return "idle" end
    if self.current_state == "wait" and reset_timer then
        local dx = self.idle_coefficient_x
        local dy = self.idle_coefficient_y

        if dx ~= 0 or dy ~= 0 then
            self.angle = math.atan2(dy, dx)
        end
        return "idle" 
    end

    local choices = { -1, 0, 1 }
    self.idle_coefficient_x = choices[math.random(#choices)]
    self.idle_coefficient_y = choices[math.random(#choices)]
    return "wait"
end

function EnemyTank:update_timer(dt, reset_timer)
    if reset_timer then self.timer = 0 end
    self.timer = self.timer + dt
end

function EnemyTank:draw()
    -- We need to specify what is our angle, our size an our initial angle to avoid problems.
    self.graphics_handler:draw(self.x, self.y, self.current_angle + self.initial_angle, self.size_x, self.size_y)
end

return EnemyTank
