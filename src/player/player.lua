-- An object to create a player character
-- This object can be moved by using the keyboard or a controller

local Player = {}
Player.__index = Player


function Player:new(initial_x, initial_y, size_x, size_y, initial_angle, player_rotation_speed, initial_image_angle)
    local player = {
        player_object = true,
        x = initial_x,
        y = initial_y,
        size_x = size_x,
        size_y = size_y,
        angle = initial_angle,
        current_angle = initial_angle,
        rotation_speed = player_rotation_speed,
        player_controller = {},
        graphics_handler = {},
        initial_image_angle = initial_image_angle
    }
    setmetatable(player, Player)
    return player
end

-- Setters
function Player:set_controller(player_controller)
    self.player_controller = player_controller
end

function Player:set_graphics_handler(graphics_handler)
    self.graphics_handler = graphics_handler
end

-- Functions to update angles
function Player:shortest_angle_diff()
    local diff = (self.angle - self.current_angle + math.pi) % (2 * math.pi) - math.pi
    return diff
end

function Player:update_angle(dt)
    local diff = self:shortest_angle_diff()
    local max_step = self.rotation_speed * dt

    if math.abs(diff) < max_step then
        self.current_angle = self.angle -- snap to target
    else
        self.current_angle = self.current_angle + max_step * (diff > 0 and 1 or -1)
    end
end

--Updates position using the player controller
function Player:update(dt, joystick)
    self.x, self.y, self.angle = self.player_controller:update(dt, self.x, self.y, self.angle, self.size_x, self.size_y, joystick)
    self:update_angle(dt)
end

-- Uses the graphic handler to draw the player on screen.
function Player:draw()
    self.graphics_handler:draw(self.x, self.y, self.current_angle + self.initial_image_angle, self.size_x, self.size_y)
end

return Player
