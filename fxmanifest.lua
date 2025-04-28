fx_version "cerulean"
game "gta5"
author "codeReal"
description "Made by codeReal"
lua54 "yes"
use_experimental_fxv2_oal "yes"

ui_page {
    "html/index.html"
}

files {
    "html/**/*"
}

shared_scripts {
    "@ox_lib/init.lua",
    "shared/*.lua",
    "config/config.lua",
    "config/vehicleshops.lua",
    "language/*.lua"
}

client_scripts {
    "config/client_config.lua",
    "client/**/*.lua"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/server_config.lua",
    "server/**/*.lua"
}

dependencies {
    "ox_lib",
    "oxmysql"
}
