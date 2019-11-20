local Class = require 'lib.hump.class'

local Shader = Class{
    type = 'shader',
    name = 'shader'
}

local start = love.timer.getTime()
local width, height = love.graphics.getDimensions()

function Shader:add(opt)
    local e = self.entity
    e:register('pre-draw', function() self:preDraw() end)
    e:register('post-draw', function() self:postDraw() end)
    
    self.shader = opt.shader
    self.uniforms = opt.uniforms or {}
    self.dynamics = opt.dynamics or {}
end

function Shader:preDraw()
    local dt = love.timer.getDelta()
    for k,v in pairs(self.dynamics) do self.uniforms[k] = v(dt) end
    for k,v in pairs(self.uniforms) do self.shader:send(k, v) end
    love.graphics.setShader(self.shader)
end

function Shader:postDraw()
    love.graphics.setShader()
end

-- dynamics

function Shader.uMouse()
    return {love.mouse.getPosition()}
end

function Shader.uMouseN()
    local x,y = love.mouse.getPosition()
    return {x/width, y/height}
end

function Shader.uTime()
    return love.timer.getTime() - start    
end

-- uniforms

function Shader.uResolution()
    return {love.graphics.getDimensions()}
end

return Shader
