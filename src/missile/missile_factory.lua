-- Creates a missile and assigns it all the important elements (graphic handler, state, ...)

-- Get missiles
local NormalMissile = require("src.missile.states.normal")
local BouncingMissile = require("src.missile.states.bouncing")
local MissileManager = require("src.missile.missile_manager")

-- Objects to generate graphics
local MissileGraphicsHandler = require("src.graphics.missile_graphics_handler")
local ImageItem = require("src.graphics.image_item")
local NormalPlayerMissileImage = ImageItem:new("src/assets/Topdown Tanks Redux/PNG/Default size/bulletBlue1_outline.png")
local NormalEnemyMissileImage = ImageItem:new("src/assets/Topdown Tanks Redux/PNG/Default size/bulletRed1_outline.png")

local accepted_missile_types = {
    normal = NormalMissile,
    bouncing = BouncingMissile
}

local MissileFactory = {}
MissileFactory.__index = MissileFactory

function MissileFactory:new()
    local missile_factory = {
        graphics_handler = MissileGraphicsHandler
    }
    setmetatable(missile_factory, MissileFactory)
    return missile_factory
end

function MissileFactory:create_missile(position_x, position_y, angle, speed, missile_type, missile_origin)
    local missile_constructor = accepted_missile_types[missile_type]
    
end

return MissileFactory
