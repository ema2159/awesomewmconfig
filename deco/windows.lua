local beautiful = require("beautiful")
local awful = require("awful")

-- Use picom as compositor
awful.spawn.with_shell("picom --experimental-backends &")

-- Gaps
beautiful.gap_single_client = true
beautiful.useless_gap = 5

