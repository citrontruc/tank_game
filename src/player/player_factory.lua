-- An object to create player objects
-- The player factory handles the creation of all the components relative to player


local Player = require("src.player.player")

-- Controlleur
local PlayerController = require("src.player.player_controller")

-- Graphic handler
local GraphicsHandler = require("src.graphics.player_graphics_handler")
local ImageItem = require("src.graphics.image_item")
local PlayerImage = ImageItem:new("src/assets/Topdown Tanks Redux/PNG/Default size/tank_blue.png")

local PlayerFactory = {}
PlayerFactory.__index = PlayerFactory


function PlayerFactory:new(missile_namager)
    local player_factory = {
        missile_manager = missile_namager,
    }
    setmetatable(player_factory, PlayerFactory)
    return player_factory
end

function PlayerFactory:create_player(initial_x, initial_y, size_x, size_y, initial_angle, player_rotation_speed, control_type, speed, initial_image_angle)
    local player = Player:new(initial_x, initial_y, size_x, size_y, initial_angle, player_rotation_speed, initial_image_angle)
    local player_graphics_handler = GraphicsHandler:new(PlayerImage)
    local player_controller = PlayerController:new(control_type, speed)

    player:set_graphics_handler(player_graphics_handler)
    player:set_controller(player_controller)
    return player
end

return PlayerFactory
