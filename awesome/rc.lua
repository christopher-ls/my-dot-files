-- If LuaRocks is installed, make sure that packages installed through it are found.
pcall(require, "luarocks.loader")

-- Load required libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local wibox = require("wibox")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Theme initialization
beautiful.init(gears.filesystem.get_configuration_dir() .. "themes/gruvbox/theme.lua")
beautiful.font = "Hack Nerd Font 10"
beautiful.useless_gap = 20

-- Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Startup Errors",
                     text = awesome.startup_errors })
end

awesome.connect_signal("debug::error", function (err)
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Runtime Error",
                     text = tostring(err) })
end)

-- Variable definitions
local terminal = "kitty"
local editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = terminal .. " -e " .. editor
local modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
}

-- Menu setup
local myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

local mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal },
    },
})

local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
menubar.utils.terminal = terminal

-- Widgets
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify") -- Spotify widget
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
-- Screen and Wibar setup
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper setup
    local function set_wallpaper(s)
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end

    set_wallpaper(s)
    screen.connect_signal("property::geometry", set_wallpaper)

    -- Tags
    awful.tag({ "󰊗", "", "", "", "", "", "", "", "9" }, s, awful.layout.layouts[1])

    -- Promptbox, layoutbox, taglist, tasklist
    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = gears.table.join(
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then client.focus:move_to_tag(t) end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then client.focus:toggle_tag(t) end
            end),
            awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
        ),
    }
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = gears.table.join(
            awful.button({}, 1, function(c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal("request::activate", "tasklist", { raise = true })
                end
            end),
            awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 150 } }) end)
        ),
    }

    -- Wibar setup
    s.mywibox = awful.wibar({ position = "top", screen = s })
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.keyboardlayout(),
            wibox.widget.systray(),
            wibox.widget.textclock("%I:%M"),
            spotify_widget(), -- Default Spotify widget
            spotify_widget({ -- Customized Spotify widget
                font = "Hack Nerd Font 10",
                play_icon = "/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg",
                pause_icon = "/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg",
            }),
            volume_widget(), -- Default volume widget
            volume_widget({ -- Customized volume widget
                widget_type = 'arc',
            }),
            logout_menu_widget(), -- Default logout widget
            logout_menu_widget({ -- Customized logout widget
                font = "Hack Nerd Font 10",
                onlock = function()
                    awful.spawn.with_shell("i3lock-fancy")
                end,
            }),
            s.mylayoutbox,
        },
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::move", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
-- Key bindings
local globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end, { description = "open terminal", group = "launcher" }),
    awful.key({ modkey }, "r", function() awful.spawn("rofi -show drun") end, { description = "run rofi", group = "launcher" }),
    awful.key({ modkey }, "b", function() awful.spawn("firefox") end, { description = "launch firefox", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
    awful.key({modkey, }, "f", function() awful.spawn("pcmanfm") end, {descripton ="lanuch filebrower", group = "launcher"}),
    -- Restore minimized client
    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        if c then
            c:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
    end, { description = "restore minimized", group = "client" })
)

local clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "c", function(c)
        c:kill()
    end, { description = "close client", group = "client" })
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function (c) c.fullscreen = not c.fullscreen; c:raise() end, {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey }, "c", function (c) c:kill() end, {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
    awful.key({ modkey }, "o", function (c) c:move_to_screen() end, {description = "move to screen", group = "client"}),
    awful.key({ modkey }, "t", function (c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey }, "n", function (c) c.minimized = true end , {description = "minimize", group = "client"}),
    awful.key({ modkey }, "m", function (c) c.maximized = not c.maximized; c:raise() end , {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m", function (c) c.maximized_vertical = not c.maximized_vertical; c:raise() end , {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift" }, "m", function (c) c.maximized_horizontal = not c.maximized_horizontal; c:raise() end , {description = "(un)maximize horizontally", group = "client"})
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, {description = "toggle tag #" .. i, group = "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, {description = "move focused client to tag #"..i, group = "tag"}),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = false}) end),
    awful.button({ modkey }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = false}); awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function (c) c:emit_signal("request::activate", "mouse_click", {raise = false}); awful.mouse.client.resize(c) end)
)

root.keys(globalkeys)

-- Rules
awful.rules.rules = {
    { rule = { },
      properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus = awful.client.focus.filter,
          raise = true,
          keys = clientkeys,
          screen = awful.screen.preferred,
          placement = awful.placement.no_overlap + awful.placement.no_offscreen
     }
    }
}

-- Signals
client.connect_signal("manage", function(c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Autostart
awful.spawn.with_shell("picom")
awful.spawn.with_shell("feh --bg-scale wallpapers/gruvbox/board.jpg")
awful.spawn.with_shell("/home/christopher/.screenlayout/sreenlayoy.sh")
awful.spawn.with_shell("bluetoothctl power on")
awful.spawn.with_shell("xfce4-clipman")