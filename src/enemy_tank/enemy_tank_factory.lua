-- An object to create enemy_tank objects
-- The enemy_tank factory handles the creation of all the components relative to enemy_tanks


local EnemyTank = require("src.enemy_tank.enemy_tank")

-- Graphic handler
local GraphicsHandler = require("src.graphics.enemy_tank_graphics_handler")
local ImageItem = require("src.graphics.image_item")
local EnemyTankImage = ImageItem:new("src/assets/Topdown Tanks Redux/PNG/Default size/tank_red.png")


-- States
local ChaseState = require("src.enemy_tank.states.chase")
local IdleState = require("src.enemy_tank.states.idle")
local WaitState = require("src.enemy_tank.states.wait")

local EnemyTankFactory = {}
EnemyTankFactory.__index = EnemyTankFactory


function EnemyTankFactory:new()
    local enemy_tank_factory = {}
    setmetatable(enemy_tank_factory, EnemyTankFactory)
    return enemy_tank_factory
end

function EnemyTankFactory:create_tank(initial_x, initial_y, size_x, size_y, speed, speed_run, distance_threshold, rotation_speed, initial_angle)
    local enemy_tank = EnemyTank:new(initial_x, initial_y, size_x, size_y, speed, speed_run, distance_threshold, rotation_speed, initial_angle)
    local enemy_tank_graphics_handler = GraphicsHandler:new(EnemyTankImage)
    local chase_state = ChaseState:new(enemy_tank)
    local idle_state = IdleState:new(enemy_tank)
    local wait_state = WaitState:new(enemy_tank)
    
    enemy_tank:set_graphics_handler(enemy_tank_graphics_handler)
    enemy_tank:set_state("chase", chase_state)
    enemy_tank:set_state("idle", idle_state)
    enemy_tank:set_state("wait", wait_state)
    return enemy_tank
end

return EnemyTankFactory
