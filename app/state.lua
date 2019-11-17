local Class = require 'lib.hump.class'

local Signaler = require 'lib.core.signaler'
local Scene = require 'lib.core.scene'

local Input = require 'extension.app.input'

local State = Class{__includes = {Signaler, Input}}

function State:init()
    Signaler.init(self)
    Input.init(self)

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
