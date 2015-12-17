function preset1()
  local externalScreen = hs.screen.allScreens()[2]:name()
  hs.alert.show(externalScreen)
  local mainWin = hs.geometry.rect(0.25, 0.2, 0.5, 0.65)
  local topLeftWin = hs.geometry.rect(0, 0, 0.3, 0.5)
  local bottomLeftWin = hs.geometry.rect(0, 0.5, 0.3, 0.5)
  local rightWin = hs.geometry.rect(0.5, 0, 0.5, 0.75)

  local windowLayout = {
    {"Emacs", nil, externalScreen, mainWin, nil, nil},
    {"Slack", nil, externalScreen, topLeftWin, nil, nil},
    {"iTerm", nil, externalScreen, bottomLeftWin, nil, nil},
    {"Google Chrome", nil, externalScreen, rightWin, nil, nil},
  }
  hs.layout.apply(windowLayout)
end

hs.hotkey.bind({"cmd", "alt", "shift"}, "1", preset1)

-- ================================================================
-- Start here (above is messing around)
-- Layouts
-- ================================================================
function initPosSideBySide()
  print("initPosSideBySide")
  -- 2 screen SW and Main side by side
  mainPos = {
    rect = hs.geometry.rect(0.45, 0.2, 0.5, 0.65),
    screen = externalScreen,
  }
  -- going clockwise
  southWestPos = {
    rect = hs.geometry.rect(0.15, 0.2, 0.3, 0.65),
    screen = externalScreen,
  }
  northWestPos = {
    rect = hs.geometry.rect(0, 0, 0.3, 0.5),
    screen = externalScreen,
  }
  northPos = {
    rect = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    screen = externalScreen,
  }
  northEastPos = {
    rect = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    screen = externalScreen,
  }
  southEastPos = {
    rect = hs.geometry.rect(0.7, 0.39, 0.3, 0.5),
    screen = externalScreen,
  }
  southPos = {
    rect = hs.geometry.rect(0, 0, 1, 1),
    screen = laptopScreen,
  }
end

function initPos2Screens()
  -- External monitor + laptop below settings
  mainPos = {
    rect = hs.geometry.rect(0.25, 0.2, 0.5, 0.65),
    screen = externalScreen,
  }
  -- going clockwise
  southWestPos = {
    rect = hs.geometry.rect(0, 0.5, 0.26, 0.5),
    screen = externalScreen,
  }
  northWestPos = {
    rect = hs.geometry.rect(0, 0, 0.3, 0.5),
    screen = externalScreen,
  }
  northPos = {
    rect = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    screen = externalScreen,
  }
  northEastPos = {
    rect = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    screen = externalScreen,
  }
  southEastPos = {
    -- rect = hs.geometry.rect(0.7, 0.39, 0.3, 0.5),
    rect = hs.geometry.rect(0.75, 0.2, 0.15, 0.65),
    screen = externalScreen,
  }
  southPos = {
    rect = hs.geometry.rect(0, 0, 1, 1),
    screen = laptopScreen,
  }
end

OFFSET_LEFT = 0.25
-- OFFSET_LEFT = 0.15

function initPosSideBySideRight()
  -- Like 2 screen but with a bigger southEastPos and smaller main
  mainPos = {
    rect = hs.geometry.rect(OFFSET_LEFT, 0.2, 0.35, 0.65),
    screen = externalScreen,
  }
  -- going clockwise
  southWestPos = {
    rect = hs.geometry.rect(0, 0.5, 0.26, 0.5),
    screen = externalScreen,
  }
  northWestPos = {
    rect = hs.geometry.rect(0, 0, 0.3, 0.5),
    screen = externalScreen,
  }
  northPos = {
    rect = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    screen = externalScreen,
  }
  northEastPos = {
    rect = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    screen = externalScreen,
  }
  southEastPos = {
    -- rect = hs.geometry.rect(0.6, 0.2, 0.25, 0.65),
    -- rect = hs.geometry.rect(0.6, 0.2, 0.4, 0.65),
    rect = hs.geometry.rect(OFFSET_LEFT + 0.35, 0.2, 0.3, 0.65),
    screen = externalScreen,
  }
  southPos = {
    rect = hs.geometry.rect(0, 0, 1, 1),
    screen = laptopScreen,
  }
end

