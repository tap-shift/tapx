--!strict
local Bypasser = {}

-- Table 1: Original words with unique IDs
local originalWords = {
    ["fuck"] = 1,
    ["shit"] = 2,
    ["ass"] = 3,
    -- Add more words here: ["word"] = ID
}

-- Table 2: Bypassed versions by ID
local bypassedVersions = {
    [1] = "ƒü¢k",
    [2] = "$h!t",
    [3] = "å§§",
    -- Add more bypassed versions here: [ID] = "bypassed_text"
}

function Bypasser.bypassText(text: string): string
    local words = string.split(text, " ")
    local result = {}
    
    for _, word in ipairs(words) do
        local lowerWord = string.lower(word)
        if originalWords[lowerWord] then
            local id = originalWords[lowerWord]
            table.insert(result, bypassedVersions[id] or word)
        else
            table.insert(result, word)
        end
    end
    
    return table.concat(result, " ")
end

function Bypasser.copyToClipboard(text: string)
    if setclipboard then
        setclipboard(text)
    end
end

return Bypasser
