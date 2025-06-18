--[[

local centerOfScreen = {}
local tank           = {}
tank.direction       = 'down'

function love.load()
  centerOfScreen.x = love.graphics.getWidth() / 2
  centerOfScreen.y = love.graphics.getHeight() / 2

  tank.image = love.graphics.newImage('tank_green.png')
end

function love.update(dt)
  -- logic
  -- react to user input
  if love.keyboard.isDown('left') then
    tank.direction = 'left'
  elseif love.keyboard.isDown('right') then
    tank.direction = 'right'
  elseif love.keyboard.isDown('up') then
    tank.direction = 'up'
  else
    tank.direction = 'down'
  end
end

function love.draw()
  local size = 76
  local tank_dict = {
    down = 0,
    up = math.rad(180),
    left = math.rad(90),
    right = math.rad(2700)
  }
  local angle = tank_dict[tank.direction]
  love.graphics.draw(tank.image, centerOfScreen.x - size / 2, centerOfScreen.y - size / 2, angle, 1, 1, size/2, size/2)
end

--]]

-- Imports of our item
local Player = require("src.player.player")
local EnemyTankFactory = require("src.enemy_tank.enemy_tank_factory")

-- Variables info
local player_x = 100
local player_y = 100
local player_size_x = 20
local player_size_y = 20
local player_speed = 400

local enemy_tank_x = 500
local enemy_tank_y = 500
local enemy_tank_size_x = 20
local enemy_tank_size_y = 20
local enemy_tank_speed = 100
local enemy_tank_speed_run = 100
local enemy_tank_distance_threshold = 300^2
local enemy_tank_factory = EnemyTankFactory:new()

-- Change sizeof screen
love.window.setMode(1200, 800, flags)

-- Main methods
function love.load()
    player = Player:new(player_x, player_y, player_size_x, player_size_y, player_speed)
    enemy_tank = enemy_tank_factory:create_tank(enemy_tank_x, enemy_tank_y, enemy_tank_size_x, enemy_tank_size_y, enemy_tank_speed, enemy_tank_speed_run, enemy_tank_distance_threshold)
    -- Controls to take care of our controller
    local joysticks = love.joystick.getJoysticks()
    joystick = joysticks[1]
end

function love.update(dt)
    player:update(dt, joystick)
    enemy_tank:update(dt, player.x, player.y)
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
