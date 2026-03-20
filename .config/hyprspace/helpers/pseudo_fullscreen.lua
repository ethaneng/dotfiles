-- Hammerspoon script for smooth pseudo-fullscreen animation
-- Called by toggle_pseudo_fullscreen.sh

local MARGIN = 80
local ANIMATION_DURATION = 0.25  -- seconds
local FPS = 60  -- frames per second for smooth animation
local ASPECT_RATIO = 16 / 9

local win = hs.window.focusedWindow()
if not win then
    print("No focused window")
    os.exit(1)
end

-- Get current and target frames
local screen = win:screen()
local screenFrame = screen:frame()
local startFrame = win:frame()

-- Calculate centered 16:9 window dimensions
local maxWidth = screenFrame.w - (MARGIN * 2)
local maxHeight = screenFrame.h - (MARGIN * 2)

-- Calculate dimensions maintaining aspect ratio
local calculatedHeight = maxWidth / ASPECT_RATIO
local windowWidth, windowHeight

if calculatedHeight > maxHeight then
    -- Constrain by height
    windowHeight = maxHeight
    windowWidth = windowHeight * ASPECT_RATIO
else
    -- Constrain by width
    windowWidth = maxWidth
    windowHeight = calculatedHeight
end

-- Calculate centered position
local targetFrame = {
    x = screenFrame.x + (screenFrame.w - windowWidth) / 2,
    y = screenFrame.y + (screenFrame.h - windowHeight) / 2,
    w = windowWidth,
    h = windowHeight
}

-- Easing function (ease-out cubic for smooth deceleration)
local function easeOutCubic(t)
    return 1 - math.pow(1 - t, 3)
end

-- Instant resize to avoid choppy animation (macOS limitation)
-- Resizing forces app redraws which causes choppiness no matter the FPS
win:setFrame(targetFrame, 0)

print(string.format("Set frame to: %.0fx%.0f at (%.0f, %.0f)",
    targetFrame.w, targetFrame.h, targetFrame.x, targetFrame.y))
