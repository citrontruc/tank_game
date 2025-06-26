-- A class to control our player character
-- TODO; set up controller support (right now, only dpad)

local PlayerController = {}
PlayerController.__index = PlayerController
local movement_threshold = 0.1

--creation
function PlayerController:new(control_type, speed)
    local object = {
        control_type = control_type,
        speed = speed,
        acceleration = 1000
    }
    setmetatable(object, PlayerController)
    return object
end

--setter
function PlayerController:set_speed(speed_value)
    self.speed = speed_value
end

function PlayerController:set_control_type(control_type, joystick)
    self.control_type = control_type
end

--update
function PlayerController:update(dt, x, y, angle, size_x, size_y, joystick)
    local move_function = {
        keyboard = PlayerController.move_with_keyboard,
        controller = PlayerController.move_with_controller
    }

    chosen_move_function = move_function[self.control_type]
    x, y, angle = chosen_move_function(self, dt, x, y, angle, joystick)
    x, y = self:check_position(x, y, size_x, size_y)
    return x, y, angle
end

--movement functions
--movement with keyboard
function PlayerController:move_with_keyboard(dt, x, y, angle, joystick)
    local dx = 0
    local dy = 0
    if love.keyboard.isDown("down") then
        y = y + self.speed * dt
        dy = 1
    end
    if love.keyboard.isDown("up") then
        y = y - self.speed * dt
        dy = -1
    end
    if love.keyboard.isDown("right") then
        x = x + self.speed * dt
        dx = 1
    end
    if love.keyboard.isDown("left") then
        x = x - self.speed * dt
        dx = -1
    end

    if dx ~= 0 or dy ~= 0 then
        angle = math.atan2(dy, dx)
    end
    return x, y, angle
end

-- movement with controller
function PlayerController:move_with_controller(dt, x, y, angle, joystick)
    local dx = 0
    local dy = 0
    if not joystick then return x, y, angle end
    -- Move with dpad (in which case the angle follows the tank.)
    if joystick:isGamepadDown("dpdown") then
        y = y + self.speed * dt
        dy = 1
    end
    if joystick:isGamepadDown("dpup")then
        y = y - self.speed * dt
        dy = -1
    end
    if joystick:isGamepadDown("dpright") then
        x = x + self.speed * dt
        dx = 1
    end
    if joystick:isGamepadDown("dpleft")then
        x = x - self.speed * dt
        dx = -1
    end

    if dx ~= 0 or dy ~= 0 then
        angle = math.atan2(dy, dx)
    end

    local lx = joystick:getAxis(1)
    local ly = joystick:getAxis(2)
    local rx = joystick:getAxis(3)
    local ry = joystick:getAxis(4)
    if math.abs(lx) > movement_threshold then
        x = x + self.speed * dt * lx
    end
    if math.abs(ly) > movement_threshold then
        y = y + self.speed * dt * ly
    end
    if math.abs(rx) > movement_threshold or math.abs(ry) >= movement_threshold then
        angle = math.atan2(ry, rx)
    end

    return x, y, angle
end

-- Check that player stays on screen
function PlayerController:check_position(x, y, size_x, size_y)
    x = math.min(math.max(size_x/2, x), love.graphics.getWidth() - size_x/2)
    y = math.min(math.max(size_y/2, y), love.graphics.getHeight() - size_y/2)
    return x, y
end

return PlayerController
