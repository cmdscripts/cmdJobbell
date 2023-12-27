fx_version 'adamant'
games {'gta5'}
author 'cmdscripts'
version '1.5'

shared_scripts { "config.lua" , '@es_extended/imports.lua'}
client_script { "client.lua", }
server_scripts { "@mysql-async/lib/MySQL.lua", "server.lua", }