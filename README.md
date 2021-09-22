# PMC-CALLBACKS

## Installation [EN]

- Download the latest version of `pmc-callbacks` from the release section on GitHub
- Unzip the file and add to your resources folder `pmc-callbacks`
- Add to your .cfg file `ensure pmc-callbacks`

## Usage [EN]

- Add `shared_script '@pmc-callbacks/import.lua'` to your resource manifest file

## Instalación [ES]

- Descarga la última versión de `pmc-callbacks`
- Descomprime el archivo y añade a tu carpeta resources `pmc-callbacks`
- Añade a tu archivo .cfg `ensure pmc-callbacks`

## Uso [ES]

- Añade a tu archivo fxmanifest `shared_script '@pmc-callbacks/import.lua'`

## Methods / Métodos

### Server:

| Global function | params | return |
|-----------------|--------|--------|
| RegisterServerCallback | eventName `string` \| callback `function` | `nil` |
| TriggerClientCallback | target `number` \| timeout `number` \| eventName `string` \| *args `any` | `any` |

### Client:
| Global function | params | return |
|-----------------|--------|--------|
| RegisterClientCallback | eventName `string` \| callback `function` | `nil` |
| TriggerServerCallback | eventName `string` \| timeout `number` \| *args `any` | `any` |

### Example / Ejemplo:

### Client:
```lua
RegisterCommand('requestserver', function(s, args)
  local timeout = tonumber(args[1])
  local status, result = pcall(TriggerServerCallback, timeout, 'pmc-test:testingAwesomeCallback')
  if status then
    print('Gotcha', result)
  else
    print(result.err)
    -- Timeout reached
  end
end)

RegisterClientCallback('pmc-test:requestSomething', function(...)
    -- code
    return true -- return any
end)
```

#### Server:
```lua
RegisterServerCallback('pmc-test:testingAwesomeCallback', function(source, ...)
  -- code
  return true -- return any
end)

RegisterCommand('requestclient', function(s, args)
  local serverId = tonumber(args[1])
  local timeout = tonumber(args[2])

  local status, result = pcall(TriggerClientCallback, target, timeout, 'pmc-test:requestSomething')

  if status then
    print('Gotcha', result)
  else
    print(result.err)
    -- Timeout reached
  end
end)
```
