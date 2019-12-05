local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Graphics = require 'extension.graphics.graphics'

local Line = Class{
    __includes = Graphics,
    type = 'line',
    name = 'line',
}

function Line:add(opt)
    Graphics.add(self, opt)
    
    self.properties.points = opt.points or {0,0,0,0}
end

function Line:draw()
    love.graphics.line(self.properties.points)
    
    Graphics.draw(self)
end

return Line
