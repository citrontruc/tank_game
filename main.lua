-- Imports of our item
local PlayerFactory = require("src.player.player_factory")
local EnemyTankFactory = require("src.enemy_tank.enemy_tank_factory")
local MissileManager = require("src.missile.missile_manager")
local missile_manager = MissileManager:new()

-- Variables info
local player_x = 100
local player_y = 100
local player_size_x = 40
local player_size_y = 40
local player_speed = 400
local player_rotation_speed = 20
local player_initial_angle = 0
local player_control_type = "keyboard"
local player_initial_angle = math.rad(90)
local player_factory = PlayerFactory:new(missile_manager)

local enemy_tank_x = 500
local enemy_tank_y = 500
local enemy_tank_size_x = 50
local enemy_tank_size_y = 50
local enemy_tank_speed = 100
local enemy_tank_speed_run = 100
local enemy_tank_distance_threshold = 300^2
local enemy_tank_rotation_speed = 5
local enemy_tank_factory = EnemyTankFactory:new(missile_manager)
local enemy_tank_initial_angle = math.rad(90)

-- Change sizeof screen
love.window.setMode(1200, 800, flags)

-- Main methods
function love.load()
    player = player_factory:create_player(player_x, player_y, player_size_x, player_size_y, player_initial_angle, player_rotation_speed, player_control_type, player_speed, player_initial_angle)
    enemy_tank = enemy_tank_factory:create_tank(enemy_tank_x, enemy_tank_y, enemy_tank_size_x, enemy_tank_size_y, enemy_tank_speed, enemy_tank_speed_run, enemy_tank_distance_threshold, enemy_tank_rotation_speed, enemy_tank_initial_angle)
    -- Controls to take care of our controller
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end

function love.update(dt)
    player:update(dt, joystick)
    enemy_tank:update(dt, player.x, player.y)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.draw()
    --love.graphics.print("Hello World!", 400, 300)
    player:draw()
    enemy_tank:draw()
end


-- Methods to change control type.
-- If a controller is pressed, we change to detect controller input
function love.keypressed(key, scancode, isrepeat)
   player.player_controller:set_control_type("keyboard")
end

function love.gamepadpressed(joy, button)
    player.player_controller:set_control_type("controller", joystick)
end

function love.joystickadded(j)
    joystick = j  -- support hot-plugging controllers
end
