coins = {}
-- создадим монетку ---
function spawnCoin(x, y)
  --- создаем монетку в заданных координатах
  local coin = {}
  coin.x = x
  coin.y = y
  coin.collected = false
  --- добавляем размеры решетки, которые будут аннимироваться
  --- размер png-файла с монетками coin_sheet.png 123 на 126 pix,
  --- так как у нас три ряда, то
  --- высота ячейки решетки будет равна 123 / 3 = 41,
  --- ширина одной ячейки решетки равна 126 / 3 = 42
  --- подставим эти цифры в функцию newGrid()
  coin.grid = anim8.newGrid(41, 42, 123, 126)
  --- теперь укажем какие фреймы, в какой строке мы будем
  --- аннимировать---
  --- ...coin.grid('1-3',1, ... - это значит фреймы 1,2,3, в строке 1 и т.п. в конце
  --- время показа каждого элемента - 0.2
   coin.animation = anim8.newAnimation(coin.grid('1-3',1, '1-3',2, '1-2',3), 0.2)

  table.insert(coins, coin) -- вносим монетку в глобальную таблицу
  end
function coinUpdate(dt)
          for i,c in ipairs (coins) do
          if distanceBetween(c.x+23,c.y,player.body:getX(),player.body:getY()) < 30 then
          c.collected = true
          score = score + 1
  end




           for i,c in ipairs (coins) do
           if distanceBetween(c.x+23,c.y,player_1.body1:getX(),player_1.body1:getY()) < 30 then
            c.collected = true
                      score = score + 1
        end
end
for i=#coins, 1 , -1 do
      local c = coins[i]
              if c.collected == true then
            table.remove(coins, i)

            end



end -- Update
end
end
