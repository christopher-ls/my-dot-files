-- Dracula Theme for AwesomeWM

local theme = {}

theme.font = "Hack Nerd Font 10"

-- Dracula color palette
theme.bg_normal     = "#282a36"
theme.bg_focus      = "#44475a"
theme.bg_urgent     = "#ff5555"
theme.bg_minimize   = "#44475a"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#f8f8f2"
theme.fg_focus      = "#50fa7b"
theme.fg_urgent     = "#ff5555"
theme.fg_minimize   = "#f8f8f2"

theme.border_width  = 2
theme.border_normal = "#282a36"
theme.border_focus  = "#bd93f9"
theme.border_marked = "#ff79c6"

-- Taglist
theme.taglist_fg_focus = "#ff79c6"
theme.taglist_bg_focus = "#282a36"
theme.taglist_fg_occupied = "#bd93f9"
theme.taglist_fg_empty = "#6272a4"
theme.taglist_fg_urgent = "#ff5555"

-- Tasklist
theme.tasklist_bg_focus = "#44475a"
theme.tasklist_fg_focus = "#f8f8f2"
theme.tasklist_bg_normal = "#282a36"
theme.tasklist_fg_normal = "#f8f8f2"
theme.tasklist_bg_urgent = "#ff5555"
theme.tasklist_fg_urgent = "#f8f8f2"

-- Titlebar
theme.titlebar_bg_focus  = "#44475a"
theme.titlebar_fg_focus  = "#f8f8f2"
theme.titlebar_bg_normal = "#282a36"
theme.titlebar_fg_normal = "#f8f8f2"

-- Menu
theme.menu_height = 20
theme.menu_width  = 150
theme.menu_bg_normal = "#282a36"
theme.menu_fg_normal = "#f8f8f2"
theme.menu_bg_focus = "#44475a"
theme.menu_fg_focus = "#f8f8f2"

-- Wallpaper
theme.wallpaper = "~/.config/awesome/themes/dracula/wallpaper.png"

-- Layout icons
theme.layout_tile = "~/.config/awesome/themes/dracula/layouts/tile.png"
theme.layout_floating  = "~/.config/awesome/themes/dracula/layouts/floating.png"

-- Icon theme
theme.icon_theme = "Papirus-Dark"

-- Cursor theme
theme.cursor_theme = "Dracula"
theme.cursor_size = 16

-- Return the theme
return theme
