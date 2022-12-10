--! file: player.lua

Player = Object:extend()

function Player:new()
  
  playerImage = love.graphics.newImage("player.png")
  self.x = 50
  self.y = 500
  self.width = playerImage:getWidth() / 20
  self.height = playerImage:getHeight() / 20
  shootSound = love.audio.newSource("sounds_shoot.wav", "static")
  
  self.score = 0
  self.health = 3
  
end

function Player:update(dt)
  
end

function Player:draw()
  
  --love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
  love.graphics.draw(playerImage, self.x, self.y, 0, 1/20, 1/20)
  
end

function Player:keypressed(key)
  
  if key == "space" then
    table.insert(listOfBullets, Bullet(self.x + 13, self.y))
    shootSound:play()
  end    
end
  
