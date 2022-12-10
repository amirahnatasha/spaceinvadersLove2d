--! file: alienbullet.lua

AlienBullet = Object:extend()

function AlienBullet:new(x, y)
  
  self.x = x
  self.y = y
  self.speed = 400
  self.width = 3
  self.height = 6
  
end

function AlienBullet:update(dt)
  
  self.y = self.y + self.speed * dt

end

function AlienBullet:draw()
  
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

end