local presetsMod = require "presets"

-- ================================================================
-- settings
-- ================================================================
hs.window.animationDuration = 0

-- ================================================================
-- global variables (shared between modules)
-- TODO: use less global variables
-- TODO: make directions use an array. if one doesn't exist, then try the next one
-- ================================================================
positions = {
  centerPos = {
    name = "centerPos",
    isMain = nil,
    id = nil,  -- deprecated
    win = nil,  -- deprecated
    screenKey = "external",
    rect = nil,
    idStack = {},
    winStack = {},
    selectedIndex = 1,
    west = "southWestPos",
    east = "southEastPos",
    north = "northPos",
    south = "southPos",
    northWest = "northWestPos",
    southWest = "southWestPos",
    northEast = "northEastPos",
    southEast = "southEastPos",
  },
  southWestPos = {
    name = "southWestPos",
    isMain = nil,
    screenKey = "external",
    rect = nil,
    idStack = {},
    winStack = {},
    selectedIndex = 1,
    east = "centerPos",
    north = "northWestPos",
    northEast = "centerPos",
    southEast = "southPos",
    south = "southPos",
  },
  northWestPos = {
    name = "northWestPos",
    isMain = nil,
    screenKey = "external",
    rect = nil,
    idStack = {},
    winStack = {},
    selectedIndex = 1,
    east = "centerPos",
    south = "southWestPos",
    southEast = "centerPos",
  },
  northPos = {
    name = "northPos",
    isMain = nil,
    screenKey = "external",
    rect = nil,
    idStack = {},
    winStack = {},
    selectedIndex = 1,
    west = "northWestPos",
    east = "northEastPos",
    south = "centerPos",
  },
  northEastPos = {
    name = "northEastPos",
    isMain = nil,
    screenKey = "external",
    rect = nil,
    idStack = {},
    winStack = {},
    selectedIndex = 1,
    west = "centerPos",
    south = "southEastPos",
    southWest = "centerPos",
  },
  southEastPos = {
    name = "southEastPos",
    isMain = nil,
    screenKey = "external",
    rect = nil,
    idStack = {},
    winStack = {},
    selectedIndex = 1,
    north = "northEastPos",
    west = "centerPos",
    northWest = "centerPos",
    southWest = "southPos",
    south = "southPos",
  },
  southPos = {
    name = "southPos",
    isMain = nil,
    id = nil,  -- deprecated
    win = nil,  -- deprecated
    screenKey = "laptop",
    rect = nil,
    idStack = {},
    winStack = {},
    selectedIndex = 1,
    north = "centerPos",
    west = "southWestPos",
    east = "southEastPos",
    northWest = "southWestPos",
    northEast = "southEastPos",
  }
}
screens = {}
posMap = {}
_globalMeta = {}
currentLayout = nil

-- ================================================================
-- main entry point. this is invoked at the bottom of the file.
-- ================================================================
function init()
  setEnvironment()
  setLayout(currentLayout)
  presetAllWindows()
  setHotKeys()
end

-- ================================================================
-- functions called by init() above
-- ================================================================
function setEnvironment()
  -- populate "screens" global variable
  local allScreens = hs.screen.allScreens()
  screens = {}
  screens.laptop = allScreens[1]
  if #allScreens > 1 then
    screens.external = allScreens[2]
  end

  if screens.external == nil then
    local now = os.date("*t")
    if now.hour >= 20 or now.wday == 1 or now.wday == 7 then
      currentLayout = "LAYOUT_SINGLE_SCREEN_MOBILE"
    else
      currentLayout = "LAYOUT_SINGLE_SCREEN"
    end
  else
    if string.find(tostring(screens.external), "Acer") then
      local now = os.date("*t")
      if now.hour >= 20 or now.wday == 1 or now.wday == 7 then
        currentLayout = "LAYOUT_HOME_MOBILE"
      else
        currentLayout = "LAYOUT_WORKATHOME_WEB"
      end
    else
      currentLayout = "LAYOUT_WORK_WEB"
    end
  end

  hs.alert.show("external: " .. tostring(screens.external))
