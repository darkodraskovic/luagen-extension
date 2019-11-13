local Class = require 'lib.hump.class'

local Signaler = require 'lib.core.signaler'
local Scene = require 'lib.core.scene'

local State = Class{__includes = Signaler}

function State:init()
    Signaler.init(self)
    
    self.keys = {}
    self.scenes = {}
end

-- scenes

function State:addScene(persistent)
    local scene = Scene()
    scene.properties.persistent = persistent
    table.insert(self.scenes, scene)
    return scene
end

function State:removeScene(scene)
    for i,v in ipairs(self.scenes) do
        if scene == v then table.remove(self.scenes, i); v:remove() end
    end    
end

-- input

function State:addKeyAction(key, action)
    self.keys[key] = action
end

function State:getKeyAction(key)
    return self.keys[key]
end

function State:isKeyAction(action)
    for k,v in pairs(self.keys) do
        if v == action and love.keyboard.isDown(k) then
            return true end
    end
end

-- callbacks

function State:update(dt)
    for i,v in ipairs(self.scenes) do v:update(dt) end
end

function State:draw()
    for i,v in ipairs(self.scenes) do v:draw() end
end

function State:mousepressed(...)
    for i,v in ipairs(self.scenes) do v:emit('mousepressed', ...) end
end

function State:mousereleased(...)
    for i,v in ipairs(self.scenes) do v:emit('mousereleased', ...) end
end

-- release

function State:leave()
    for i,v in ipairs(self.scenes) do
        if not v.properties.persistent then table.remove(self.scenes, i); v:remove() end
    end
end

return State
