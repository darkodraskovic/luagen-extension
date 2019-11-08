local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Shape = require 'graphics.shape'

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
    return shapes.newCircleShape(0,0,self.size.x/2)
end

function Ellipse:drawGraphics()
    Shape.modeDraw(self, 0, 0, (self.size/2):unpack())
end

return Ellipse
