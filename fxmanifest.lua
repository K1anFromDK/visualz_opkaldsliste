fx_version 'cerulean'
game 'gta5'

lua54 'yes'
description 'Calllist made by Visualz Development'
author 'Visualz Development <support@visualz.dk>'
version '1.0.0'


ui_page 'dist/index.html'
file 'dist/**/*'

client_script 'client/**/*'

server_scripts {
	'server/**/*',
	'@oxmysql/lib/MySQL.lua',
}

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua',
}

escrow_ignore {
	'server/exports.lua',
	'client/exports.lua',
	'config.lua'
}
