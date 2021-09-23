# PMC-CALLBACKS [STANDALONE]
## Installation [EN]
- Download the latest version of `pmc-callbacks`
- Unzip the file and add to your resources folder `pmc-callbacks`
- Add to your .cfg file `ensure pmc-callbacks`
## Usage [EN]
- Add to your fxmanifest resource file `shared_script '@pmc-callbacks/import.lua'`
## Instalación [ES]
- Descarga la última versión de `pmc-callbacks`
- Descomprime el archivo y añade a tu carpeta resources `pmc-callbacks`
- Añade a tu archivo .cfg `ensure pmc-callbacks`
## Uso [ES]
- Añade a tu archivo fxmanifest `shared_script '@pmc-callbacks/import.lua'`
---
### Methods / Métodos
##### server-side
| global function | params | return |
|-----------------|--------|--------|
| RegisterServerCallback | eventName `string` \| eventCallback `function` | `table` |
| UnregisterServerCallback | eventData `table` | `nil` |
| TriggerClientCallback | source `string``number` \| eventName `string` \| args `table` _\| timeout `number` \| timedout `function` \| callback `function`_ | `any` |
| TriggerServerCallback | source `string``number` \| eventName `string` \| args `table` _\| timeout `number` \| timedout `function` \| callback `function`_ | `any` |
##### client-side
| global function | params | return |
|-----------------|--------|--------|
| RegisterClientCallback | eventName `string` \| eventCallback `function` | `table` |
| UnregisterClientCallback | eventData `table` | `nil` |
| TriggerServerCallback | eventName `string` \| args `table` _\| timeout `number` \| timedout `function` \| callback `function`_ | `any` |
| TriggerClientCallback | eventName `string` \| args `table` _\| timeout `number` \| timedout `function` \| callback `function`_ | `any` |
---
### Example / Ejemplo
##### client-side
```lua
-- inside the fxmanifest
-- you can @import with "shared_script '@pmc-callbacks/import.lua'"
-- or just use the provided exports

-- synchronous request
RegisterCommand('requestserver', function(s, args)
    local result = TriggerServerCallback {
        eventName = 'pmc-test:testingAwesomeCallback',
        args = {'some', 'args', 'here'}
    }
    print('gotcha', result)
end)

-- asynchronous request (same for server-side!)
RegisterCommand('requestserverasync', function(s, args)
    TriggerServerCallback {
        eventName = 'pmc-test:testingAwesomeCallback',
        args = {'some', 'args', 'here'},
        callback = function(result)
            print('gotcha', result)
        end
    }
end)

local eventdata = RegisterClientCallback {
    eventName = 'pmc-test:requestSomething',
    eventCallback = function(...)
        -- your awesome code here!
        return 'return something'
    end
}

-- want to remove the callback?
UnregisterClientCallback(eventdata) -- from RegisterClientCallback ↑
```
##### server-side
```lua
RegisterServerCallback {
    eventName = 'pmc-test:testingAwesomeCallback',
    eventCallback = function(source, ...)
        -- your awesome code here!
        return 'return something'
    end
}

RegisterCommand('requestclient', function(s, args)
    local target = tonumber(args[1])
    local result = TriggerClientCallback {
        source = target,
        eventName = 'pmc-test:requestSomething',
        args = {'some', 'args', 'here'}
    }
    print('gotcha', result)
end)
```