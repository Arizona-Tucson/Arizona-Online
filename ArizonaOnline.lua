local url = "https://api.arizona-five.com/launcher/servers"
function main()
    while not isSampAvailable() do wait(0) end
    sampRegisterChatCommand('online',function (num)
        if tonumber(num) > 0 and tonumber(num) <= 32 then
            local res = require('requests').get(url)
            if (res.status_code  == 200) then
                local data = res.json()
                for i, po in pairs(data.arizona) do
                    if po.number == tonumber(num) then
                        sampAddChatMessage(('{CCCCCC}[ASS]{FFFFFF} Name: %s :d | online: %s/%s :worm: | queue: %s :|'):format(po.name, po.online, po.maxplayers, po.queue), -1)
                    end
                end
            end
        end
    end)    
    while true do wait(-1) end
end
