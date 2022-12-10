--! file: invaders.lua

Invaders = Object:extend()

function Invaders:new(rows)
  
  require "alienbullet"
  
  alienshoot = love.audio.newSource("alienshoot.wav", "static")
  
  self.direction = 0
  self.rows = rows
  self.yMove = 50
  self.alien = Invaders:initialise(rows)
  
  self.speed = 50
  
  self.bulletCooldown = 0
  
  alienBullets = {}
  
end

function Invaders :initialise(rows)
  
  listOfEnemies = {}
  bullets = {}
  
  local y = 50
  
  if #listOfEnemies <= 0 then
    for i = 1,rows do
      for x = 50, 500, 50  do
        table.insert(listOfEnemies, Enemy(x, y))
      end
      y = y + 50
    end
  end
  
  return listOfEnemies
  
end

function Invaders:update(dt)
  
  for i,v in ipairs(self.alien) do
    if self.direction == 0 then
      v.x = v.x + self.speed * dt
    end
    
    if self.direction == 1 then
      v.x = v.x - self.speed * dt
    end
    
    if v.y >= 480 then
      gameover:play()
      love.audio.stop()
      love.load()
    end
  end
  
  --aliens shoot bullets
  if (bulletCooldown >= 25) then
    
    local a = love.math.random(#listOfEnemies)
    for i=1,#listOfEnemies do
      local bullet = AlienBullet(listOfEnemies[a].x, listOfEnemies[a].y)
      
      table.insert(alienBullets, bullet)
      alienshoot:play()
      bulletCooldown = 0
    end
  end
  
  bulletCooldown = bulletCooldown + 1
  
  updateBullets(dt)
  
  
end

function Invaders:draw()
  
  for i,v in ipairs(self.alien) do
    v:draw()
  end
  
  for i,v in ipairs(alienBullets) do
    v:draw()
  end
  
end

function Invaders:changeDirection()
  for i,v in ipairs(listOfEnemies) do
    if v.x <= 50 then
      self.direction = 0
      return true
    elseif v.x + v.width > 700 then
      self.direction = 1
      return true
    end
  end
end

function Invaders:moveAlienDown()
  for i,v in ipairs(listOfEnemies) do
    v.y = v.y + 20
  end
end

function Invaders:checkCollision(obj)
  for a=#listOfEnemies, 1, -1 do
    local currentAlien = listOfEnemies[a]
    
    if obj.x > currentAlien.x
    and obj.x < currentAlien.x + currentAlien.width
    and obj.y > currentAlien.y
    and obj.y < currentAlien.y + currentAlien.height then
      table.remove(listOfEnemies, a)
      obj.dead = true
    end
    
  end 
  
end

function updateBullets(dt)
  for a=#alienBullets, 1, -1 do
    alienBullets[a].y = alienBullets[a].y + 350 *dt
  end
end

