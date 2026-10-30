local ServerScanner = {}

local HttpService = game:GetService("HttpService")

local PLACE_ID = 107778070777162
local BASE_URL = "https://games.roblox.com/v1/games/"

function ServerScanner.GetPublicServers(cursor)
    local url = BASE_URL .. PLACE_ID .. "/servers/Public?sortOrder=Asc&limit=100"

    if cursor then
        url = url .. "&cursor=" .. HttpService:UrlEncode(cursor)
    end

    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)

    if not success then
        return nil, "Impossible de récupérer les serveurs"
    end

    local data = HttpService:JSONDecode(response)

    return {
        servers = data.data or {},
        nextCursor = data.nextPageCursor
    }
end

return ServerScanner
