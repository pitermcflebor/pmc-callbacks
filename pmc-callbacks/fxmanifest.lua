fx_version 'cerulean'
game 'gta5'

author 'Piter McFlebor'
description 'Standalone callback system by PiterMcFlebor'
version '2.0'

shared_scripts {
    'import.lua',
    --'export.lua'
}

-- client-export
exports {
    'RegisterClientCallback',
    'UnregisterClientCallback',
    'TriggerClientCallback',
    'TriggerServerCallback',
}

-- server-export
server_exports {
    'RegisterServerCallback',
    'UnregisterServerCallback',
    'TriggerClientCallback',
    'TriggerServerCallback',
}