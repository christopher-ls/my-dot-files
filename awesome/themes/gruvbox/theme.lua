-- Gruvbox Theme for AwesomeWM

local theme = {}

theme.font = "Hack Nerd Font 10"

-- Gruvbox color palette
theme.bg_normal     = "#282828"
theme.bg_focus      = "#3c3836"
theme.bg_urgent     = "#cc241d"
theme.bg_minimize   = "#504945"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#ebdbb2"
theme.fg_focus      = "#fabd2f"
theme.fg_urgent     = "#fb4934"
theme.fg_minimize   = "#928374"

theme.border_width  = 2
theme.border_normal = "#282828"
theme.border_focus  = "#fabd2f"
theme.border_marked = "#fb4934"

-- Taglist
theme.taglist_fg_focus = "#fabd2f"
theme.taglist_bg_focus = "#3c3836"
theme.taglist_fg_occupied = "#8ec07c"
theme.taglist_fg_empty = "#928374"
theme.taglist_fg_urgent = "#fb4934"

-- Tasklist
theme.tasklist_bg_focus = "#3c3836"
theme.tasklist_fg_focus = "#ebdbb2"
theme.tasklist_bg_normal = "#282828"
theme.tasklist_fg_normal = "#ebdbb2"
theme.tasklist_bg_urgent = "#cc241d"
theme.tasklist_fg_urgent = "#ebdbb2"

-- Titlebar
theme.titlebar_bg_focus  = "#3c3836"
theme.titlebar_fg_focus  = "#ebdbb2"
theme.titlebar_bg_normal = "#282828"
theme.titlebar_fg_normal = "#ebdbb2"

-- Menu
theme.menu_height = 20
theme.menu_width  = 150
theme.menu_bg_normal = "#282828"
theme.menu_fg_normal = "#ebdbb2"
theme.menu_bg_focus = "#3c3836"
theme.menu_fg_focus = "#ebdbb2"

-- Wallpaper
theme.wallpaper = "~/.config/awesome/themes/gruvbox/wallpaper.png"

-- Layout icons
theme.layout_tile = "~/.config/awesome/themes/gruvbox/layouts/tile.png"
theme.layout_floating  = "~/.config/awesome/themes/gruvbox/layouts/floating.png"

-- Icon theme
theme.icon_theme = "Papirus-Dark"

-- Return the theme
return theme
