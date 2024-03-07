fx_version 'bodacious'
game { 'gta5' }

author 'h0ldhaven'
description 'Admin tools'
version '1.2.0'

clr_disable_task_scheduler 'yes'

client_scripts {
    "lib/i18n.lua",
    "locales/fr.lua",
    "config/config.lua",
    "config/notifications.lua",

    "client/client.lua",
    "client/menu.lua",

    "client/poshud.lua",
    "client/reboot.lua",
    "client/annonce_alpha.lua",
    "client/adminskin.lua",
    "client/admincar.lua",
    "client/depanneurs_dev.lua",
    "client/teleportation.lua",
    "client/noclip.lua",
    "client/visiblemode.lua",
    "client/tablist.lua"
}

server_scripts {
    "lib/i18n.lua",
    "locales/fr.lua",
    "config/config.lua",

    "server/server.lua",
    "server/adminChecker.lua",
    "server/versionChecker.lua",

    "@mysql-async/lib/MySQL.lua"
}

shared_scripts {
    "@es_extended/imports.lua",   
}
