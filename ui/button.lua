local Class = require 'lib.hump.class'

local Entity = require 'lib.core.entity'
local Collider = require 'lib.component.collider'
local Pickable = require 'lib.component.pickable'

local Rectangle = require 'extension.graphics.rectangle'
local Text = require 'extension.graphics.text'

local Button = Class{
    __includes = Entity,
    type = 'button',
    name = 'button',
}

function Button:add(opt)
    Entity.add(self, opt)

    opt.panel.parent = self; opt.label.parent = self
    opt.label.width, opt.label.height = opt.panel.width, opt.panel.height
    local panel = self.scene:addEntity(Rectangle, opt.panel)
    local label = self.scene:addEntity(Text, opt.label)
    self.size = panel.size:clone()

    local shape, offset = panel:getShape()
    panel:addComponent(Collider, {shape = shape, offset = offset, collides = false})
    panel:addComponent(Pickable)

    self:register(panel.signals, 'mousepressed', function(...) self:mousepressed(...) end)
end

function Button:mousepressed(e, x, y, button)
    self:emit('pressed', self, x, y, button)
end

function Button:draw()
    Entity.draw(self)
    
    self.children[1].collider:draw()
end

return Button
