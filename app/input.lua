local Class = require 'lib.hump.class'

local Input = Class()

function Input:init()
    self.keys = {}
end

function Input:addKeyAction(key, action)
    self.keys[key] = action
end

function Input:getKeyAction(key)
    return self.keys[key]
end

function Input:isKeyAction(action)
    for k,v in pairs(self.keys) do
        if v == action and love.keyboard.isDown(k) then
            return true end
    end
end

return Input