function initPosSingleScreen()
  -- Laptop screen settings
  mainPos = {
    rect = hs.geometry.rect(0.05, 0.05, 0.9, 0.95),
  }
  -- going clockwise
  southWestPos = {
    rect = hs.geometry.rect(0, 0.315, 0.5, 0.7),
  }
  northWestPos = {
    rect = hs.geometry.rect(0, 0, 0.9, 0.95),
  }
  northPos = {
    rect = hs.geometry.rect(0.3, 0, 0.3, 0.4),
  }
  northEastPos = {
    rect = hs.geometry.rect(0.5, 0, 0.5, 0.7),
  }
  southEastPos = {
    rect = hs.geometry.rect(0.1, 0, 0.9, 1),
  }
end

-- ================================================================
-- settings / global variables
-- ================================================================
hs.window.animationDuration = 0

-- global variables
-- Note: mainPos, NorthWestPos, etc are also global variables
-- TODO: combine into a single layout table instead
laptopScreen = nil
externalScreen = nil
isMultiScreen = nil
posMap = {}
_globalMeta = {}
currentLayout = nil
layouts = {initPos2Screens, initPosSideBySide, initPosSideBySideRight}

-- ================================================================
-- Init
-- ================================================================
function init()
  -- set global variables
  laptopScreen = hs.screen.allScreens()[1]
  externalScreen = hs.screen.allScreens()[2]

  -- set up my window grid
  allScreens = hs.screen.allScreens()
  if #allScreens > 1 then
    hs.alert.show("multiple screens")
    isMultiScreen = true
    currentLayout = 1
    initPos2Screens()
    -- initPosSideBySide()
    -- rotateLayout()
  else
    hs.alert.show("one screen")
    isMultiScreen = false
    initPosSingleScreen()
  end
  initNeighbors()

  -- preset window positions
  local windows = hs.window.allWindows()
  for i, win in ipairs(windows) do
    print (win:id())
    print (win:title())
    print (win:application():name())
    print ("---------------")
    presetWindowPos(win)
  end
end

function rotateLayout()
  print("rotateLayout")
  currentLayout = currentLayout + 1
  if currentLayout > 3 then
    currentLayout = 1
  end
  print (currentLayout)
  local layoutFunction = layouts[currentLayout]
  print (layoutFunction)
  layoutFunction()
  initNeighbors()

  -- set window positions
  local windows = hs.window.allWindows()
  for i, win in ipairs(windows) do
    print (win:id())
    print (win:title())
    print (win:application():name())
    print ("---------------")
    presetWindowPos(win)
    -- local pos = posMap[win:id()]
    -- if pos then
    --   moveToPosition(win, pos)
    -- end
  end
end

function initNeighbors()
  -- this function is here because hoisting or scope or something doesn't work the way I want it to in Lua
  mainPos.west = southWestPos
  mainPos.east = southEastPos
  if isMultiScreen then
    mainPos.north = northPos
    mainPos.south = southPos
  end
  mainPos.northWest = northWestPos
  mainPos.southWest = southWestPos
  mainPos.northEast = northEastPos
  mainPos.southEast = southEastPos

  -- going clockwise
  southWestPos.east = mainPos
  southWestPos.north = northWestPos
  southWestPos.northEast = mainPos
  if isMultiScreen then
    southWestPos.southEast = southPos
    southWestPos.south = southPos
  end

  northWestPos.east = mainPos
  northWestPos.south = southWestPos
  northWestPos.southEast = mainPos

  northPos.west = northWestPos
  northPos.east = northEastPos
  northPos.south = mainPos

  northEastPos.west = mainPos
  northEastPos.south = southEastPos

  southEastPos.north = northEastPos
  southEastPos.west = mainPos
  southEastPos.northWest = mainPos
  if isMultiScreen then
    southEastPos.southWest = southPos
    southEastPos.south = southPos
  end

  if isMultiScreen then
    southPos.north = mainPos
    southPos.west = southWestPos
    southPos.east = southEastPos
    southPos.northWest = southWestPos
    southPos.northEast = southEastPos
  end

end

