--! file: entity.lua

Entity = Object:extend()

function Entity:new(x, y)
  
  self.x = x
  self.y = y
  
end

function Entity:update(dt)
  
end

function Entity:draw()
  
  love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
  
end