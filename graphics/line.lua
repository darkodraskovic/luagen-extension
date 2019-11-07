local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Shape = require 'graphics.shape'

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

function Line:drawGraphics()
    love.graphics.line(unpack(self.properties.points))
end

return Line
