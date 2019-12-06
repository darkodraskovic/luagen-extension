local Class = require 'lib.hump.class'

local Input = Class()

function Input:init()
    self.keyActions = {}
    self.keySignals = {}
end

function Input:addKeySignal(key, signal)
    self.keySignals[key] = signal
end

function Input:addKeyAction(key, action)
    self.keyActions[key] = action
end

function Input:getKeyAction(key)
    return self.keyActions[key]
end

function Input:isKeyAction(action)
    for k,v in pairs(self.keyActions) do
        if v == action and love.keyboard.isDown(k) then
            return true end
    end
end

return Input
