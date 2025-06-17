-- code to control a tank
-- J'ai dû m'absenter du cours un instant. J'ai repris le code fourni et essayé d'apporter quelques chngements

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