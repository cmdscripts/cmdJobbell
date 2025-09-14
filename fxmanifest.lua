fx_version 'cerulean'
game 'gta5'

author 'cmdscripts'
version '2.0'
description 'Job Bell System with OX Target and Marker support'

lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

dependencies {
    'es_extended',
    'ox_lib'
}

optional_dependencies {
    'ox_target'
}
