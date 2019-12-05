local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'
local shapes = require 'lib.HC.shapes'

local Shape = require 'extension.graphics.shape'

local Ellipse = Class{
    __includes = Shape,
    shape = 'ellipse',
    type = 'ellipse',
    name = 'ellipse',
}

function Ellipse:add(opt)
    Shape.add(self, opt)
    
    self:setSize(opt.width, opt.height)
end

function Ellipse:getShape(opt)
    local shape = shapes.newCircleShape(0,0,self.size.x/2)
    local offset = self.size/2
    return shape, offset
end

function Ellipse:draw()
    local x,y = (self.size/2):unpack()
    love.graphics.translate(x, y)
    Shape.draw(self, 0, 0, x, y)
end

return Ellipse
