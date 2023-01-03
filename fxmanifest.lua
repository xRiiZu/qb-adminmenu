fx_version 'cerulean'
game 'gta5'

author 'ThriftShop'
description 'AdminMenu Made for the QBCore Framework'

ui_page 'html/index.html'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want
}

client_scripts {
    '@menuv/menuv.lua',
    'client/noclip.lua',
    'client/blipsnames.lua',
    'client/main.lua',
    'client/selfmenu.lua',
    'client/playersmenu.lua',
    'client/servermenu.lua',
    'client/vehiclemenu.lua',
    'client/devmenu.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/commands.lua',
}

files { 
    'html/index.html',
    'html/index.js'
}

dependency 'menuv'

lua54 'yes'
