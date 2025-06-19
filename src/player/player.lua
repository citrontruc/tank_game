-- An object to create a player character
-- This object can be moved by using the keyboard or a controller

-- An object to handle how we control the player and an object to handle graphics
local PlayerController = require("src.player.player_controller")
local PlayerGraphicsHandler = require("src.graphics.player_graphics_handler")

local Player = {}
Player.__index = Player


function Player:new(initial_x, initial_y, size_x, size_y, initial_angle, initial_image_angle)
    local player = {
        player_object = true,
        x = initial_x,
        y = initial_y,
        size_x = size_x,
        size_y = size_y,
        angle = initial_angle,
        current_angle = initial_angle,
        player_controller = {},
        graphics_handler = {},
        initial_image_angle = initial_image_angle
    }
    setmetatable(player, Player)
    return player
end

function Player:set_controller(player_controller)
    self.player_controller = player_controller
end

function Player:set_graphics_handler(graphics_handler)
    self.graphics_handler = graphics_handler
end

--Updates position using the player controller
function Player:update(dt, joystick)
    self.x, self.y = self.player_controller:update(dt, self.x, self.y, self.size_x, self.size_y, joystick)
    self.graphics_handler:update(self.x, self.y)
end

-- Uses the graphic handler to draw the player on screen.
function Player:draw()
    self.graphics_handler:draw(self.x, self.y, self.angle + self.initial_image_angle, self.size_x, self.size_y)
end

return Player
