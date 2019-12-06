local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Entity = require 'lib.core.entity'

local Graphics = Class{
    __includes = Entity,
    type = 'graphics',
    name = 'graphics',
}

function Graphics.hex2rgb(hex)
    hex = hex:gsub("#","")
    return {tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255, tonumber("0x"..hex:sub(7,8))/255}
end

function Graphics:init()
    Entity.init(self)
    
    self.size = vector(0,0)
end

function Graphics:add(opt)
    opt = assert(opt, "opt obj is mandatory")
    Entity.add(self, opt)

    self:register('pre-draw', function() self:preDraw() end)

    local p = self.properties
    p.graphics = opt.graphics and Class.clone(opt.graphics) or {}
    if type(p.graphics.setColor) == 'string' then
        p.graphics.setColor = Graphics.hex2rgb(p.graphics.setColor)
    else
        p.graphics.setColor = p.graphics.setColor or {1,1,1,1}
    end
end

function Graphics:setSize(width, height)
    local w = width or 0
    local h = height or w
    self.size = vector(w,h)
end

function Graphics:preDraw()
    for k,v in pairs(self.properties.graphics) do love.graphics[k](v) end
end

return Graphics