end

function setLayout(layoutName)
  hs.alert.show(layoutName)
  local layout = presetsMod.layouts[layoutName]
  local actuallyMainPos = presetsMod.actuallyMainPos[layoutName]

  for posName, rect in pairs(layout) do
    positions[posName].rect = rect
    positions[posName].isMain = posName == actuallyMainPos
  end
end

function presetAllWindows()
  local windows = hs.window.allWindows()
  for i, win in ipairs(windows) do
    -- print (win:title())
    -- print (win:application():name())
    -- print ("---------------")
    presetWindowPos(win)
  end
end

function presetWindowPos(win)
  for posName, apps in pairs(presetsMod.initialApps[currentLayout]) do
    for index, appName in pairs(apps) do
      -- local title = win:title()
      if string.find(win:application():name(), appName) then
        moveToPosition(win, positions[posName])
        return
      end
    end
  end
end

function setHotKeys()
  -- init and layout
  hs.hotkey.bind({"cmd", "alt"}, "A", init)
  hs.hotkey.bind({"cmd", "alt"}, "Tab", rotateLayout)

  -- focusing windows
  hs.hotkey.bind({"cmd", "alt"}, "J", focus("south"))
  hs.hotkey.bind({"cmd", "alt"}, "K", focus("north"))
  hs.hotkey.bind({"cmd", "alt"}, "H", focus("west"))
  hs.hotkey.bind({"cmd", "alt"}, "L", focus("east"))
  hs.hotkey.bind({"cmd", "alt"}, "Y", focus("northWest"))
  hs.hotkey.bind({"cmd", "alt"}, "B", focus("southWest"))
  hs.hotkey.bind({"cmd", "alt"}, "U", focus("northEast"))
  hs.hotkey.bind({"cmd", "alt"}, "N", focus("southEast"))
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", focusWithinStack("down"))
  hs.hotkey.bind({"cmd", "alt", "ctrl"}, "K", focusWithinStack("up"))

  -- swapping windows
  hs.hotkey.bind({"cmd", "alt"}, "Return", swapCurrentWithMain)
  hs.hotkey.bind({"cmd", "alt", "shift"}, "K", swapCurrentWith("north"))
  hs.hotkey.bind({"cmd", "alt", "shift"}, "J", swapCurrentWith("south"))
  hs.hotkey.bind({"cmd", "alt", "shift"}, "Y", swapCurrentWith("northWest"))
  hs.hotkey.bind({"cmd", "alt", "shift"}, "B", swapCurrentWith("southWest"))
  hs.hotkey.bind({"cmd", "alt", "shift"}, "U", swapCurrentWith("northEast"))
  hs.hotkey.bind({"cmd", "alt", "shift"}, "N", swapCurrentWith("southEast"))

  -- one-off window positioning/sizing
  hs.hotkey.bind({"cmd", "alt"}, ",", moveToLeftHalf)
  hs.hotkey.bind({"cmd", "alt"}, ".", moveToRightHalf)
  hs.hotkey.bind({"cmd", "alt"}, "5", makeShort)
  hs.hotkey.bind({"cmd", "alt"}, "6", makeTall)
  hs.hotkey.bind({"cmd", "alt"}, "7", makeWide)
  hs.hotkey.bind({"cmd", "alt"}, "0", moveToOtherScreen)
end

-- ================================================================
-- Window layouting, focusing, moving, and swapping functions (tied to hotkeys)
-- ================================================================
function rotateLayout()
  local Nscreens = length(screens)
  local layoutOrder = presetsMod.layoutOrder[Nscreens]
  local layoutIndex = indexOf(layoutOrder, currentLayout)
  layoutIndex = layoutIndex + 1
  if layoutIndex > #layoutOrder then
    layoutIndex = 1
  end
  local layoutName = layoutOrder[layoutIndex]

  currentLayout = layoutName
  setLayout(layoutName)
  presetAllWindows()
