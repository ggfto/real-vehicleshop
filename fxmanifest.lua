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

shared_script {
    "config/config.lua",
    "locales.lua",
    "config/vehicleshops.lua",
    "language/*.lua",
    "GetFrameworkObject.lua"
}

client_scripts {
    "config/client_config.lua",
    "client/*.lua"
}
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "config/server_config.lua",
    "server/*.lua"
}
