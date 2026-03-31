local url = "https://api.arizona-five.com/launcher/servers"
local requests = require('requests') -- ëó÷øå âûíåñòè â íà÷àëî

function main()
    while not isSampAvailable() do wait(0) end
    
    sampRegisterChatCommand('online', function(arg)
        local num = tonumber(arg) -- ïğåîáğàçóåì îäèí ğàç
        
        -- Ïğîâåğÿåì, ÷òî ââåäåíî èìåííî ÷èñëî, ÷òîáû íå áûëî îøèáêè nil
        if num and num > 0 and num <= 32 then
            local res = requests.get(url)
            if res.status_code == 200 then
                local data = res.json()
                -- Ïğîâåğÿåì íàëè÷èå òàáëèöû arizona â îòâåòå
                if data and data.arizona then
                    local found = false
                    for i, po in pairs(data.arizona) do
                        if tonumber(po.number) == num then
                            sampAddChatMessage(('{CCCCCC}[ASS]{FFFFFF} Name: %s | online: %s/%s | queue: %s'):format(po.name, po.online, po.maxplayers, po.queue), -1)
                            found = true
                            break
                        end
                    end
                    if not found then sampAddChatMessage("Ñåğâåğ ñ òàêèì íîìåğîì íå íàéäåí.", -1) end
                end
            else
                sampAddChatMessage("Îøèáêà ïğè çàïğîñå ê API: " .. res.status_code, -1)
            end
        else
            sampAddChatMessage("Èñïîëüçóéòå: /online [1-32]", -1)
        end
    end)    
    
    wait(-1)
end
