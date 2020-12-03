# PMC-CALLBACKS SYSTEM
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
| RegisterServerCallback | eventName `string` \| callback `function` | `nil` |
| TriggerClientCallback | target `number` \| eventName `string` \| *args `any` | `any` |
##### client-side
| global function | params | return |
|-----------------|--------|--------|
| RegisterClientCallback | eventName `string` \| callback `function` | `nil` |
| TriggerServerCallback | eventName `string` \| *args `any` | `any` |
---
### Example / Ejemplo
##### client-side
```lua
RegisterCommand('requestserver', function(s, args)
    local result = TriggerServerCallback('pmc-test:testingAwesomeCallback')
    print('gotcha', result)
end)

RegisterClientCallback('pmc-test:requestSomething', function(...)
    -- stuff code
    return true -- return any
end)
```
##### server-side
```lua
RegisterServerCallback('pmc-test:testingAwesomeCallback', function(source, ...)
    -- stuff code
    return true -- return any
end)

RegisterCommand('requestclient', function(s, args)
    local target = tonumber(args[1])
    local result = TriggerClientCallback(target, 'pmc-test:requestSomething')
    print('gotcha', result)
end)
```