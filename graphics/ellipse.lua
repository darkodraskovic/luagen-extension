local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Shape = require 'graphics.shape'

local Ellipse = Class{
    __includes = Shape,
    shape = 'ellipse',
    type = 'ellipse',
    name = 'ellipse',
}

function Ellipse:init()
    Shape.init(self)

    self.properties.radius = vector(0,0)
end

function Ellipse:add(opt)
    Shape.add(self, opt)
    
    self.properties.radius = opt.radius or self.properties.radius
    local lw = self.properties.graphics.setLineWidth or 0
    self.size = self.properties.radius*2 + vector(lw/2, lw/2)
end

function Ellipse:drawGraphics()
    Shape.modeDraw(self, 0, 0, self.properties.radius:unpack())
end

return Ellipse