-- ================================================================
-- Initial window preset
-- ================================================================
function presetWindowPos(win)
  local name = win:application():name()
  local title = win:title()

  if isMultiScreen then
    if string.find(name, "Emacs") then
      moveToPosition(win, mainPos)
    elseif string.find(name, "Slack") then
      moveToPosition(win, northWestPos)
    elseif string.find(name, "iTerm") and string.find(title, "1.") then
      moveToPosition(win, southWestPos)
    -- elseif string.find(name, "iTerm") and string.find(title, "2.") then
    -- elseif string.find(name, "Discord") then
    elseif string.find(name, "Hammerspoon") then
      moveToPosition(win, northPos)
    elseif string.find(name, "Nylas") then
      moveToPosition(win, northEastPos)
    -- elseif string.find(name, "Hammerspoon") then
    -- elseif string.find(name, "Chrome") and string.find(title, "Redux DevTools") then
    -- elseif string.find(name, "Chrome") and string.find(title, "(1024x1200)") then
    -- elseif string.find(name, "VirtualBox") then
    elseif string.find(name, "Firefox") then
    -- elseif string.find(name, "Chrome") and string.find(title, "Developer Tools") then
      moveToPosition(win, southEastPos)
    elseif string.find(name, "Chrome") then
      moveToPosition(win, southPos)
    end

  else
    if string.find(name, "Emacs") then
      moveToPosition(win, mainPos)
    -- elseif string.find(name, "Discord") then
    elseif string.find(name, "Slack") then
      moveToPosition(win, northWestPos)
    elseif string.find(name, "iTerm") and string.find(title, "1.") then
      moveToPosition(win, southWestPos)
    elseif string.find(name, "Hammerspoon") then
      moveToPosition(win, northEastPos)
    elseif string.find(name, "Chrome") then
      moveToPosition(win, southEastPos)
    end
  end
end

-- ================================================================
-- Utility
-- ================================================================
-- getter and setter for window metadata
function getMeta(win)
  local winMeta = _globalMeta[win:id()]
  if winMeta then
    return winMeta
  else
    return {}
  end
end

function setMeta(win, key, value)
  winMeta = getMeta(win)
  winMeta[key] = value
  _globalMeta[win:id()] = winMeta
end

-- ================================================================
-- Screen positioning / sizing
-- ================================================================
function moveToLeftHalf()
  local win = hs.window.focusedWindow()
  local rect = hs.geometry.rect(0, 0, 0.5, 1)
  win:move(rect)
end

function moveToRightHalf()
  local win = hs.window.focusedWindow()
  local rect = hs.geometry.rect(0.5, 0, 0.5, 1)
  win:move(rect)
end

function makeWide()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local unit = screen:toUnitRect(frame)
  local meta = getMeta(win)
  local newUnit

  if meta.wideUnitRectPrev then
    newUnit = meta.wideUnitRectPrev
    setMeta(win, "wideUnitRectPrev", nil)
  else
    setMeta(win, "wideUnitRectPrev", unit)
    newUnit = hs.geometry.copy(unit)
    if meta.pos == mainPos or meta.pos == northPos then
      newUnit.x = unit.x - 0.1
    elseif meta.pos == northEastPos or meta.pos == southEastPos then
      newUnit.x = unit.x - 0.2
    end
    newUnit.w = unit.w + 0.2
  end
  win:moveToUnit(newUnit)
end

function makeTall()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local unit = screen:toUnitRect(frame)
  local meta = getMeta(win)
  local newUnit

  if meta.tallUnitRectPrev then
    newUnit = meta.tallUnitRectPrev
    setMeta(win, "tallUnitRectPrev", nil)
  else
    setMeta(win, "tallUnitRectPrev", unit)
    newUnit = hs.geometry.copy(unit)
    newUnit.y = 0.0
    if meta.pos == mainPos or meta.pos == northPos then
      newUnit.h = 0.85
    else
      newUnit.h = 1.0
    end
  end
  win:moveToUnit(newUnit)
end

function makeShort()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local screen = win:screen()
  local unit = screen:toUnitRect(frame)
  local meta = getMeta(win)
  local newUnit

  if meta.shortUnitRectPrev then
    newUnit = meta.shortUnitRectPrev
    setMeta(win, "shortUnitRectPrev", nil)
  else
    setMeta(win, "shortUnitRectPrev", unit)
    newUnit = hs.geometry.copy(unit)
    newUnit.y = unit.y + 0.15
    newUnit.h = unit.h - 0.15
  end
  win:moveToUnit(newUnit)
end

-- move window to other screen remembering size and position
function moveToOtherScreen()
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  print("moveToOtherScreen")
  print(frame)
  local currentScreen = win:screen()
  local meta = getMeta(win)
  local newFrame

  if currentScreen == laptopScreen then
    setMeta(win, "laptopFrame", frame)
    if meta.externalFrame then
      newFrame = meta.externalFrame
    else
      newFrame = hs.geometry.copy(frame)
      newFrame.y = newFrame.y - 1200
    end
  else
    setMeta(win, "externalFrame", frame)
    if meta.laptopFrame then
      newFrame = meta.laptopFrame
    else
      newFrame = hs.geometry.copy(frame)
      newFrame.y = newFrame.y + 1400
    end
  end
  win:setFrameInScreenBounds(newFrame)
