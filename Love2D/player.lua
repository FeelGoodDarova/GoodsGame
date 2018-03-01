player = {}
player.body = love.physics.newBody(myWorld, 2275,550, "dynamic" ) -- тело может двигаться
player.shape = love.physics.newRectangleShape(32, 92)
player.fixture = love.physics.newFixture(player.body, player.shape)
player.speed = 200 --- [[5]] горизонтальная скорость игрока
player.angle = 0
player.grounded = false ---[[6]] ложь если человечек в прыжке, истина если стоит на платфоме
player.dead = false
---[[7]] направление движения для смены спрайта 1 - вправо, -1 - влево
player.sprite = sprites.player_stands  ---[[7]]
player.body:setFixedRotation(true)  ---[[8]]
  player.grid = anim8.newGrid(60, 98, 120, 98)
  layeranimation = anim8.newAnimation(player.grid("1-2",1),0.2)
  function playerUpdate(dt)
  if love.keyboard.isDown("down") then
      player.sprite = sprites.player_standh
        player.body:applyLinearImpulse(0, 40)
      else
      player.sprite = sprites.player_standi
  if love.keyboard.isDown("left") then

      player.body:setX(player.body:getX() - player.speed*dt)
    ---[[7]] повернем спрайт влево
      player.sprite = sprites.player_standi
    else
      player.sprite = sprites.player_stands

  if love.keyboard.isDown("right") then
        player.body:setX(player.body:getX() + player.speed*dt)
        player.sprite = sprites.player_stand
      else
        player.sprite = sprites.player_stands


--  if love.keyboard.isDown("p") then
        --player.angle =   player.angle + math.pi*dt
--  end
  --if love.keyboard.isDown("i") then --вращение влево
--        player.angle =   player.angle - math.pi*dt
--  end
if love.keyboard.isDown("escape") then
    love.event.quit()
  end
if love.keyboard.isDown("space") then
    love.event.quit("restart")
end
  if love.keyboard.isDown("up") then
player.sprite = sprites.player_jump
end
if love.keyboard.isDown("f1") then
  sound:play()
end
if love.keyboard.isDown("f2") then
  sound:pause()
end
if love.keyboard.isDown("f3") then
  sound:stop()
end
  ---- [[6]]  -- обработка коллизий



end
end
end
end
