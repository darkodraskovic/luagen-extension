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

function Shape:transformCanvas()
    local transform = self.transform:clone():translate((-self.pos):unpack())
    love.graphics.applyTransform(transform)
end

function Shape:drawOnCanvas(canvas)
    local canvas = canvas or love.graphics.newCanvas(self.size:unpack())
    love.graphics.reset()
    love.graphics.setCanvas(canvas)
    
    self:transformCanvas()
    self:setGraphics()
    self:drawShape()
    
    love.graphics.reset()
    
    return canvas    
end

return Shape
