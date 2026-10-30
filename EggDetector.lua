local EggDetector = {}

function EggDetector.Filter(eggs, minimumGain)
    local results = {}

    for _, egg in ipairs(eggs) do
        if type(egg.gain) == "number"
            and egg.gain >= minimumGain
            and egg.available == true then
            table.insert(results, egg)
        end
    end

    table.sort(results, function(a, b)
        return a.gain > b.gain
    end)

    return results
end

return EggDetector
