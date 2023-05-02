-- Standard awesome library
local gears = require("gears")
local beautiful = require("beautiful")

-- {{{ Random Wallpapers
local function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
		tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end

-- Get the list of files from a directory. Must be all images or folders and non-empty.
local function scan_dir(directory)
	local i, file_list, popen = 0, {}, io.popen
	for filename in popen([[find "]] .. directory .. [[" -type f]]):lines() do
		i = i + 1
		file_list[i] = filename
	end
	shuffle(file_list)
	return file_list
end

local wallpaper_list = scan_dir("/home/ema2159/Pictures/ArtWP/")

-- Apply a random wallpaper on startup.
gears.wallpaper.maximized(wallpaper_list[math.random(1, #wallpaper_list)], s, true)

-- Apply a random wallpaper every changeTime seconds.
local change_time = 600
local wallpaper_timer = timer({ timeout = change_time })
wallpaper_timer:connect_signal("timeout", function()
	gears.wallpaper.maximized(wallpaper_list[math.random(1, #wallpaper_list)], s, true)

	-- stop the timer (we don't need multiple instances running at the same time)
	wallpaper_timer:stop()

	--restart the timer
	wallpaper_timer.timeout = change_time
	wallpaper_timer:start()
end)

-- initial start when rc.lua is first run
wallpaper_timer:start()
-- }}}

local function set_wallpaper(s)
	gears.wallpaper.maximized(wallpaper_list[math.random(1, #wallpaper_list)], s, true)
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
