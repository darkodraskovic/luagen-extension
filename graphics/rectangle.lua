local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'
local shapes = require 'lib.HC.shapes'

local Shape = require 'extension.graphics.shape'

local Rectangle = Class{
    __includes = Shape,
    shape = 'rectangle',
    type = 'rectangle',
    name = 'rectangle',
}

function Rectangle:add(opt)
    Shape.add(self, opt)

    self:setSize(opt.width, opt.height)
    
    self.properties.rx = opt.rx or 0
    self.properties.ry = opt.ry or 0
end

function Rectangle:getShape(opt)
    local s = self.size
    local shape = shapes.newPolygonShape(0,0, s.x,0, s.x,s.y, 0,s.y)
    local offset = self.size/2
    return shape, offset
end

function Rectangle:draw()
    local s, rx, ry = self.size, self.properties.rx, self.properties.ry
    self:drawMode(0, 0, s.x, s.y, rx, ry)

    Shape.draw(self)
end

return Rectangle
