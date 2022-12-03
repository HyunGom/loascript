-- global variable for ease of use
-- ARRAY 1-BASED INDEX ... for coordinate
x,y = 1, 2
LEFT_ALT = "lalt"
ESC = "escape"
ENTER = "enter"
INVENTORY = "i"
PET = "semicolon"
MARKET_DELAY = 0.55


-- MAIN FUNCTION
function OnEvent(event, arg)
    -- arg 9 -> middle square button
    -- arg # -> mouse "G" button
	if (event == "MOUSE_BUTTON_RELEASED" and arg == 8) then
    -------------------------------------------
    --- uncomment to select a script to run ---
    -------------------------------------------
--    check_coordinate()

--    market(20, 6)
--    mail(8)


--    auction_gem(81 * 5)
--    gem_macro(3)


--    hazardous()
--    hazardous_repeat(1)
  end
end




-- check mouse coordinate(x,y) and print them out
function check_coordinate()
    x, y = GetMousePosition();
    OutputLogMessage("x = %d AND y = %d\n\n", x,y)
end


-- buy "n" number of market item which is in "r"th row
function market(n, r)
  ClearLog()

  -- CHECK COORDINATE with check_coordinate()
  -- AH item row(x,y) and each row y differences to be on row_count'th
  item = {44500, 16600}
  item_cy = 3500
  
  row_count = r
  
  -- bid/buy button
  bidbuy = {53500, 56000}
  
  -- pop up buy now button
  buy = {32500, 47500}
  
  -- AH search button
  bundle = {34350, 29700}
  
  for i=n, 1, -1
  do
    if (IsModifierPressed(LEFT_ALT))
    then
      break
    end
    left_click(item[x], (item[y] + item_cy * row_count))
    wait_second(0.3)
    left_click(bidbuy[x], bidbuy[y])
    wait_second(0.3)
    left_click(bundle[x], bundle[y])
    key("9")
    key("9")
    left_click(buy[x], buy[y])
    wait_second(0.3)
    key(ENTER)
    wait_second(10)
  end
  
  OutputLogMessage("FINISHED: %s\n", GetDate())
end


-- buy "n" number of gems
function auction_gem(n)
  ClearLog()

  -- CHECK COORDINATE with check_coordinate()
  -- ROW Y-COORDINATE: {1: 20100, 2: 23600, 3: 27100,} or xY = 3500
  item = {52250, 23600}
  
  -- bid/buy button
  bidbuy = {53500, 56000}  
  
  -- pop up buy now button
  buynow = {38500, 41200}
  
  -- AH search button
  search = {51500, 14500}
  
  OutputLogMessage("START: %s\n", GetDate())
  
  for i=n, 1, -1
  do
    if (IsModifierPressed(LEFT_ALT))
    then
      break
    end
    left_click(search[x], search[y])
    wait_second(MARKET_DELAY)
    left_click(item[x], item[y])
    left_click(bidbuy[x], bidbuy[y])
    left_click(buynow[x], buynow[y])
    key(ENTER)
    wait_second(10)
  end
  
  OutputLogMessage("FINISHED: %s\n", GetDate())
end



-- retrieve all mails of "m" number of pages
function mail(m)
  ClearLog()
  
  -- select all check box
  select_x = 13750
  select_y = 19000

  -- take attachment button
  take_x = 20900
  take_y = 50500

  -- delete selection button
  delete_x = 26150
  delete_y = 50500
  
  remote_btn = {39800, 42700}
  
  key(PET)
  wait_second(0.5)
  left_click(remote_btn[x], remote_btn[y])
  wait_second(1)

  for i=m, 1, -1
  do
    left_click(select_x, select_y)
    left_click(take_x, take_y)
    wait_second(0.5)
    left_click(select_x, select_y)
    left_click(delete_x, delete_y)
    key(ENTER)
    wait_second(0.5)
  end
  
  key(ESC)
  key(ESC)
  
end



-- weekly guild quest hazardous
function hazardous()
  
  -- quest points coordinates
  points = {
    {27600, 28550},
    {25400, 26950},
    {23100, 28500},
    {23000, 30300}
  }
  
  wait_second(1)
  
  -- open world map "m" and left click on the grid
  key("m")
  wait_second(1)

  -- auto route paths
  PressKey(LEFT_ALT)
  for i=1, #points, 1
  do
    left_click(points[i][x], points[i][y])
  end
  ReleaseKey(LEFT_ALT)
  
  -- close map
  key(ESC)

end


