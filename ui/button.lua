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

    local shape, offset = panel:getShape()
    self:addComponent(Collider, {shape = shape, offset = offset, collides = false})
    self:addComponent(Pickable)
end

function Button:draw()
    Entity.draw(self)
    
    self.collider:draw()
end

return Button
