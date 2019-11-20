local Class = require 'lib.hump.class'
local Graphics = require 'extension.graphics.graphics'

local Drawable = Class{
    __includes = Graphics,
    type = 'drawable',
}

function Drawable:add(opt)
    Graphics.add(self, opt)
    
    self:setDrawable(opt.drawable)
    self.properties.graphics.setColor = (opt.graphics and opt.graphics.setColor) or {1,1,1,1}
end

function Drawable:setDrawable(drawable, w, h)
    local drawable = assert(drawable, "drawable is mandatory")
    local w, h = w or 0, h or 0
    if drawable.getDimensions then w, h = drawable:getDimensions() end
    self:setSize(w, h)
    self.properties.drawable = drawable
end

function Drawable:draw()
    love.graphics.draw(self.properties.drawable)

    Graphics.draw(self)
end

return Drawable
