local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Entity = require 'lib.core.entity'

local Graphics = Class{
    __includes = Entity,
    type = 'graphics',
    name = 'graphics',
}

function Graphics:init()
    Entity.init(self)
    self.properties = {}
    self.properties.graphics = {}
end

function Graphics:add(opt)
    self.name = opt.name or self.name
    
    self.pos = (opt.pos and opt.pos:clone()) or self.pos
    self.scale = (opt.scale and opt.scale:clone()) or self.scale
    self.rot = opt.rot or self.rot
    
    for k,v in pairs(opt) do
        local p = k:gsub("^%l", string.upper)
        if love.graphics['set' .. p] then self.properties.graphics['set' .. p] = v end
    end
end

function Graphics:setGraphics()
    for k,v in pairs(self.properties.graphics) do love.graphics[k](v) end
end

function Graphics:draw()
    love.graphics.reset()
    self:setGraphics()
    love.graphics.applyTransform(self.transform)
    self:drawGraphics()
    love.graphics.reset()

    Entity.draw(self)
end

return Graphics
