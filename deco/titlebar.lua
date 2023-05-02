-- module("anybox.titlebar", package.seeall)

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local beautiful = require("beautiful")
local wibox = require("wibox")
local dpi = beautiful.xresources.apply_dpi

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = gears.table.join(
		awful.button({}, 1, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.move(c)
		end),
		awful.button({}, 3, function()
			c:emit_signal("request::activate", "titlebar", { raise = true })
			awful.mouse.client.resize(c)
		end)
	)

  pos = "top"
  bg = "#00000099"
  size = beautiful.titlebar_size

	awful.titlebar(c, { position = pos, bg = bg, size = size }):setup({
		{ -- Left
			layout = wibox.layout.fixed.horizontal,
		},
		{ -- Middle
			{ -- Title
				align = "center",
				widget = awful.titlebar.widget.titlewidget(c),
			},
			buttons = buttons,
			layout = wibox.layout.flex.horizontal,
		},
		{ -- Right
			awful.titlebar.widget.minimizebutton(c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.closebutton(c),
      spacing = dpi(7),
			layout = wibox.layout.fixed.horizontal(),
		},
		layout = wibox.layout.align.horizontal,
	})
end)

local function set_titlebar(client, s)
	if s then
		if client.titlebar == nil then
			client:emit_signal("request::titlebars", "rules", {})
		end
		awful.titlebar.show(client)
	else
		awful.titlebar.hide(client)
	end
end

--Toggle titlebar on floating status change
client.connect_signal("property::floating", function(c)
	set_titlebar(c, c.floating)
end)