end

-- ================================================================
-- Swapping window stuff
-- ================================================================
function moveToPosition(win, pos)
  -- win:moveToUnit(pos.rect)
  win:move(pos.rect, pos.screen)
  pos.id = win:id()
  pos.win = win
  posMap[win:id()] = pos
  setMeta(win, "pos", pos)
end

function focus(dir)
  return function ()
    print("focus inner")

    local win = hs.window.focusedWindow()
    local pos = posMap[win:id()]
    local newPos = pos[dir]
    if newPos then

      print(newPos)
      print(newPos.win)

      newPos.win:focus()
    end
  end
end

-- Swap the current window with the window in the specified direction.
-- `dir` is a string.
function swapCurrentWith(dir)
  return function ()
    local currentWin = hs.window.focusedWindow()
    local isMain = currentWin:id() == mainPos.id
    local currentPos = posMap[currentWin:id()]
    local otherPos = currentPos[dir]
    local otherWin = otherPos.win
    moveToPosition(currentWin, otherPos)
    moveToPosition(otherWin, currentPos)
    if isMain then
      currentPos.previous = otherPos
    end
    otherWin:focus()
  end
end

-- Swap the current window with the Main window
function swapCurrentWithMain()
  local win = hs.window.focusedWindow()
  local isMain = win:id() == mainPos.id
  if isMain then
    -- if current window is in the main position, swap with the previous window
    if not mainPos.previous then
      return
    end
    local prevPos = mainPos.previous
    local prevWin = prevPos.win
    moveToPosition(prevWin, mainPos)
    moveToPosition(win, prevPos)
    prevWin:focus()
  else
    -- if current window is not the main position, swap with main window
    local pos = posMap[win:id()]
    local mainWin = mainPos.win
    moveToPosition(win, mainPos)
    moveToPosition(mainWin, pos)
    mainPos.previous = pos
    win:focus()
  end
end

-- ================================================================
-- Run it and set key bindings
-- ================================================================
init()

hs.hotkey.bind({"cmd", "alt"}, "A", init)

hs.hotkey.bind({"cmd", "alt"}, "J", focus("south"))
hs.hotkey.bind({"cmd", "alt"}, "K", focus("north"))
hs.hotkey.bind({"cmd", "alt"}, "H", focus("west"))
hs.hotkey.bind({"cmd", "alt"}, "L", focus("east"))
hs.hotkey.bind({"cmd", "alt"}, "Y", focus("northWest"))
hs.hotkey.bind({"cmd", "alt"}, "B", focus("southWest"))
hs.hotkey.bind({"cmd", "alt"}, "U", focus("northEast"))
hs.hotkey.bind({"cmd", "alt"}, "N", focus("southEast"))

hs.hotkey.bind({"cmd", "alt"}, "Return", swapCurrentWithMain)

hs.hotkey.bind({"cmd", "alt", "shift"}, "K", swapCurrentWith("north"))
hs.hotkey.bind({"cmd", "alt", "shift"}, "J", swapCurrentWith("south"))
hs.hotkey.bind({"cmd", "alt", "shift"}, "Y", swapCurrentWith("northWest"))
hs.hotkey.bind({"cmd", "alt", "shift"}, "B", swapCurrentWith("southWest"))
hs.hotkey.bind({"cmd", "alt", "shift"}, "U", swapCurrentWith("northEast"))
hs.hotkey.bind({"cmd", "alt", "shift"}, "N", swapCurrentWith("southEast"))

hs.hotkey.bind({"cmd", "alt"}, ",", moveToLeftHalf)
hs.hotkey.bind({"cmd", "alt"}, ".", moveToRightHalf)
hs.hotkey.bind({"cmd", "alt"}, "5", makeShort)
hs.hotkey.bind({"cmd", "alt"}, "6", makeTall)
hs.hotkey.bind({"cmd", "alt"}, "7", makeWide)

hs.hotkey.bind({"cmd", "alt"}, "0", moveToOtherScreen)

hs.hotkey.bind({"cmd", "alt"}, "Tab", rotateLayout)
