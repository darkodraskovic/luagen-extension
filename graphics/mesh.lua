local Class = require 'lib.hump.class'
local Drawable = require 'extension.graphics.drawable'

local width, height = love.graphics.getDimensions()
local vertices = {
    {
        -- top-left corner (red-tinted)
        0, 0, -- position of the vertex
        0, 0, -- texture coordinate at the vertex position
        1, 0, 0, -- color of the vertex
    },
    {
        -- top-right corner (green-tinted)
        width, 0,
        1, 0, -- texture coordinates are in the range of [0, 1]
        0, 1, 0
    },
    {
        -- bottom-right corner (blue-tinted)
        width, height,
        1, 1,
        0, 0, 1
    },
    {
        -- bottom-left corner (yellow-tinted)
        0, height,
        0, 1,
        1, 1, 0
    },
}

local Mesh = Class{
    __includes = Drawable,
    type = 'mesh',
    name = 'mesh',
}

function Mesh:add(opt)
    opt.drawable = love.graphics.newMesh(opt.vertices or vertices, "fan")
    Drawable.add(self, opt)
end

return Mesh
