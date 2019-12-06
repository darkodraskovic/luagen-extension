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
    
    self.properties.fill = opt.fill
    self.properties.line = opt.line
end

function Shape:draw(...)
    mode, fill, line = self.properties.mode, self.properties.fill, self.properties.line
    if mode then
        love.graphics[self.shape](mode,...)
        return
    end
    if fill then
        love.graphics.setColor(fill)
        love.graphics[self.shape]('fill',...)
    end
    if line then
        love.graphics.setColor(line)
        love.graphics[self.shape]('line',...)
    end
    
    Graphics.draw(self)
end

return Shape
