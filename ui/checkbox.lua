local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'
local shapes = require 'lib.HC.shapes'

local Entity = require 'lib.core.entity'
local Collider = require 'lib.component.collider'
local Pickable = require 'lib.component.pickable'

local Rectangle = require 'extension.graphics.rectangle'

local Checkbox = Class{
    __includes = Entity,
    type = 'checkbox',
    name = 'checkbox',
}

function Checkbox:add(opt)
    Entity.add(self, opt)

    self.checked = opt.checked or false
    
    opt.outer.parent = self; opt.inner.parent = self
    local outer = self.scene:addEntity(Rectangle, opt.outer)
    local inner = self.scene:addEntity(Rectangle, opt.inner)
    inner.pos = (outer.size - inner.size)/2
    inner.visible = false

    local shape, offset = outer:getShape()
    self:addComponent(Collider, {shape = shape, offset = offset, collides = false})
    self:addComponent(Pickable)

    self:register('mousepressed', function(...) self:mousepressed(...) end)
end

function Checkbox:mousepressed(e, x, y, button)
    local inner = self.children[2]
    inner.visible, self.checked = not inner.visible, not inner.visible
end

function Checkbox:draw()
    Entity.draw(self)
    
    self.collider:draw()
end

return Checkbox
