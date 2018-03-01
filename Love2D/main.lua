function love.load()


  --- Sprites
  sprites = {}
  sprites.coin_sheet   = love.graphics.newImage('sprites/coin_sheet.png')
  sprites.player_jump  = love.graphics.newImage('sprites/444.png')
  sprites.player_standh = love.graphics.newImage ('sprites/123.png')
  sprites.player_stand = love.graphics.newImage('sprites/333.png')
  sprites.player_stands = love.graphics.newImage('sprites/555.png')
  sprites.player_standi = love.graphics.newImage ('sprites/222.png')
  sprites.player_1w = love.graphics.newImage ('sprites/444_1.png')
    sprites.player_1s = love.graphics.newImage ('sprites/123_1.png')
      sprites.player_1d = love.graphics.newImage ('sprites/333_1.png')
        sprites.player_1 = love.graphics.newImage ('sprites/555_1.png')
          sprites.player_1a = love.graphics.newImage ('sprites/222_1.png')
          sprites.nps = love.graphics.newImage ('sprites/player_stand_zap.png')
            sprites.anim = love.graphics.newImage ('animation/99.png')
              sprites.anim1 = love.graphics.newImage ('animation/a2.png')
  sound = love.audio.newSource("sounds/muz.mp3")
sound:setLooping(true)
sound:setVolume (0.2)
sound: setPitch(0.9)
--blip_sound = love.audio.newSource('/sound/blip.wav')
--  blip_sound:setVolume(0.8)
--  blip_sound:setPitch(0.9)


  score = 0 -- счет собранных монет
  timer = 0 -- исходная установка счетчика времени
myFont = love.graphics.newFont(20) -- сделаем размер фонта больше


  --- Add physics and setup gravitation
    myWorld = love.physics.newWorld(0, 500, false)
    myWorld1 = love.physics.newWorld(0, 500, false)
    ---[[6]] введем обработку коллизий для того что бы определить
    -- соприкасается ли человечек с платформой
    myWorld:setCallbacks(beginContact, endContact, preSolve, postSolve)
    myWorld1:setCallbacks(beginContact1, endContact1, preSolve1, postSolve1)
  anim8 = require('anim8')
    require('player')
    require('player_1')
require ('nps')
Camera = require('camera')
  cam = Camera()
  --  require('camera')
    require('coin')
  --  require('coid')

      -- Setup library
      sti = require('sti')
      gameMap = sti("maps/GameMap.lua")
love.graphics.setBackgroundColor(255,255,255)


  --  Platforms
  platforms = {}
  --spawnPlatform(50, 420, 300, 30)
  --spawnPlatform(500, 350, 270, 30)
  --spawnPlatform(1150, 350, 100, 30)
  --spawnPlatform(950, 280, 165, 30)


    for i,obj in ipairs(gameMap.layers["coins"].objects) do
     spawnCoin(obj.x, obj.y, obj.width, obj.height)

   end -- Coins
end
--============================================
function love.update(dt)
cam:lookAt(player.body:getX(), love.graphics.getHeight()/2)
  myWorld:update(dt)
  myWorld1:update(dt)
  gameMap:update(dt)

-----------------------------------------  playeranimation:update(dt)
playerUpdate(dt)
player_1Update(dt)

 timer = timer + dt



--  for i,p in ipairs(coids) do
--         p.animation:update(dt)
--      end



  for i,c in ipairs(coins) do
      c.animation:update(dt)
    end
  coinUpdate(dt)
end

function love.draw()




function spawnPlatform(x, y, width, height)
  local platform = {}
  platform.body = love.physics.newBody(myWorld, x, y, "static") -- тело статичное
  platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height) --[[4]]
  platform.fixture = love.physics.newFixture(platform.body, platform.shape)
  platform.width = width
  platform.height = height
  platform.body1 = love.physics.newBody(myWorld1, x, y, "static") -- тело статичное
  platform.shape1 = love.physics.newRectangleShape(width/2, height/2, width, height) --[[4]]
  platform.fixture1 = love.physics.newFixture(platform.body1, platform .shape1)


-- Draw player 1
love.graphics.draw(player_1.sprite, player_1.body1:getX(), player_1.body1:getY(),
player_1.angle, player_1.direction, 1, sprites.player_1d:getWidth()/2, sprites.player_1d:getHeight()/2 )
-- Draw player 2
love.graphics.draw(player.sprite, player.body:getX(), player.body:getY(),
player.angle, player.direction, 1,sprites.player_stands:getWidth()/2,sprites.player_stands:getHeight()/2 )
end
cam:attach()
for i, p in ipairs (platforms) do
  love.graphics.rectangle('fill', p.body:getX(), p.body:getY(), p.width, p.height)
end
-- 2nd Draw player
love.graphics.draw(player.sprite, player.body:getX(), player.body:getY(),
player.angle, player.direction, 1,sprites.player_stands:getWidth()/2,sprites.player_stands:getHeight()/2 )

  gameMap:drawLayer(gameMap.layers["tile_level_1"])

  for i,obj in ipairs(gameMap.layers["tile_objects"].objects) do
    spawnPlatform(obj.x, obj.y, obj.width, obj.height)
    for i,c in ipairs(coins) do
      c.animation:draw(sprites.coin_sheet, c.x, c.y, nil, nil, nil, 20.5, 21)
    end
    end
      cam:detach()
    love.graphics.setFont(myFont)
      love.graphics.print("Timer = " ..  math.floor(timer), 1250, 0)



  -----------------------------------------------playeranimation:draw(sprites.anim, player.body:getX(), player.body:getY(), nil, nil, nil, sprites.anim:getWidth()/2, sprites.anim:getHeight()/2 )



  --  playeranimation:draw(sprites.coin_sheet, player_1.body1:getX(), player_1.body1:getY())
  --love.graphics.setColor(255,255,255)
  love.graphics.setFont(myFont)
  love.graphics.print("Coins = "..score , 10 , 0)


  --Draw coins into file coin.lua


--for i,p in ipairs(coids) do
--  p.animation:draw(sprites.coin_sheet, p.x, p.y)
--end
end


---================= секция функций ============
---[[3]] -- генерация блоков платформы   -----
function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 +  (x2 -x1)^2 )
end


function love.keypressed(key, scancode, isrepeat)
  if key =="up" and player.grounded == true then ---[[6]]
  player.body:applyLinearImpulse(0, -1150)
elseif key == "w" then
  if key == "w" and player_1.grounded1 == true then
player_1.body1:applyLinearImpulse(0, -1150)
end
  end
end
function beginContact(a,b, coll)
  player.grounded = true
end
-----------------------------------------
function endContact(a, b, coll)
    player.grounded = false
  end


function beginContact1(a,b, coll)
  player_1.grounded1 = true
end
-----------------------------------------
function endContact1(a, b, coll)
    player_1.grounded1 = false
  end
