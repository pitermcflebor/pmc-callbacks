
-- SERVER-SIDE
if IsDuplicityVersion() then
	_G.RegisterServerCallback = function(eventName, fn)
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))
		assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got '..type(fn))

		AddEventHandler(('s__pmc_callback:%s'):format(eventName), function(cb, s, ...)
			local result = {fn(s, ...)}
			cb(table.unpack(result))
		end)
	end

	_G.TriggerClientCallback = function(src, eventName, timeout, ...)
		assert(type(src) == 'number', 'Invalid Lua type at argument #1, expected number, got '..type(src))
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #2, expected string, got '..type(eventName))
		assert(type(timeout) == 'number', 'Invalid Lua type at argument #3, expected number, got '..type(timeout))

		local result
		local p = promise.new()

		SetTimeout(timeout, function()
			p:resolve({false})
		end)

		local e = RegisterNetEvent('__pmc_callback:server:'..eventName, function(...)
			local s = source
			if src == s then
				p:resolve({...})
			end
		end)

		TriggerClientEvent('__pmc_callback:client', src, eventName, ...)

		result = Citizen.Await(p)

		RemoveEventHandler(e)
		return table.unpack(result)
	end
end

-- CLIENT-SIDE
if not IsDuplicityVersion() then
	_G.TriggerServerCallback = function(eventName, timeout, ...)
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))
		assert(type(timeout) == 'number', 'Invalid Lua type at argument #2, expected number, got '..type(timeout))

		local result
		local p = promise.new()
		local ticket = GetGameTimer()

		SetTimeout(timeout, function()
			p:resolve({false})
		end)

		local e = RegisterNetEvent(('__pmc_callback:client:%s:%s'):format(eventName, ticket), function(...)
			p:resolve({...})
		end)

		TriggerServerEvent('__pmc_callback:server', eventName, ticket, ...)

		result = Citizen.Await(p)

		RemoveEventHandler(e)
		return table.unpack(result)
	end
	
	_G.RegisterClientCallback = function(eventName, fn)
		assert(type(eventName) == 'string', 'Invalid Lua type at argument #1, expected string, got '..type(eventName))
		assert(type(fn) == 'function', 'Invalid Lua type at argument #2, expected function, got '..type(fn))

		AddEventHandler(('c__pmc_callback:%s'):format(eventName), function(cb, ...)
			cb(fn(...))
		end)
	end
end
