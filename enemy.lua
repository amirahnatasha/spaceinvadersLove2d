--! file: enemy.lua

Enemy = Object:extend()

function Enemy:new(x, y)
  
  self.x = x
  self.y = y
  self.width = 25
  self.height = 25
  enemyImage = love.graphics.newImage("alien.png")
  
end

function Enemy:draw()
  
  --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  love.graphics.draw(enemyImage, self.x, self.y, 0, 1/20, 1/20)
  
  
end

