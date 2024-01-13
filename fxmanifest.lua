fx_version 'bodacious'
game { 'gta5' }

author 'h0ldhaven'
description 'Admin tools'
version '1.1.2'

clr_disable_task_scheduler 'yes'

client_scripts {
    "lib/i18n.lua",
    "locales/fr.lua",
    "config/config.lua",
    "config/notifications.lua",

    "client/client.lua",
    "client/menu.lua",

    "client/poshud.lua",
    "client/reboot_cl.lua",
    "client/annonce_alpha_cl.lua",
    "client/adminskin_cl.lua",
    "client/admincar_cl.lua",
    "client/depanneurs_dev.lua",
    "client/teleportation_cl.lua",
    "client/noclip_cl.lua",
    "client/visiblemode_cl.lua",
    "client/tablist_cl.lua"
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