-- weekly guild quest hazardous REPEAT VER
function hazardous_repeat(a)

  -- quest points coordinates
  points = {
    {27600, 28550},
    {25400, 26950},
    {23100, 28500}
  }
  
  wait_second(5)
  
  repeat_amount = a
  route_time = 100
  OutputLogMessage("START: %s\n", GetDate())
  for r=0, repeat_amount-1, 1
  do
  
    if (IsModifierPressed(LEFT_ALT))
    then
      break
    end
  
    -- REPEAT TAKE: R-> L
    accept_guild()
    -- open world map "m" and left click on the grid
    key("m")
    wait_second(1)
    PressKey(LEFT_ALT)
    for i=1, #points, 1
    do
      left_click(points[i][x], points[i][y])
    end
    ReleaseKey(LEFT_ALT)
    key(ESC)
    if (r % 2 == 0) then
      wait_second(route_time + 50)
    else
      wait_second(route_time)
    end
    
    complete_quest()
    
    if (IsModifierPressed(LEFT_ALT))
    then
      break
    end
    
    -- REPEAT TAKE: L-> R
    accept_guild()
    -- open world map "m" and left click on the grid
    key("m")
    wait_second(1)
    PressKey(LEFT_ALT)
    for j=#points, 1, -1
    do
      left_click(points[j][x], points[j][y])
    end
    ReleaseKey(LEFT_ALT)
    key(ESC) 
    wait_second(route_time)
    
    complete_quest()
    
    -- repair ship every 2 round trips to not blow up
    if (r % 2 == 0) then
      repair_ship()
    end
    
  end
  OutputLogMessage("FINISHED: %s\n", GetDate())

end


function gem_macro(n)

  for i=n, 1, -1
  do
    mail(8)
    wait_second(1)
    fuse_gem()
  end
end
  
  
------------------------ HELPER FUNCTIONS -------------------------------------
-- Mouse Left Click
function MLC()
    PressMouseButton(1)
    Sleep(10 + math.random(10,20))
    ReleaseMouseButton(1)
    Sleep(10 + math.random(10,20))
end


-- Mouse Right Click
function MRC()
    PressMouseButton(3)
    Sleep(10 + math.random(10,20))
    ReleaseMouseButton(3)
    Sleep(10 + math.random(10,20))
end


-- Move to (X,Y) and Left Click
function left_click(x, y)
    MoveMouseTo(x + math.random(10, 30), y + math.random(10, 30))
    Sleep(100 + math.random(10,30))
    MLC()
    Sleep(250 + math.random(10,30))
end


-- Move to (X,Y) and Right Click
function right_click(x, y)
    MoveMouseTo(x + math.random(10, 30), y + math.random(10, 30))
    Sleep(100 + math.random(10,30))
    MRC()
    Sleep(250 + math.random(10,30))
end


-- Keyboard Press
function key(k)
    PressKey(k)
    Sleep(math.random(10,30))
    ReleaseKey(k)
    Sleep(200 + math.random(10,30))
end


-- Wait S second(s)
function wait_second(s)
    Sleep(s * 1000 + math.random(10, 30))
end


function accept_guild()
  quest_next = {31600, 47250}
  guild_quest = {43950, 19800}
  
  -- open una task for guild quest
  PressKey(LEFT_ALT)
  key("j")
  ReleaseKey(LEFT_ALT)
  wait_second(0.8)
  left_click(quest_next[x], quest_next[y])
  wait_second(0.8)
  left_click(guild_quest[x], guild_quest[y])
  wait_second(1)
  key(ESC)
end

function complete_quest()
  check_button = {56500, 23800}
  complete_button = {12150, 45000}
  
  left_click(check_button[x], check_button[y])
  wait_second(0.5)
  left_click(complete_button[x], complete_button[y])
  wait_second(0.5)
end


function repair_ship()
  map = {27000, 30000}
  harbor = {46800, 33400}
  repair_button = {38000, 61800}
  
  key("m")
  wait_second(1)
  
  left_click(map[x], map[y])
  wait_second(0.5)
  
  PressKey(LEFT_ALT)
  left_click(harbor[x], harbor[y])
  ReleaseKey(LEFT_ALT)
  wait_second(45)
  
  key("z")
  wait_second(3)
  left_click(repair_button[x], repair_button[y])
  wait_second(1)
  key(ENTER)
  wait_second(1)
  key(ESC)
  wait_second(10)
end


function fuse_gem()
    gem_btn = {51350, 48950}
    lv_btn = {36500, 44300}
    fuse_btn = {41200, 48350}
    confirm_btn = {31100, 35500}
  
  
    key(INVENTORY)
    left_click(gem_btn[x], gem_btn[y])
    left_click(lv_btn[x], lv_btn[y])
    left_click(fuse_btn[x], fuse_btn[y])
    left_click(confirm_btn[x], confirm_btn[y])
    wait_second(1)
    key(ESC)
    wait_second(0.3)
    key(ESC)
    wait_second(0.3)
end