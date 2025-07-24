--!strict
local Bypasser = {}

-- Table 1: Original words with unique IDs
local originalWords = {
    ["fuck"] = 1,
    ["shit"] = 2,
    ["ass"] = 3,
    ["discord"] = 4,
    ["nigga"] = 5,
    ["dick"] = 6,
    ["pussy"] = 7,
    ["sex"] = 8,
    -- Add more words here: ["word"] = ID
}

-- Table 2: Bypassed versions by ID
local bypassedVersions = {
    [1] = "⌝fษcׂׂׂk⌝",
    [2] = "⌝ธhῘtִִִ⌝",
    [3] = "⌝αִִִʂִִִʂִִִ⌝",
    [4] = "⌝dỈִִִธcorִִִd⌝",
    [5] = "this word got patched. Please try bypassing a different word.",
    [6] = "⌝dỈִִִcׂׂׂҡִִִ⌝",
    [7] = "⌝pษʂִִִʂִִִy⌝",
    [8] = "⌝ʂִִִexִִׇﹺ⌝",
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
