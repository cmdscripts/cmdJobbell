fx_version 'adamant'
games {'gta5'}
author 'cmdscripts'
version '1.3'

shared_scripts { "config.lua" }

client_scripts {
    "client.lua",
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server.lua",
}
