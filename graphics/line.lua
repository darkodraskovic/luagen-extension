local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Shape = require 'extension.graphics.shape'

local Line = Class{
    __includes = Shape,
    shape = 'line',
    type = 'line',
    name = 'line',
}

function Line:add(opt)
    Shape.add(self, opt)
    
    self.properties.points = opt.points or {0,0,0,0}
end

function Line:draw()
    love.graphics.line(unpack(self.properties.points))
    
    Shape.draw(self)
end

return Line
