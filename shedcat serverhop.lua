_G.ServerHopCommands = _G.ServerHopCommands or {}

local function serverHop(larger)
    local HttpService = game:GetService("HttpService")
    local TeleportService = game:GetService("TeleportService")
    local Players = game:GetService("Players")
    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"))
    local targetServer
    
    for _, server in ipairs(servers.data) do
        if server.id ~= game.JobId then
            if (larger and server.playing >= Players.NumPlayers) or (not larger and server.playing < Players.NumPlayers) then
                targetServer = server.id
                break
            end
        end
    end
    
    if targetServer then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, targetServer, Players.LocalPlayer)
    end
end

_G.ServerHopCommands["shedshopcat"] = function()
    serverHop(true)
end

_G.ServerHopCommands["smallshedshopcat"] = function()
    serverHop(false)
end

game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
    local command = msg:lower():gsub("%.", "")
    if _G.ServerHopCommands[command] then
        _G.ServerHopCommands[command]()
        print([[ 
88                                    88888888ba                                    
88                                    88      "8b                 ,d                
88                                    88      ,8P                 88                
88          88       88  8b,     ,d8  88aaaaaa8P'  8b       d8  MM88MMM  ,adPPYba,  
88          88       88   `Y8, ,8P'   88""""""8b,  `8b     d8'    88    a8P_____88  
88          88       88     )888(     88      `8b   `8b   d8'     88    8PP"""""""  
88          "8a,   ,a88   ,d8" "8b,   88      a8P    `8b,d8'      88,   "8b,   ,aa  
88888888888  `"YbbdP'Y8  8P'     `Y8  88888888P"       Y88'       "Y888  `"Ybbd8"'  
                                                       d8'                          
                                                      d8'                           
]])
        print("discord: luxbyte | made by luxbyte")
    end
end)