local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'
local shapes = require 'lib.HC.shapes'

local Shape = require 'graphics.shape'

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
    return shapes.newPolygonShape(0,0, s.x,0, s.x,s.y, 0,s.y)
end

function Rectangle:drawGraphics()
    local s, rx, ry = self.size, self.properties.rx, self.properties.ry
    Shape.modeDraw(self, 0, 0, s.x, s.y, rx, ry)
end

return Rectangle
