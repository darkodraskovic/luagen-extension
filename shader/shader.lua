local Class = require 'lib.hump.class'

local Shader = Class{
    type = 'shader',
    name = 'shader'
}

function Shader:add(opt)
    local e = self.entity
    if opt.dynamics then e:register('pre-update', function(dt) self:preUpdate(dt) end) end
    e:register('pre-draw', function() self:preDraw() end)
    e:register('post-draw', function() self:postDraw() end)
    
    self.shader = opt.shader
    self.uniforms = opt.uniforms or {}
    self.dynamics = opt.dynamics or {}
end

function Shader:preUpdate(dt)
    for k,v in pairs(self.dynamics) do self.uniforms[k] = v(dt) end
end

function Shader:preDraw()
    for k,v in pairs(self.uniforms) do self.shader:send(k, v) end
    love.graphics.setShader(self.shader)
end

function Shader:postDraw()
    love.graphics.setShader()
end

return Shader
