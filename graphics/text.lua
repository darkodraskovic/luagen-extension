local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Graphics = require 'graphics.graphics'

local Text = Class{
    __includes = Graphics,
    type = 'text',
}

function Text:add(opt)
    Graphics.add(self, opt)
    
    self.properties.text = opt.text or ""
    self.properties.font = opt.font or love.graphics.getFont()
    self.size = (opt.size and opt.size:clone()) or vector(0,0)
    if self.size.x == 0 then
        self.size.x = self.properties.font:getWidth(self.properties.text)
    end
    self.properties.hAlign = opt.hAlign or 'center'
    self:setVAlign(opt.vAlign or 'center')
end

function Text:setVAlign(align)
    local p = self.properties
    if align == 'center' then p._vAlign = self.size.y/2  - p.font:getHeight()/2
    elseif align == 'bottom' then p._vAlign = self.size.y  - p.font:getHeight()
    else p._vAlign = 0 end
end


function Text:drawGraphics()
    local p = self.properties
    love.graphics.printf(p.text, p.font, 0, p._vAlign, self.size.x, p.hAlign)
end

return Text
