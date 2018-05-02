-- ================================================================
-- Application window presets
-- ================================================================
local initialApps = {
  LAYOUT_SINGLE_SCREEN = {
    centerPos = {"Emacs"},
    southWestPos = {"iTerm"},
    northWestPos = {"Slack"},
    northPos = {},
    northEastPos = {"Hammerspoon"},
    southEastPos = {"Chrome"},
  },
  LAYOUT_SINGLE_SCREEN_MOBILE = {
    centerPos = {"Emacs"},
    southWestPos = {"Simulator"},
    northWestPos = {"iTerm"},
    northPos = {},
    northEastPos = {"Hammerspoon"},
    southEastPos = {"Chrome"},
  },
  LAYOUT_WORKATHOME_WEB = {
    centerPos = {"Chrome"},
    southPos = {"Emacs"},
    southWestPos = {"iTerm"},
    northWestPos = {"Slack"},
    northPos = {},
    northEastPos = {},
    southEastPos = {"Hammerspoon"},
  },
  LAYOUT_WORKATHOME_MOBILE = {
    centerPos = {"Simulator", "Android Emulator", "player"},
    southPos = {"Emacs"},
    southWestPos = {"iTerm"},
    northWestPos = {"Slack"},
    northPos = {"Hammerspoon"},
    northEastPos = {},
    southEastPos = {"Chrome", "Sketch"},
  },
  LAYOUT_WORK_WEB = {
    centerPos = {"Chrome"},
    southPos = {"Emacs", "Sketch"},
    southWestPos = {"iTerm"},
    northWestPos = {"Slack"},
    northPos = {},
    northEastPos = {},
    southEastPos = {"Hammerspoon"},
  },
  LAYOUT_WORK_MOBILE = {
    centerPos = {"Simulator", "Android Emulator"},
    southPos = {"Emacs"},
    southWestPos = {"iTerm"},
    northWestPos = {"Slack"},
    northPos = {"Hammerspoon"},
    northEastPos = {},
    southEastPos = {"Chrome", "Sketch"},
  },
  LAYOUT_HOME_WEB = {
    centerPos = {"iTerm"},
    southPos = {"Emacs"},
    southWestPos = {"Chrome"},
    northWestPos = {"Slack"},
    northPos = {},
    northEastPos = {},
    southEastPos = {"Hammerspoon"},
  },
}

-- ================================================================
-- Layouts
-- ================================================================
-- index 1: 1 screen
-- index 2: 2 screens
local layoutOrder = {
  {
    "LAYOUT_SINGLE_SCREEN",
    "LAYOUT_SINGLE_SCREEN_MOBILE",
  },
  {
    "LAYOUT_WORKATHOME_WEB",
    "LAYOUT_WORKATHOME_MOBILE",
    "LAYOUT_WORK_WEB",
    "LAYOUT_WORK_MOBILE",
    "LAYOUT_HOME_WEB",
  }
}

local actuallyMainPos = {
  LAYOUT_SINGLE_SCREEN = "centerPos",
  LAYOUT_SINGLE_SCREEN_MOBILE = "centerPos",
  LAYOUT_WORKATHOME_WEB = "centerPos",
  LAYOUT_WORKATHOME_MOBILE = "southEastPos",
  LAYOUT_WORK_WEB = "centerPos",
  LAYOUT_WORK_MOBILE = "southEastPos",
  LAYOUT_HOME_WEB = "centerPos",
}

-- rect: x, y, width, height
-- origin is top left of screen
local layouts = {
  -- 1 screen layouts
  LAYOUT_SINGLE_SCREEN = {
    centerPos = hs.geometry.rect(0.05, 0.05, 0.9, 0.95),
    southWestPos = hs.geometry.rect(0, 0.315, 0.5, 0.7),
    northWestPos = hs.geometry.rect(0, 0, 0.9, 0.95),
    northPos = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.7),
    southEastPos = hs.geometry.rect(0.1, 0, 0.9, 1),
  },
  LAYOUT_SINGLE_SCREEN_MOBILE = {
    centerPos = hs.geometry.rect(0.05, 0.05, 0.9, 0.95),
    southWestPos = hs.geometry.rect(0.2, 0.15, 0.5, 0.85),
    northWestPos = hs.geometry.rect(0, 0, 0.6, 0.75),
    northPos = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.7),
    southEastPos = hs.geometry.rect(0.1, 0, 0.9, 1),
  },
  -- 2 screen layouts
  LAYOUT_WORKATHOME_WEB = {
    centerPos = hs.geometry.rect(0.25, 0.2, 0.74, 0.65),
    southWestPos = hs.geometry.rect(0, 0.5, 0.26, 0.5),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5),
    northPos = hs.geometry.rect(0.1, 0, 1.0, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    southEastPos = hs.geometry.rect(0.75, 0.2, 0.15, 0.65),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_WORKATHOME_MOBILE = {
    centerPos = hs.geometry.rect(0.2, 0.2, 0.2, 0.67),
    southWestPos = hs.geometry.rect(0, 0.5, 0.26, 0.5),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5),
    northPos = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    northEastPos = hs.geometry.rect(0.7, 0, 0.3, 0.5),
    southEastPos = hs.geometry.rect(0.2 + 0.2, 0.2, 0.5, 0.65),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_WORK_WEB = {
    centerPos = hs.geometry.rect(0.25, 0.17, 0.7, 0.65),
    southWestPos = hs.geometry.rect(0, 0.5, 0.26, 0.5),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5),
    northPos = hs.geometry.rect(0.1, 0, 1.0, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    southEastPos = hs.geometry.rect(0.75, 0.2, 0.15, 0.65),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_WORK_MOBILE = {
    centerPos = hs.geometry.rect(0.2, 0.25, 0.15, 0.67),
    southWestPos = hs.geometry.rect(0, 0.5, 0.26, 0.5),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5),
    northPos = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    northEastPos = hs.geometry.rect(0.7, 0, 0.3, 0.5),
    southEastPos = hs.geometry.rect(0.2 + 0.15, 0.15, 0.5, 0.67),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_HOME_WEB = {
    centerPos = hs.geometry.rect(0.5, 0.2, 0.50, 0.65),
    southWestPos = hs.geometry.rect(0.10, 0.2, 0.40, 0.65),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5),
    northPos = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    southEastPos = hs.geometry.rect(0.7, 0.39, 0.3, 0.5),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
}

-- module exports
return {
  actuallyMainPos = actuallyMainPos,
  initialApps = initialApps,
  layouts = layouts,
  layoutOrder = layoutOrder,
}
