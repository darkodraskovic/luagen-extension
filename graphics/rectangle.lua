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

function Rectangle:transformCanvas()
    local lw = self.properties.graphics.setLineWidth
    love.graphics.translate(lw/2,lw/2)
    
    Shape.transformCanvas(self)
end

function Rectangle:add(opt)
    Shape.add(self, opt)

    local lw = self.properties.graphics.setLineWidth or 0
    local w,h = opt.width or 0, opt.height or 0
    self.size = vector(w,h) + vector(lw/2, lw/2)
    self.properties.rx = opt.rx or 0
    self.properties.ry = opt.ry or 0
end

function Rectangle:getShape(opt)
    local s = self.size
    return shapes.newPolygonShape(0,0, s.x,0, s.x,s.y, 0,s.y, rx, ry)
end

function Rectangle:drawGraphics()
    local s, rx, ry = self.size, self.properties.rx, self.properties.ry
    Shape.modeDraw(self, 0, 0, s.x, s.y, rx, ry)
end

return Rectangle
