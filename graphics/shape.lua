local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Graphics = require 'extension.graphics.graphics'

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

function Shape:drawMode(...)
    fill, line = self.properties.fill, self.properties.line
    if fill then
        love.graphics.setColor(fill)
        love.graphics[self.shape]('fill',...)
    end
    if line then
        love.graphics.setColor(line)
        love.graphics[self.shape]('line',...)
    end
end

return Shape
