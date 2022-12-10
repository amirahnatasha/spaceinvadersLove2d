--! main.lua fyp

function love.load()
  
  Object = require "classic"
  require "player"
  require "bullet"
  require "enemy"
  require "invaders"
  require "alienbullet"
  
  --load sounds
  collideSound = love.audio.newSource("sounds_invaderkilled.wav", "static")
  gameover = love.audio.newSource("gameover.wav", "stream")
  bgm = love.audio.newSource("backgroundmusic.wav", "stream")
  
  --load font
  font = love.graphics.setNewFont("space_invaders.ttf", 12)
  
  player = Player()
  enemy = Enemy(50, 50)
  listOfBullets = {}
  alienBullets = {}
  invaders = Invaders(4)
  
  bulletCooldown = 0
  
end

function love.update(dt)
  
  --play song in background
  bgm:setLooping(true)
  bgm:play()
  
  --create enemies
  invaders:update(dt)
  invaders:changeDirection()
  
  --move aliens
  if invaders:changeDirection() then
    invaders:moveAlienDown()
  end
  
  --playaers bullet collide with aliens
  for i,v in ipairs(listOfBullets) do
    v:update(dt)
    
    invaders:checkCollision(v)
    
    if v.dead then
      table.remove(listOfBullets, i)
      collideSound:play()
      player.score = player.score + 10
    end
  end
  
  --check collision of alien bullets with player
  for i,v in ipairs(alienBullets) do
    
    if (checkCollision(player, v)) then
      --game over if hit by alien bullets
      gameover:play()
      love.audio.stop(bgm)
      love.load()
    end
    
    
  end
  
end

function love.draw()
  
  player:draw()
  
  for i,v in ipairs(listOfBullets) do
    v:draw()
  end
  
  invaders:draw()
  
  love.graphics.print("Score : " .. player.score, 10, 10)
  love.graphics.print("Health : ", 580, 10)
  
  for i=1,player.health do
    love.graphics.draw(playerImage, 600 + (50), 10, 0, 1/40, 1/40)
  end
  
  love.graphics.print("<-    ->, or [a] and [d] keys to move", 50, 570)
  love.graphics.print("[space]  key to shoot", 350, 570)
  
end

function love.keypressed(key)
  
  player:keypressed(key)
  
  local x = player.x
  
  if x >= 50 and x <= 700 then
    if key == "left" or key == "a" then
      player.x = player.x - 20
    elseif key == "right" or key == "d" then
      player.x = player.x + 20
    end
  end
  
  if x > 700 then
    if key == "left" then
      player.x = player.x - 20
    end
  end
  
  if x < 50 then
    if key == "right" then
      player.x = player.x + 20
    end
  end

end

function checkCollision(a, b)
  
  local a_left = a.x
  local a_right = a.x + a.width
  local a_top = a.y
  local a_bottom = a.y + a.height
  
  local b_left = b.x
  local b_right = b.x + b.width
  local b_top = b.y
  local b_bottom = b.y + b.height
  
  return a_right > b_left
  and a_left < b_right
  and a_bottom > b_top
  and a_top < b_bottom

end

  