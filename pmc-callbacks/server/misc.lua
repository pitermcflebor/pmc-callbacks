
RegisterNetEvent('__pmc_callback:server')
AddEventHandler('__pmc_callback:server', function(eventName, ticket, ...)
	local s = source
	local p = promise.new()

	TriggerEvent('s__pmc_callback:'..eventName, function(...)
		p:resolve({...})
	end, s, ...)

	local result = Citizen.Await(p)
	TriggerClientEvent(('__pmc_callback:client:%s:%s'):format(eventName, ticket), s, table.unpack(result))
end)
