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
    northPos = {"Terminal"},
    northEastPos = {},
    southEastPos = {"Hammerspoon"},
  },
  LAYOUT_WORK_WEB = {
    centerPos = {"Chrome"},
    southPos = {"Emacs", "Sketch"},
    southWestPos = {"iTerm"},
    northWestPos = {"Slack"},
    northPos = {"Terminal"},
    northEastPos = {},
    southEastPos = {"Hammerspoon"},
  },
  LAYOUT_HOME_MOBILE = {
    centerPos = {"Simulator"},
    southPos = {"Emacs"},
    southWestPos = {"iTerm"},
    northWestPos = {},
    northPos = {"Terminal"},
    northEastPos = {},
    southEastPos = {"Chrome"},
  },
  LAYOUT_HOME_WEB = {
    centerPos = {"Chrome"},
    southPos = {"Emacs"},
    southWestPos = {"iTerm"},
    northWestPos = {},
    northPos = {"Terminal"},
    northEastPos = {},
    southEastPos = {"Hammerspoon"},
  },
  LAYOUT_CYPRESS = {
    centerPos = {"Firefox"},
    southPos = {"Emacs"},
    southWestPos = {"Chrome"},
    northWestPos = {"Slack"},
    northPos = {"Cypress"},
    northEastPos = {"iTerm"},
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
    "LAYOUT_WORK_WEB",
    "LAYOUT_CYPRESS",
    "LAYOUT_HOME_MOBILE",
    "LAYOUT_HOME_WEB",
  }
}

local actuallyMainPos = {
  LAYOUT_SINGLE_SCREEN = "centerPos",
  LAYOUT_SINGLE_SCREEN_MOBILE = "centerPos",
  LAYOUT_WORKATHOME_WEB = "centerPos",
  LAYOUT_WORK_WEB = "centerPos",
  LAYOUT_HOME_MOBILE = "centerPos",
  LAYOUT_HOME_WEB = "centerPos",
  LAYOUT_CYPRESS = "centerPos",
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
    centerPos = hs.geometry.rect(0.45, 0, 0.5, 1),
    southWestPos = hs.geometry.rect(0.13, 0.175, 0.5, 0.85),
    northWestPos = hs.geometry.rect(0, 0, 0.6, 0.85),
    northPos = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.7),
    southEastPos = hs.geometry.rect(0.1, 0.02, 0.9, 0.98),
  },
  -- 2 screen layouts
  LAYOUT_WORKATHOME_WEB = {
    centerPos = hs.geometry.rect(0.28, 0.23, 0.72, 0.65),
    southWestPos = hs.geometry.rect(0, 0.5, 0.28, 0.5),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5),
    northPos = hs.geometry.rect(0.3, 0, 0.5, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    southEastPos = hs.geometry.rect(0.75, 0.2, 0.15, 0.65),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_WORK_WEB = {
    centerPos = hs.geometry.rect(0.3, 0.19, 0.7, 0.65),
    southWestPos = hs.geometry.rect(0, 0.5, 0.3, 0.5),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5),
    northPos = hs.geometry.rect(0.3, 0, 0.5, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    southEastPos = hs.geometry.rect(0.75, 0.2, 0.15, 0.65),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_HOME_MOBILE = {
    centerPos = hs.geometry.rect(0.35, 0.25, 0.15, 0.67),
    southWestPos = hs.geometry.rect(0, 0.20, 0.35, 0.67),
    northWestPos = hs.geometry.rect(0, 0, 0.3, 0.5), -- unused
    northPos = hs.geometry.rect(0.3, 0, 0.3, 0.4),
    northEastPos = hs.geometry.rect(0.7, 0, 0.3, 0.5), -- unused
    southEastPos = hs.geometry.rect(0.5, 0.20, 0.5, 0.67),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_HOME_WEB = {
    centerPos = hs.geometry.rect(0.4, 0.2, 0.60, 0.65),
    southWestPos = hs.geometry.rect(0, 0.2, 0.40, 0.65),
    northWestPos = hs.geometry.rect(0, 0, 0.4, 0.6),
    northPos = hs.geometry.rect(0.4, 0, 0.4, 0.4),
    northEastPos = hs.geometry.rect(0.5, 0, 0.5, 0.75),
    southEastPos = hs.geometry.rect(0.7, 0.39, 0.3, 0.5),
    southPos = hs.geometry.rect(0, 0, 1, 1),
  },
  LAYOUT_CYPRESS = {
    centerPos = hs.geometry.rect(0.4, 0.2, 0.60, 0.65),
    southWestPos = hs.geometry.rect(0, 0.2, 0.40, 0.65),
    northWestPos = hs.geometry.rect(0, 0, 0.4, 0.6),
    northPos = hs.geometry.rect(0.4, 0, 0.4, 0.4),
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
