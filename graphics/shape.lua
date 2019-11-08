local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Graphics = require 'graphics.graphics'

local Shape = Class{
    __includes = Graphics,
    type = 'shape',
    name = 'shape',
}

function Shape:add(opt)
    Graphics.add(self, opt)
    
    self.properties.mode = opt.mode
    self.properties.fill = opt.fill
    self.properties.line = opt.line
end

function Shape:setSize(width, height)
    local lw = self.properties.graphics.setLineWidth or 0
    local w = width or 0
    local h = height or w
    self.size = vector(w,h) + vector(lw/2, lw/2)
end

function Shape.modeDraw(o, ...)
    local mode, fill, line = o.properties.mode, o.properties.fill, o.properties.line
    if mode then love.graphics[o.shape](mode,...) return end
    if fill then
        love.graphics.setColor(fill)
        love.graphics[o.shape]('fill',...)
    end
    if line then
        love.graphics.setColor(line)
        love.graphics[o.shape]('line',...)
    end
end

function Shape:drawOnCanvas(opt)
    local canvas = (opt and opt.canvas) or love.graphics.newCanvas(self.size:unpack())
    local transform = (opt and opt.transform) or love.math.newTransform( )
    love.graphics.reset()
    love.graphics.setCanvas(canvas)
    love.graphics.applyTransform(transform)
    
    self:setGraphics()
    self:drawGraphics()
    
    love.graphics.reset()
    return canvas    
end

return Shape