end

function focus(dir)
  return function ()
    local win = hs.window.focusedWindow()
    local pos = posMap[win:id()]
    local newPosName = pos[dir]
    local newPos = positions[newPosName]
    if newPos then
      -- newPos.win:focus()
      -- newPos.winStack[newPos.selectedIndex]:focus()
      newPos.selectedWin:focus()
    end
  end
end

function focusWithinStack(dir)
  return function ()
    local win = hs.window.focusedWindow()
    local pos = posMap[win:id()]
    local winStack = pos.winStack
    local selectedIndex = pos.selectedIndex

    if dir == "down" then
      selectedIndex = selectedIndex - 1
      if selectedIndex < 1 then
        selectedIndex = #winStack
      end
    else
      selectedIndex = selectedIndex + 1
      if selectedIndex > #winStack then
        selectedIndex = 1
      end
    end

    local newWin = winStack[selectedIndex]
    newWin:focus()
    pos.selectedIndex = selectedIndex
    pos.selectedWin = newWin
    pos.selectedId = newWin:id()
  end
end

-- Swap the current window with the window in the specified direction.
-- `dir` is a string.
function swapCurrentWith(dir)
  return function ()
    local currentWin = hs.window.focusedWindow()
    local currentPos = posMap[currentWin:id()]
    local otherPosName = currentPos[dir]
    local otherPos = positions[otherPosName]
    local otherWin = otherPos.selectedWin

    -- TODO: need to remove window from stack
    -- need to copy code from moveToPosition into here and modify it
    -- to swap windows and ids in the stacks
    moveToPosition(currentWin, otherPos)
    moveToPosition(otherWin, currentPos)

    if currentPos.isMain then
      currentPos.previous = otherPos
    end
    otherWin:focus()
  end
end

-- Swap the current window with the Main window
function swapCurrentWithMain()
  local win = hs.window.focusedWindow()
  local pos = posMap[win:id()]
  local mainPos = _getMainPos()

  if pos.isMain then
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
    local mainWin = mainPos.win
    moveToPosition(win, mainPos)
    moveToPosition(mainWin, pos)
    mainPos.previous = pos
    win:focus()
  end
end

function _getMainPos()
  for name, pos in pairs(positions) do
    if pos.isMain then
      return pos
    end
  end
end

function moveToPosition(win, pos)
  local screen = screens[pos.screenKey]
  win:move(pos.rect, screen)

  -- below is deprecated
  pos.id = win:id()
  pos.win = win
  -- above is deprecated

  pos.selectedId = win:id()
  pos.selectedWin = win

  local winStack = pos.winStack
  local nextIndex = #winStack + 1
  pos.winStack[nextIndex] = win
  pos.idStack[nextIndex] = win:id()

  posMap[win:id()] = pos
  setMeta(win, "pos", pos)
end

-- ================================================================
-- less-used one-off functions for positioning and sizing windows
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
    if meta.pos == positions.centerPos or meta.pos == positions.northPos then
      newUnit.x = unit.x - 0.1
    elseif meta.pos == positions.northEastPos or meta.pos == positions.southEastPos then
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
    if meta.pos == positions.centerPos or meta.pos == positions.northPos then
      newUnit.h = 0.82
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
  local currentScreen = win:screen()
  local meta = getMeta(win)
  local newFrame

  if currentScreen == screens.laptop then
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

-- given a list (table where keys are indexes), find the first index (key) that matches the value
-- like JavaScript's indexOf
function indexOf(list, value)
  local result = nil
  for k, v in pairs(list) do
    if v == value then
      result = k
      break
    end
  end
  return result
end

-- return the number of items in the table
function length(tbl)
  local count = 0
  for k, v in pairs(tbl) do
    count = count + 1
  end
  return count
end

-- for debugging
function printWinStack(winStack)
  print("==== printWinStack ====")
  for i, win in pairs(winStack) do
    print(i, win:application():name())
  end
end

-- ================================================================
-- Run it
-- ================================================================
init()
